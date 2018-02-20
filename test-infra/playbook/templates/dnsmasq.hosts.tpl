{% for host in groups['all'] %}
{{hostvars[host].ansible_vmbri0.ipv4.address}}		{{host}}	{{host}}.example.com
{% endfor %}

{% for host in groups['masters'] %}{% set host_loop = loop %}{% for vm_name in hostvars[host]['vm_facts'] %}
192.168.{{host_loop.index + 4}}.{{vm_name.split('-')[1]|replace('node', '')}}		masters.example.com		# {{hostvars[host]['vm_facts'][vm_name]['mac']}}
{% endfor %}{% endfor %}

{% for host in groups['workers'] %}{% set host_loop = loop %}{% for vm_name in hostvars[host]['vm_facts'] %}
192.168.{{host_loop.index + 5}}.{{vm_name.split('-')[1]|replace('node', '')}}		workers.example.com		# {{hostvars[host]['vm_facts'][vm_name]['mac']}}
{% endfor %}{% endfor %}

{% for host in groups['workers'] %}{% set host_loop = loop %}{% for vm_name in hostvars[host]['vm_facts'] %}
192.168.{{host_loop.index + 5}}.{{vm_name.split('-')[1]|replace('node', '')}}		tectonic.example.com		# {{hostvars[host]['vm_facts'][vm_name]['mac']}}
{% endfor %}{% endfor %}

{% for host in groups['all'] %}{% set host_loop = loop %}{% for vm_name in hostvars[host]['vm_facts'] %}
192.168.{{host_loop.index + 4}}.{{vm_name.split('-')[1]|replace('node', '')}}		{{vm_name}}	{{vm_name}}.example.com	# {{hostvars[host]['vm_facts'][vm_name]['mac']}}
{% endfor %}{% endfor %}
