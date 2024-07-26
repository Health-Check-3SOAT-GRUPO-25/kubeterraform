locals {
  account_id = data.aws_caller_identity.current.account_id
  LabRoleArn = "arn:aws:iam::${local.account_id}:role/${var.LabRoleName}"
  PrincipalArn = "arn:aws:iam::${local.account_id}:role/${var.PrincipalRoleName}"
}

resource "aws_eks_cluster" "healthcheckcluster" {
  name     = var.cluster_name
  role_arn = local.LabRoleArn
  version  = var.cluster_version
 
 vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.security_group_id]
    endpoint_public_access = true
  }
  
  access_config {
    authentication_mode = var.acessConfig
  } 

  tags = {
    Environment = "development"
    Project     = var.project_name
  }
}


resource "aws_eks_node_group" "node_group_health" {
  cluster_name    = aws_eks_cluster.healthcheckcluster.name
  node_group_name = "node_group_health"
  node_role_arn   = local.LabRoleArn
  subnet_ids = var.subnet_ids


  scaling_config {
    desired_size = var.node_group_desired_capacity
    max_size     = var.node_group_max_capacity
    min_size     = var.node_group_min_capacity
  }

  instance_types = [var.node_group_instance_type]

  tags = {
    Environment = "development"
    Project     = var.project_name
  }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.healthcheckcluster.name
  addon_name    = "vpc-cni"
  addon_version = "v1.18.1-eksbuild.1"

  tags = {
    Environment = "development"
    Project     = var.project_name
  }
}

resource "aws_eks_access_policy_association" "policy" {
  cluster_name  = aws_eks_cluster.healthcheckcluster.name
  principal_arn = local.PrincipalArn
  policy_arn    = var.policyarn
  access_scope {
    type = "cluster"
  }
  depends_on = [
    aws_eks_cluster.healthcheckcluster
  ]
}

resource "aws_eks_access_entry" "access" {
  cluster_name      = aws_eks_cluster.healthcheckcluster.name
  principal_arn     = local.PrincipalArn
  kubernetes_groups = ["fiap", "pos-tech"]
  type              = "STANDARD"

  lifecycle {
    ignore_changes = [
      cluster_name,
      principal_arn,
      kubernetes_groups,
      type,
    ]
  }

  depends_on = [
    aws_eks_cluster.healthcheckcluster
  ]
}

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"

  set {
    name  = "args"
    value = "{--kubelet-preferred-address-types=InternalIP}"
  }

  set {
    name  = "replicas"
    value = "2"
  }

  depends_on = [
    aws_eks_cluster.healthcheckcluster,
    aws_eks_addon.vpc_cni,
    aws_eks_access_policy_association.policy,
    aws_eks_access_entry.access
  ]
}

