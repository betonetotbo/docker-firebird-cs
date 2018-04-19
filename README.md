# docker-firebird-cs

Docker image for Firebird Classic Server.

# Password for sysdba

The default password for sysdba is randomly generated when you first launch the container,
look in the docker log for your container or check /opt/firebird/SYSDBA.password.
Alternatively you may pass the environment variable `ISC_PASSWORD` to set the default password.

# Environment variables

## ISC_PASSWORD

Default `sysdba` user password, if left blank a random 20 character password will be set instead.
The password used will be placed in /opt/firebird/SYSDBA.password.
If a random password is generated then it will be in the log for the container.

# Exposes

## 3050/tcp

# Volumes

## /data

Put here your `FDB` or `FBK` files. Note that you need to set the **owner** to `firebird:firebird` for this files, to Firebird Server to be able to access/write them.

Example how to upload a `FBK`, change it owner and restore it.

```
# First we need to build and start the container (compose sample runs firebird on port 6666)
docker-compose up --build -d

# upload my FBK
docker cp my.fbk dockerfirebirdcs_firebird-cs_1:/data/my.fbk

# change FBK owner
docker exec dockerfirebirdcs_firebird-cs_1 chown firebird:firebird /data/my.fbk

# restore it using the firebird service manager
docker exec dockerfirebirdcs_firebird-cs_1 /opt/firebird/bin/gbak -C /data/my.fdb /data/my.fdb -user sysdba -password masterkey -se 127.0.0.1:service_mgr
```