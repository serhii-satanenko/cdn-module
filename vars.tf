variable "region" {
  default = "eu-central-1"
}

variable "web_acl_id" {
	default = "arn:aws:wafv2:us-east-1:160719357022:global/webacl/my-web-acl/621df3a5-6be5-4f47-b1fd-2cb1d5880402"
  description = "ARN of web_acl"
}