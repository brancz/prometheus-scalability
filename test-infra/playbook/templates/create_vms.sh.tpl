#!/bin/bash

NAME=$1;

if [ ! -s /var/lib/libvirt/images/$NAME.qcow2 ];
then
    qemu-img create \
    -f qcow2 \
    -o backing_file=/var/lib/libvirt/images/coreos_production_qemu_image.img \
    /var/lib/libvirt/images/$NAME.qcow2;
fi

if [ ! -s /var/lib/libvirt/manifests/$NAME.xml ];
then
virt-install \
    --name=$NAME \
    --network bridge=vmbri0 \
    --memory={{vm_memory}} \
    --vcpus={{vm_cpus}} \
    --disk path=/var/lib/libvirt/images/$NAME.qcow2,format=qcow2,bus=virtio \
    --os-type=linux \
    --os-variant=virtio26 \
    --noautoconsole \
    --boot=hd \
    --print-xml \
    | sed 's|type="kvm"|type="kvm" xmlns:qemu="http://libvirt.org/schemas/domain/qemu/1.0"|' - \
    | sed "/<\/devices>/a <qemu:commandline>\n  <qemu:arg value='-fw_cfg'/>\n  <qemu:arg value='name=opt/com.coreos/config,file=/var/lib/libvirt/manifests/${NAME}.ignition'/>\n</qemu:commandline>" - \
    > /var/lib/libvirt/manifests/$NAME.xml;

virsh define /var/lib/libvirt/manifests/$NAME.xml;
fi;

if [ ! -s /var/lib/libvirt/manifests/${NAME}.ignition ];
then
UUID=$(virsh domuuid ${NAME});
MAC=$(virsh domiflist ${NAME} | sed '1d;2d' | awk '{print $5}' | sed 's/:/-/g');

sed "s/%%UUID%%/${UUID}/"

cat <<'EOF' |  sed "s/%%UUID%%/${UUID}/" | sed "s/%%MAC%%/${MAC}/" > /var/lib/libvirt/manifests/${NAME}.ignition
{
  "ignition": {
    "version": "2.1.0",
    "config": {
      "replace": {
        "source": "http://matchbox.example.com:8080/ignition?uuid=%%UUID%%&mac=%%MAC%%&os=installed"
      }
    }
  }
}
EOF
fi;
