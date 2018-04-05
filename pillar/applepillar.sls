kiwi:
    store_win:
        environment_vars:
            ASPNETCORE_ENVIRONMENT: "LIVE"
            KiwiAuthorizationMode: "0"
            KiwiDatabaseConnectionString: "server=192.168.1.1;userid=db1servicesuser;password=p@s$w0rd;database=db1;"
            KiwiOAuthDatabaseConnectionString: "server=192.168.1.1;user id=db2servicesuser;password=p@s$w0rd;database=db2;"
            KiwiDatabaseType: "mysql"
            KiwiServerType: "2"
        baseIISdir: "C:\\KiwiServices"
        servicename: "branchservice"
