set_environment_vars:
  environ.setenv:
    - name: 
    - value: 
    {% for env, val in salt['pillar.get'](application_name ~ ':environment_vars', {}).iteritems() %}
      {{ env }}: {{ val }}
    {% endfor %}
    - permanent: HKLM
