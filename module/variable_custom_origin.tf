variable "custom_origins" {
  type = list(object({
    domain_name         = string
    origin_id           = string
    origin_path         = string
    connection_attempts = number
    connection_timeout  = number
    s3_origin_config    =  bool
    custom_headers      = list(object({
      name  = string
      value = string
    }))
    custom_origin_config = list(object({
      http_port                = number
      https_port               = number
      origin_protocol_policy   = string
      origin_ssl_protocols     = list(string)
      origin_read_timeout      = number
      origin_keepalive_timeout = number
    }))
  }))
  default = []
}