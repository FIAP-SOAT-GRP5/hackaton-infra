module "aws_network" {
  source                    = "../modules/network"
  subnet_count              = var.settings.subnet.count
  vpc_cidr_block            = var.vpc_cidr_block
  public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
  map_public_ip_on_launch   = var.settings.subnet.map_public_ip_on_launch
  tags                      = var.settings.tag_default
  securiry_group_name       = var.securiry_group_name_rds
  from_db_port              = var.settings.database.db_port
  to_db_port                = var.settings.database.db_port
}

module "aws_rds_registro_de_ponto" {
  source               = "../modules/rds"
  db_subnet_group_name = var.db_subnet_group_name_ponto
  subnet_ids           = module.aws_network.subnet_ids
  allocated_storage    = var.settings.database.allocated_storage
  db_name              = var.settings.database.db_name
  engine               = var.settings.database.engine
  engine_version       = var.settings.database.engine_version
  instance_class       = var.settings.database.instance_class
  db_username          = var.db_username
  db_password          = var.db_password
  skip_final_snapshot  = var.settings.database.skip_final_snapshot
  publicly_accessible  = var.settings.database.publicly_accessible
  multi_az             = var.settings.database.multi_az
  identifier           = var.settings.database.identifier
  security_group_ids   = [module.aws_network.security_group_ids]
  db_port              = var.settings.database.db_port
  tags                 = var.settings.tag_default
}



module "api_gateway" {
  source        = "../modules/api_gateway"
  api_name      = var.api_name
  authorization = var.api_authorization
  http_method   = var.http_method
}

#ECR

module "ecr_registro_de_ponto" {
  source                    = "../modules/ecr"
  cloudwatch_log_group_name = var.cloudwatch_log_group_name_ecr_production
  respository_name          = var.respository_name_production
  ecs_cluster_name          = var.ecs_cluster_name_production
  tags                      = var.settings.tag_default
}


module "ecs_task_definition_registro_de_ponto" {
  source                    = "../modules/ecs_task"
  ecs_role_name             = var.ecs_role_name_production
  policy_name               = var.policy_name_production
  excution_role_name        = var.excution_role_name_production
  execution_role_policy     = var.execution_role_policy_production
  family_name               = var.family_name_production
  container_name            = var.container_name_production
  image_url                 = module.ecr_registro_de_ponto.repository_url
  cloudwatch_log_group_name = var.cloudwatch_log_group_name_ecr_production
  vpc_id                    = module.aws_network.vpc_id
  security_group_name       = var.securiry_group_name_ecs_production
  ecs_service_name          = var.ecs_service_name_production
  cluster_id                = module.ecr_registro_de_ponto.cluster_id
  security_groups_ids       = [module.aws_network.security_group_ids]
  subnet_ids                = module.aws_network.subnet_ids
  tags                      = var.settings.tag_default
}

