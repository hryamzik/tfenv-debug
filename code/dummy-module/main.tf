resource "null_resource" "cluster" {
  provisioner "local-exec" {
  command = "sleep 20"
  }
}
