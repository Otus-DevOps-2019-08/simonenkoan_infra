variable project {
  description = "infra-253420"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1-b"
}
variable public_key_path {
  # Описание переменной
  description = "/root/.ssh/id_ed25519"
}
variable disk_image {
  description = "reddit-base"
}