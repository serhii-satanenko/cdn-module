output "distribution1_dns" {
	value = try(module.distribution1.cf_domain_name, "")
}

output "distribution2_dns" {
	value = try(module.distribution2.cf_domain_name, "")
}