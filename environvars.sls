set_environment_vars:
  environ.setenv:
    - name: set_environment_vars 
    - value: 
    {% for env, val in salt['pillar.get']('kiwi:store_win:environment_vars', {}).items() %}
       {{ env }}: "{{ val }}"
    {% endfor %}
    - permanent: HKLM
