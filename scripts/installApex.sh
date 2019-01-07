#!/bin/bash

# Installs Oracle APEX to the local database. Uses environment variables to pass parameters to the install script
# Pre-requisites:
# * Oracle thin client / sqlplus

# Set defaults if params not set
APEX_TS_APEX=${APEX_TS_APEX:-SYSAUX}
APEX_TS_FILES=${APEX_TS_FILES:=SYSAUX}
APEX_TS_TEMP=${APEX_TS_TEMP:=TEMP}
APEX_IMAGES=${APEX_IMAGES:=/i/}

INSTALL_FILE=apexins.sql

# Change to script directory
cd ${APEX_INSTALL_DIR:-/u02}/apex

# Check we can see the install script
if [ ! -f $INSTALL_FILE ]; then
  echo Install script $INSTALL_FILE not found in $(pwd).
  exit 1
fi

echo ======================================
echo APEX INSTALLATION
echo ======================================
echo Preparing APEX installer...
echo   - TS_APEX:  ${APEX_TS_APEX}
echo   - TS_FILES: ${APEX_TS_FILES}
echo   - TS_TEMP:  ${APEX_TS_TEMP}
echo   - IMAGES:   ${APEX_IMAGES}

echo Running installation...
# Call the installer, run as oracle user
su -p oracle -c 'sqlplus / AS SYSDBA @apexins.sql $APEX_TS_APEX $APEX_TS_FILES $APEX_TS_TEMP $APEX_IMAGES'
if [ $? != 0 ]; then
  echo ** APEX installation unsuccessful.
  exit 1
fi

echo Configuring APEX...
# Disable local listener and set public user password
su -p oracle -c 'sqlplus / AS SYSDBA <<- EOF
	EXEC DBMS_XDB.SETHTTPPORT(0);
	ALTER USER apex_public_user IDENTIFIED BY apexpublicuser;
	ALTER USER apex_public_user ACCOUNT UNLOCK;
	exit;
	EOF'

