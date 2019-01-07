#!/bin/bash

# Change to script directory
cd ${APEX_INSTALL_DIR:-/u02}/apex

# Run change password script and exit
su -p oracle -c 'sqlplus / AS SYSDBA @apxchpwd.sql'
