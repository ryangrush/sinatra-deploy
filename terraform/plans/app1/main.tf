variable "location" { default = "us-east-1" }
variable "public_key" { default = "AAAAB3NzaC1yc2EAAAADAQABAAABgQDFUrgEPWBv9hEA7tDV6sTmOA1cPOTRPd9WzqdZGPmPBKERBoLN3Ez6m9/x0KsvKgvKAL584g1sHXkpnu+ME5Mzk3CC2w2seihlxeJzan4pGCJ8V3m9787cxoOtFGgOWv70ty9NeIGbM8ZyNrjVXYqE4sdZWdKtrhlxK2IEsU3/0z8f4qdp2Z1fSGTSkQ/erEXFK66wW0brhDe0jI/Ob8wTTxwl292MVAWi6wuqL5HHyvUGvIULEpqhgINOWmkKzpM8GdpzHGwmQ+jjb+chXqoDH87H6lqH/6MVvhEAl57Wc1mvOLjFzIRUSw2997Swsfhu5ohes2+RVn5KOytpxdra7rS7+dnKcQ5zVweW8rnw8c/Sb+IXob8zvpmwH9SyjduHUYGcA9rxKn7/3xrR4BD4dtxR/SIXHH0bdVfYQVy/83FP4Riy9/KwI+Sh0s65P4ccqYsHSvnxbSrX+TiEuhCroKp1UrxId6xypOqiWhzjgGdhF+/Yl0USLxYULbQboEM=" }

module "app1_ec2" {
  source     = "../../modules/ec2"
  location   = var.location
  public_key = var.public_key
}

module "app1_rds" {
  source     = "../../modules/rds"
  location   = var.location
  security_group_egress = module.app1_ec2.security_group_egress
}