output "public_sg" {
    value = "${aws_security_group.allow_tls_sg.id}"
}

output "cms_db_sg" {
    value = "${aws_security_group.cms_pg_sg.id}"
}

output "public_sg_prod" {
    value = "${aws_security_group.allow_tls_sg.id}"
}