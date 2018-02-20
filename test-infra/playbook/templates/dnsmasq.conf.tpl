interface=vmbri0
addn-hosts=/etc/dnsmasq.hosts

# Static dhcp only
dhcp-range=192.168.0.0,static,255.255.0.0

enable-tftp
tftp-root=/var/lib/tftpboot

# Legacy PXE
dhcp-match=set:bios,option:client-arch,0
dhcp-boot=tag:bios,undionly.kpxe

# UEFI
dhcp-match=set:efi32,option:client-arch,6
dhcp-boot=tag:efi32,ipxe.efi
dhcp-match=set:efibc,option:client-arch,7
dhcp-boot=tag:efibc,ipxe.efi
dhcp-match=set:efi64,option:client-arch,9
dhcp-boot=tag:efi64,ipxe.efi

# iPXE - chainload to matchbox ipxe boot script
dhcp-userclass=set:ipxe,iPXE
dhcp-boot=tag:ipxe,http://matchbox.example.com:8080/boot.ipxe

# verbose
log-queries
log-dhcp

# static DNS assignements
address=/matchbox.example.com/192.168.0.1

# static ip assignements
{% for host in groups['all'] %}{% set host_loop = loop %}{% for vm_name in hostvars[host]['vm_facts'] %}
dhcp-host={{hostvars[host]['vm_facts'][vm_name]['mac']}},192.168.{{host_loop.index + 4}}.{{vm_name.split('-')[1]|replace('node', '')}},1h  # {{vm_name}}
{% endfor %}{% endfor %}
