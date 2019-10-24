variable "loc" {
  description = "Default Azure region"
  default     = "West Europe"
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


variable "webapplocs" {
    description = "List of locations for web apps"
    type        = "list"
    default     = []
}
