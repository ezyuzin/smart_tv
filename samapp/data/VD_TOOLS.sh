#!/bin/sh 

# /mtd_rwarea/VD_TOOLS.sh
HOMEDIR=/mtd_rwcommon/samboot

echo "[vd_tools.sh] started"
chmod 777 /mtd_rwarea/VD_TOOLS.sh
chown app:app /mtd_rwarea/VD_TOOLS.sh

if [ -d $HOMEDIR ]; then
  chown app:app $HOMEDIR
  if [ -f $HOMEDIR/initd.sh ]; then
    echo "[vd_tools.sh] samboot/initd.sh found. statup..."
    chmod 777 $HOMEDIR/initd.sh
    chown app:app $HOMEDIR/initd.sh
    $HOMEDIR/initd.sh --noconsole &
  fi     
fi
echo "[vd_tools.sh] completed"
