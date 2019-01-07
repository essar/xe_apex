# Oracle XE + APEX
Provides baseline installation of Oracle XE (11.2.0.2) and Oracle Application Express (5.1.3).

## Dependencies

- docker image: `oracle/database:11.2.0.2-xe`: must be available in local docker registry (see [Oracle Docker Images](https://github.com/oracle/docker-images)).
- file: `apex_5.1.3_en.zip`: must be placed in `sftw/` directory.

## Building

Build using docker:
```
docker build -t essar/xe_apex .
```

## Running

The following environment variables can be set/overridden:

- `ORACLE_PWD`: is the password used for the sys/system user accounts.
- `APEX_TS_APEX`: is the name of the tablespace for the Oracle Application Express application user.
- `APEX_TS_FILES`: is the name of the tablespace for the Oracle Application Express files user.
- `APEX_TS_TEMP`: is the name of the temporary tablespace or tablespace group.
- `APEX_IMAGES`: is the virtual directory for Oracle Application Express images. To support future Oracle Application Express upgrades, define the virtual image directory as /i/.

As well as environment variables, the following parameters can be set as part of the container start up:
- `--shm-size 1G`: Oracle requires a minimum shared memory size of 1GB (suggested 2GB).
- `-v myvol:/u01/app/oracle/oradata`: Provide a volume to enable persistent storage.
- `-p 1521:1521`: Expose the SQL database port if required.

## Post-installation tasks

The instance administrator is not set by default. This can be set by running the following command:
```
docker exec -it <container-id> changeAdminPwd.sh
```

SQL*Plus sessions can be opened with the following commands:
```
docker exec -it <container-id> sqlplus.sh [args]
```
```
docker exec -it <container-id> sysAsSysDba.sh [args]
```

## References

- [Installing Oracle Application Express](https://docs.oracle.com/cd/E59726_01/install.50/e39144/http_server.htm#HTMIG29382)
