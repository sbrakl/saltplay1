install_chocolatey:
  module.run:
    - name: chocolatey.bootstrap

install_firefox:
  chocolatey.installed:
    - name: googlechrome 
