install_chocolatey:
  module.run:
    - name: chocolatey.bootstrap

install_dotnetcore_windowshosting:
  chocolatey.installed:
    - name: dotnetcore-windowshosting
    - version: 2.0.3
