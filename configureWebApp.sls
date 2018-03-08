{% set basedir = salt['pillar.get']('kiwi:store_win:baseIISdir','') %}
{% set sername = salt['pillar.get']('kiwi:store_win:servicename','') %}
{% set servicedir = basedir + '\\' + sername %}
{% set websername = 'kiwiservices/' + sername %}

create_apppool:
   win_iis.create_apppool:
      - name: kiwiservicesAppPool

setup_apppool:
   win_iis.container_setting:
      - name: kiwiservicesAppPool
      - container: AppPools
      - settings:
          managedRuntimeVersion: ""
          processModel.idleTimeout: "03:00:00"
      - require:
         - win_iis: create_apppool

create_directory:
  file.directory:
     - name: {{ basedir }}
     - win_owner: Administrator
     - win_perms: 
         IIS AppPool\kiwiservicesAppPool:
           perms: full_control
     - require:
         - win_iis: setup_apppool

create_sub_directory:
  file.directory:
     - name: {{ servicedir }}
     - win_owner: Administrator
     - win_perms:
         IIS AppPool\kiwiservicesAppPool:
           perms: full_control
     - require:
         - file: create_directory

create_website:
   win_iis.create_app:
      - name: kiwiservices
      - site: Default Web Site 
      - sourcepath: {{ basedir }}
      - apppool: kiwiservicesAppPool
      - require: 
         - file: create_sub_directory

create_subsite:
   win_iis.create_app:
      - name: {{ websername }}
      - site: Default Web Site
      - sourcepath: {{ servicedir }}
      - apppool: kiwiservicesAppPool
      - require:
         - win_iis: create_website

