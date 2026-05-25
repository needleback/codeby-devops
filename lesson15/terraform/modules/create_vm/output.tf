output "vm_id" {
  description = "id VM"
  value       = aws_instance.create_vm.id
}

output "vm_tag_name" {
  description = "tag name VM"
  value       = aws_instance.create_vm.tags.Name
}
