FROM oracle/database:11.2.0.2-xe
MAINTAINER steve<dot>roberts<at>essarsoftware<dot>co<dot>uk

# Set up additional envvars
ENV APEX_TS_APEX=sysaux \
    APEX_TS_FILES=sysaux \
    APEX_TS_TEMP=temp \
    APEX_IMAGES="/i/" \
    APEX_INSTALL_DIR=/u02

ENV PATH=$PATH:/root

# Load additional software
COPY sftw/apex_5.1.3_en.zip \
     scripts/installApex.sh \
     scripts/changeAdminPwd.sh \
     scripts/sqlplus.sh \
     scripts/sysAsSysDba.sh \
     /tmp/

# Unpack additional software, link install script to be run at setup
RUN mkdir -p $APEX_INSTALL_DIR && \
    unzip -d $APEX_INSTALL_DIR /tmp/apex_5.1.3_en.zip && \
    cp -p /tmp/installApex.sh $APEX_INSTALL_DIR/ && \
    cp -p /tmp/changeAdminPwd.sh /tmp/sqlplus.sh /tmp/sysAsSysDba.sh /root/ && \
    ln -s $APEX_INSTALL_DIR/installApex.sh $ORACLE_BASE/scripts/setup/20_installApex.sh

