{% for var in tf_env %}
export {{var}}="{{tf_env[var]}}"
{% endfor %}
