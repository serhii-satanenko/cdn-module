################### Default Cache ###################
###################     GLOBAL    ###################
variable "allowed_methods" {
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD, OPTIONS`)"
}

variable "default_target_origin_id" {
  type        = string
  default     = ""
  description = "Origin id for default cache"
}

variable "compress" {
  type        = bool
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
  default     = false
}

variable "response_headers_policy_id" {
  type        = string
  description = "The identifier for a response headers policy"
  default     = ""
}

variable "viewer_protocol_policy" {
  type        = string
  description = "allow-all, redirect-to-https"
  default     = "https-only"
}

variable "trusted_signers" {
  type        = list(string)
  default     = []
  description = "List of AWS account IDs (or self) that you want to allow to create signed URLs for private content"
}
###################    END      ###################

###################  CACHE NEW  ###################
variable "cache_policy_id" {
  type        = string
  default     = null
  description = "ID of the cache policy attached to the cache behavior"
}

variable "origin_request_policy_id" {
  type        = string
  default     = null
  description = "ID of the origin request policy attached to the cache behavior"
}
###################  CACHE LEGASY ###################
variable "forward_headers" {
  description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers."
  type        = list(string)
  default     = []
}

variable "forward_query_string" {
  type        = bool
  default     = false
  description = "Forward query strings to the origin that is associated with this cache behavior"
}

variable "forward_cookies" {
  type        = string
  description = "Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
  default     = "none"
}

variable "forward_cookies_whitelisted_names" {
  type        = list(string)
  description = "List of forwarded cookie names"
  default     = []
}
################### POST GLOBAL  ###################
variable "realtime_log_config_arn" {
  type        = string
  default     = null
  description = "The ARN of the real-time log configuration that is attached to this cache behavior"
}

variable "default_ttl" {
  type        = number
  default     = 60
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  type        = number
  default     = 0
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}
###################  ################### ###################
###################  END  Default Cache  ###################
###################  ################### ###################

###################      CUSTOM CACHE     ###################
variable "ordered_cache" {
  type = list(object({
    path_pattern                = string
    target_origin_id            = string
    allowed_methods             = list(string)
    cached_methods              = list(string)
    compress                    = bool
    response_headers_policy_id  = string
    viewer_protocol_policy      = string
    cache_policy_id           = string
    origin_request_policy_id  = string
    forward_query_string      = bool
    forward_header_values     = list(string)
    forward_cookies           = string
    min_ttl                   = number
    default_ttl               = number
    max_ttl                   = number
    smooth_streaming          = bool
  }))
  default = []
}