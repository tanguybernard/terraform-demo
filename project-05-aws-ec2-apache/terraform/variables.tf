variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "eu-west-3"
}

variable "aws_azs" {
  type        = string
  description = "AWS Availability Zones"
  default     = "eu-west-3a"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets_cidr_block" {
  type        = string
  description = "CIDR Block for Public Subnets in VPC"
  default     = "10.0.0.0/24"
}

variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "WatermelonCompany"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "LinuxWebServer"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "WebServer"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}

variable "instance_key" {
  default = "TestKeyPairTerraformApacheSept2024"
}