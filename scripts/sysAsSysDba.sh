#!/bin/bash

# Run sqlplus as the oracle user, passing any other commandline args
su -p oracle -c 'sqlplus / AS SYSDBA "$@"'
