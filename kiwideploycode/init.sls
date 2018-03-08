{% set deploydir = salt['pillar.get']('kiwi:store_win:baseIISdir', '') %}

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

{{ deploydir }}:
  file.recurse:
    - source: salt://kiwideploycode/publishcode
    - clean: true
    - include_empty: True

start_apppool:
  cmd.run:
    - name: C:\KiwiSalt\ps\StartStopAppPool.ps1 -StartStop start
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"

