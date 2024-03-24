variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "settings" {
  description = "Settings for the RDS"
  type        = map(any)
  default = {
    "tag_default" = {
      "name" = "fiap"
    }
    "database" = {
      "allocated_storage"   = 20
      "db_port"             = 3306
      "db_name"             = "fiap_db"
      "engine"              = "mysql"
      "engine_version"      = "8.0.36"
      "instance_class"      = "db.t3.micro"
      "skip_final_snapshot" = true
      "publicly_accessible" = true
      "multi_az"            = false
      "identifier"          = "fiap-db"
    }
    "subnet" = {
      "count"                   = 2
      "map_public_ip_on_launch" = true
    }
  }
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "securiry_group_name_rds" {
  description = "Security Group name"
  type        = string
  default     = "FIAP"
}

variable "db_subnet_group_name_ponto" {
  description = "DB Group name"
  type        = string
  default     = "fiap_ponto"
}



variable "api_name" {
  description = "Nome da API"
  type        = string
  default     = "fiap"
}

variable "api_authorization" {
  description = "API Authorization"
  type        = string
  default     = "NONE"
}

variable "http_method" {
  description = "Metodo HTTP da API"
  type        = string
  default     = "ANY"
}

variable "integration_http_method" {
  description = "HTTP Method"
  type        = string
  default     = "POST"
}

variable "integration_type" {
  description = "Integration Type"
  type        = string
  default     = "AWS_PROXY"
}

variable "stage_deploy" {
  description = "Stage Deploy"
  type        = string
  default     = "prod"
}

variable "stage_name" {
  description = "Stage Name"
  type        = string
  default     = "fiap"
}




variable "cloudwatch_log_group_name_ecr_production" {
  description = "Log name"
  type        = string
  default     = "ecr_production"
}



variable "cloudwatch_log_group_name_app_production" {
  description = "Log name"
  type        = string
  default     = "app_production"
}


variable "respository_name_production" {
  description = "Repo name"
  type        = string
  default     = "app_repo_production"
}



variable "ecs_cluster_name_production" {
  description = "Cluster Name"
  type        = string
  default     = "app_cluster_production"
}



variable "ecs_role_name_production" {
  description = "ECS Role Name"
  type        = string
  default     = "ecs_role_production"
}


variable "policy_name_production" {
  description = "Policy Name"
  type        = string
  default     = "ecs_policy_name_production"
}



variable "excution_role_name_production" {
  description = "Execution Role Name"
  type        = string
  default     = "execution_role_production"
}



variable "execution_role_policy_production" {
  description = "Execution Role Policy"
  type        = string
  default     = "execution_role_policy_production"
}



variable "family_name_production" {
  description = "Family Name"
  type        = string
  default     = "app-production"
}



variable "container_name_production" {
  description = "Container Name"
  type        = string
  default     = "app-production"
}



variable "ecs_service_name_production" {
  description = "ECS Service Name"
  type        = string
  default     = "app-production"
}



variable "securiry_group_name_ecs_production" {
  description = "Security Group name"
  type        = string
  default     = "FIAP-ECS-PRODUCTION"
}
