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


variable "webapplocs" {
    description = "List of locations for web apps"
    type        = "list"
    default     = []
}