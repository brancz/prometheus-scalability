{% for host in groups['all'] %}
{{hostvars[host].ansible_vmbri0.ipv4.address}}		{{host}}	{{host}}.example.com
{% endfor %}

{% for host in groups['masters'] %}{% set outer_loop = loop %}{% for vmif in hostvars[host]['vm_interfaces'].results %}
192.168.{{outer_loop.index + 4}}.{{loop.index}}		masters.example.com		# {{vmif['stdout_lines'][0]}}
{% endfor %}{% endfor %}

{% for host in groups['workers'] %}{% set outer_loop = loop %}{% for vmif in hostvars[host]['vm_interfaces'].results %}
192.168.{{outer_loop.index + 5}}.{{loop.index}}		workers.example.com		# {{vmif['stdout_lines'][0]}}
{% endfor %}{% endfor %}

{% for host in groups['workers'] %}{% set outer_loop = loop %}{% for vmif in hostvars[host]['vm_interfaces'].results %}
192.168.{{outer_loop.index + 5}}.{{loop.index}}		tectonic.example.com	# {{vmif['stdout_lines'][0]}}
{% endfor %}{% endfor %}

{% for host in groups['all'] %}{% set outer_loop = loop %}{% for vmif in hostvars[host]['vm_interfaces'].results %}
192.168.{{outer_loop.index + 4}}.{{loop.index}}		{{vmif['item']}}	{{vmif['item']}}.example.com	# {{vmif['stdout_lines'][0]}}
{% endfor %}{% endfor %}
