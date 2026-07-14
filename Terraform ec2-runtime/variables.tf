variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
  default     = "Runtime-Server"
}

variable "root_volume_size" {
  description = "Root EBS Volume Size (GB)"
  type        = number
  default     = 30
}