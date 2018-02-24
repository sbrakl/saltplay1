install_chocolatey:
  module.run:
    - name: chocolatey.bootstrap

install_unzip:
  chocolatey.installed:
    - name: unzip

extract_myapp:
  archive.extracted:
    - name: C:\KiwiServices\
    - source: salt://deploycode/pkg/code.zip
    - enforce_toplevel: false
    - use_cmd_unzip: true
