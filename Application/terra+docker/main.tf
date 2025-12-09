module "vpc" {
  source = "./modules/vpc"

  vpc_name            = var.vpc_name
  vpc_cidr_block      = var.vpc_cidr_block

  public_subnet_cidrs = var.public_subnet_cidrs
  public_subnet_azs   = var.public_subnet_azs

  private_subnet_cidrs = var.private_subnet_cidrs
  private_subnet_azs   = var.private_subnet_azs

  tags = var.tags
}


# SECURITY GROUPS MODULE


module "sg" {
  source = "./modules/sg"

  vpc_id      = module.vpc.vpc_id
  alb_sg_name = var.alb_sg_name
  ecs_sg_name = var.ecs_sg_name

  tags = var.tags
}


# IAM MODULE


module "iam" {
  source = "./modules/iam"

  execution_role_name = var.execution_role_name
  tags                = var.tags
}


# ALB MODULE


module "alb" {
  source = "./modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.sg.alb_sg_id

  alb_name           = var.alb_name
  tg_name            = var.tg_name
  health_check_path  = var.health_check_path
  
  certificate_arn   = module.acm.certificate_arn
  
  tags = var.tags
}


# ECS MODULE


module "ecs" {
  source = "./modules/ecs"

  cluster_name       = var.cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_sg_id          = module.sg.ecs_sg_id

  target_group_arn   = module.alb.target_group_arn
  execution_role_arn = module.iam.execution_role_arn

  image         = var.container_image
  cpu           = var.ecs_cpu
  memory        = var.ecs_memory
  desired_count = var.desired_count

  container_name = var.container_name
  container_port = var.container_port

  tags = var.tags
}


# ACM Certificate (DNS validation)


module "acm" {
  source = "./modules/acm"

  domain_name       = var.domain_name
  hosted_zone_id    = var.hosted_zone_id
  subject_alternative_names = []
  tags              = var.tags
}

module "dns" {
  source = "./modules/dns"

  hosted_zone_id         = var.hosted_zone_id
  record_name            = var.domain_name
  alias_name             = module.alb.alb_dns_name
  alias_zone_id          = module.alb.alb_zone_id
  evaluate_target_health = false
}

