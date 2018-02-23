create_apppool:
   win_iis.create_apppool:
      - name: kiwiservicesAppPool

setup_apppool:
   win_iis.container_setting:
      - name: kiwiservicesAppPool
      - container: AppPools
      - settings:
          managedRuntimeVersion: "" 
      - require:
         - win_iis: create_apppool

create_directory:
  file.directory:
     - name: C:\KiwiServices
     - win_owner: Administrator
     - win_perms: 
         IIS AppPool\kiwiservicesAppPool:
           perms: full_control
     - require:
         - win_iis: setup_apppool

create_website:
   win_iis.create_app:
      - name: kiwiservices
      - site: Default Web Site 
      - sourcepath: C:\KiwiServices
      - apppool: kiwiservicesAppPool
      - require: 
         - file: create_directory

