variable "loc" {
  description = "Default Azure region"
  default     = "China East"
}

variable "tags" {
  default     = {
       source = "citadel"
       env    = "training"
  }
}

variable "resource_prefix" {
  default = "tf"
  
}
