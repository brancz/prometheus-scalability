data "external" "version" {
  program = ["/bin/sh", "-c", "/usr/bin/curl https://${var.release_channel}.release.core-os.net/amd64-usr/current/version.txt | /usr/bin/sed -n 's/COREOS_VERSION=\\(.*\\)$/{\"version\": \"\\1\"}/p'"]
}
