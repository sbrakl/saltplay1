{% set deploydir = salt['pillar.get']('kiwi:store_win:baseIISdir', '') %}
{% set sn = salt['pillar.get']('kiwi:store_win:servicename', '') %}
{% set serdir = deploydir + "\\" + sn %}
{% set saltdir = 'salt://kiwideploycode/publishcode/' + sn %}

copy_ps_file:
  file.managed:
    - name: C:\KiwiSalt\ps\StartStopAppPool.ps1
    - source: salt://kiwideploycode/ps/StartStopAppPool.ps1
    - makedirs: true

stop_apppool:
  cmd.run:
    - name: C:\KiwiSalt\ps\StartStopAppPool.ps1 -StartStop stop
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"

{{ serdir }}:
  file.recurse:
    - source: {{ saltdir }}
    - clean: true
    - include_empty: True

start_apppool:
  cmd.run:
    - name: C:\KiwiSalt\ps\StartStopAppPool.ps1 -StartStop start
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"

