#!/bin/sh
# This script invokes by /mtd_rwarea/VD_TOOLS.sh

ARG1=$1
export SM_HOME=/mtd_rwcommon/samboot
mkdir -p SM_HOME;

SM_BOOTLOG=$SM_HOME/var/log/boot.log
mkdir -p $SM_HOME/var/log
# rm -f $SM_BOOTLOG
sync

if [ "$1" == "--noconsole" ]; then
  cat $SM_BOOTLOG > $SM_HOME/var/log/boot1.log
  exec &> $SM_BOOTLOG
  cat $SM_HOME/var/log/boot1.log
  rm $SM_HOME/var/log/boot1.log
fi
exec 2>&1;

main() {
  echo "[samboot/initd.sh] started"
  TryFindBootUSB

  if [ "$SM_BOOTUSB" == "" ]; then
    echo "[samboot/initd.sh] BOOTUSB: Not found";
    return 0;
  fi

  echo "[samboot/initd.sh] BOOTUSB: ${SM_BOOTUSB}"
  
  # copy and redirect log output to boot drive
  rm -f "$SM_BOOTUSB/boot.log"

  # copy and execute boot script
  rm -R -f $SM_HOME/tmp;
  mkdir -p $SM_HOME/tmp;
  cp $SM_BOOTUSB/samboot/boot.sh $SM_HOME/tmp/boot.sh
  chmod 777 $SM_HOME/tmp/boot.sh
  
  $SM_HOME/tmp/boot.sh

  if [ -f "$SM_BOOTLOG" ]; then
    cp $SM_BOOTLOG "$SM_BOOTUSB/boot.log"
    # rm $SM_BOOTLOG
  fi
  echo "[samboot/initd.sh] completed"
}

TryFindBootUSB() {
  timeout=20;
  export SM_BOOTUSB="";
  while [ "$timeout" -gt "0" ]
  do
    echo "[samboot/initd.sh] TryFindBootUSB [$timeout]";
    if [ -d /dtv/usb ]; then      
      connected=`ls /dtv/usb | grep ^sd`;
      for USB in $connected; do
        USB="/dtv/usb/$USB"
        echo "[samboot/initd.sh] $USB";
        if [ -e "$USB/samboot/boot.sh" ]; then
          export SM_BOOTUSB=$USB;       
          return 0;
        fi
      done
    fi
    timeout=`expr $timeout - 2`
    sleep 2;    
  done
}

main;