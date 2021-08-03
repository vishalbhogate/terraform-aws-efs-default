
variable "enabled" {
  type        = bool
  description = "Create EFS or Not."
  default     = true
}

variable "security_group_description" {
  type        = string
  default     = "EFS Security Group"
  description = "The Security Group description."
}

variable "security_group_use_name_prefix" {
  type        = bool
  default     = false
  description = "Whether to create a default Security Group with unique name beginning with the normalized prefix."
}

variable "security_group_rules" {
  type = list(any)
  default = []
  description = "A list of maps of Security Group rules"
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "A list of Security Group IDs to associate with EFS."
}

variable "access_points" {
  type        = map(map(map(any)))
  default     = {}
  description = "A map of the access points you would like in your EFS volume"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "subnets" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "zone_id" {
  type        = string
  description = "Route53 DNS zone ID"
  default     = ""
}

variable "encrypted" {
  type        = bool
  description = "If true, the file system will be encrypted"
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "If set, use a specific KMS key"
  default     = null
}

variable "performance_mode" {
  type        = string
  description = "The file system performance mode. Can be either `generalPurpose` or `maxIO`"
  default     = "generalPurpose"
}

variable "provisioned_throughput_in_mibps" {
  default     = 0
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with `throughput_mode` set to provisioned"
}

variable "throughput_mode" {
  type        = string
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: `bursting`, `provisioned`. When using `provisioned`, also set `provisioned_throughput_in_mibps`"
  default     = "bursting"
}

variable "mount_target_ip_address" {
  type        = string
  description = "The address (within the address range of the specified subnet) at which the file system may be mounted via the mount target"
  default     = null
}

variable "dns_name" {
  type        = string
  description = "Name of the CNAME record to create"
  default     = ""
}

variable "transition_to_ia" {
  type        = string
  description = "Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS"
  default     = ""
}

variable "hosted_zone_is_internal" {
  default     = "false"
  description = "Set true in case the hosted zone is in an internal VPC, otherwise false"
}