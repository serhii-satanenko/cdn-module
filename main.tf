module "distribution1" {
	source   = "./module/"
	module_enabled = true
	region   = var.region
	web_acl_id = var.web_acl_id
  comment = "Distribution1_Name. Managed by Terraform"
  origin_access_identity_comment = "Distribution1_acces"
	
	# Required. Must by one or more object
	custom_origins = [{
		domain_name           = "test-crmdata-dev01-cloud-static.s3.eu-central-1.amazonaws.com"
		origin_id             = "test-crmdata-dev01-cloud-static"
		origin_path           = ""
		connection_attempts   = 3
		connection_timeout    = 10
		s3_origin_config      = false
		custom_headers        = []
		custom_origin_config  = []
	}]
	default_target_origin_id = "test-crmdata-dev01-cloud-static" # Required. But can also be set with other parameters
}


module "distribution2" {
	source   = "./module/" # Required
	module_enabled = true
	region   = var.region
	create_s3_private_buckets = ["crmdata-dev01-cdn-backoffice"]
  comment = "Distribution2_Name. Managed by Terraform"
  origin_access_identity_comment = "Distribution2_acces"
	# web_acl_id = var.web_acl_id  
	
	# Required. Must by one or more object
	custom_origins = [{
		domain_name         	= "crmdata-dev01-cdn-backoffice.s3.eu-central-1.amazonaws.com"
		origin_id							= "crmdata-dev01-cdn-backoffice"
		origin_path         	= ""
		connection_attempts 	= 3
		connection_timeout  	= 10
		s3_origin_config    	= true
		custom_headers      	= []
		custom_origin_config  = []
		},
		{
		domain_name           = "test-crmdata-dev01-cloud-static.s3.eu-central-1.amazonaws.com" # current s3 public bucket
		origin_id             = "test-crmdata-dev01-cloud-static"
		origin_path           = ""
		connection_attempts   = 3
		connection_timeout    = 10
		s3_origin_config      = false
		custom_headers        = []
		custom_origin_config  = []
	},
	{
		domain_name           = "MAIN-ALB-1049649966.eu-central-1.elb.amazonaws.com" # current alb/nlb(elb) dns
		origin_id             = "backoffice-alb"
		origin_path           = ""
		connection_attempts   = 3
		connection_timeout    = 10
		s3_origin_config      = false
		custom_headers        = []
		custom_origin_config  = [{
				http_port                 = 80
				https_port                = 443
				origin_protocol_policy    = "http-only"
				origin_ssl_protocols      = ["TLSv1.2"]
				connection_attempts       = 3
				connection_timeout        = 10
				origin_read_timeout       = 30
				origin_keepalive_timeout  = 30
		}]
	}]

	default_target_origin_id = "crmdata-dev01-cdn-backoffice" # Required. But can also be set with other parameters

	ordered_cache = [{
    path_pattern      = "/cloude-static/*"
    target_origin_id  = "test-crmdata-dev01-cloud-static"
    allowed_methods   = ["GET", "HEAD"]
    cached_methods    = ["GET", "HEAD"]
    compress          = true
    response_headers_policy_id = ""
    viewer_protocol_policy     = "https-only"

    cache_policy_id           = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    origin_request_policy_id  = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf"
		# cache_policy_id 					= ""   # will work legacy config
		# origin_request_policy_id 	= ""

    forward_query_string  = false
    forward_header_values = ["Origin"]
    forward_cookies       = "none"
    
    default_ttl = 0
    min_ttl = 0
    max_ttl = 0

    smooth_streaming = false
  },
	{
		path_pattern      = "/ws"
    target_origin_id  = "backoffice-alb"
    allowed_methods   = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods    = ["GET", "HEAD", "OPTIONS"]
    compress          = false
    response_headers_policy_id = ""
    viewer_protocol_policy     = "https-only"
    cache_policy_id           = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id  = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    forward_query_string  = false
    forward_header_values = ["Origin"]
    forward_cookies       = "none"
    default_ttl = 0
    min_ttl = 0
    max_ttl = 0
    smooth_streaming = true
	},
  {
    path_pattern      = "/rsocket"
    target_origin_id  = "backoffice-alb"
    allowed_methods   = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods    = ["GET", "HEAD", "OPTIONS"]
    compress          = false
    response_headers_policy_id = ""
    viewer_protocol_policy     = "https-only"
    cache_policy_id           = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id  = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    forward_query_string  = false
    forward_header_values = ["Origin"]
    forward_cookies       = "none"
    default_ttl = 0
    min_ttl = 0
    max_ttl = 0
    smooth_streaming = true
  },
	{
    path_pattern      = "/rsocket2"
    target_origin_id  = "backoffice-alb"
    allowed_methods   = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods    = ["GET", "HEAD", "OPTIONS"]
    compress          = false
    response_headers_policy_id = ""
    viewer_protocol_policy     = "https-only"
    cache_policy_id           = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id  = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    forward_query_string  = false
    forward_header_values = ["Origin"]
    forward_cookies       = "none"
    default_ttl = 0
    min_ttl = 0
    max_ttl = 0
    smooth_streaming = true
  },
	{
    path_pattern      = "/api*"
    target_origin_id  = "backoffice-alb"
    allowed_methods   = ["GET", "HEAD"]
    cached_methods    = ["GET", "HEAD"]
    compress          = true
    response_headers_policy_id = ""
    viewer_protocol_policy     = "https-only"
    cache_policy_id           = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id  = "216adef6-5c7f-47e4-b989-5492eafa07d3"
    forward_query_string  = false
    forward_header_values = ["Origin"]
    forward_cookies       = "none"
    default_ttl = 0
    min_ttl = 0
    max_ttl = 0
    smooth_streaming = true
  }]

	custom_error_response = {
		"400" = {
      error_caching_min_ttl = 10
      error_code = 400
      response_code = 400
      response_page_path = "/index.html"
    }
    "403" = {
      error_caching_min_ttl = 10
      error_code = 403
      response_code = 403
      response_page_path = "/index.html"
    }
    "404" = {
      error_caching_min_ttl = 10
      error_code = 404
      response_code = 404
      response_page_path = "/index.html"
    }
	}
}