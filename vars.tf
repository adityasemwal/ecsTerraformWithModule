variable "access_key" {
}

variable "secret_key" {
}

variable "AWS_REGION" {
  default = "us-west-1"
}

variable "AWS_INSTANCE" {
}

variable "ports"{
  type = map(list(string))
  default = {
    22 = ["0.0.0.0/0"]
    3000 = ["0.0.0.0/0"]
    8081 = ["0.0.0.0/0"]
    8085 = ["0.0.0.0/0"]
  }
}
