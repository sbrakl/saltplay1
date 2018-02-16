installIISRole:
  win_servermanager.installed:
    - names: 
      - Web-Server
      - Web-Mgmt-Console
      - Web-Log-Libraries
      - Web-Http-Tracing
      - Web-Basic-Auth
      - Web-Windows-Auth
      - Web-Digest-Auth
