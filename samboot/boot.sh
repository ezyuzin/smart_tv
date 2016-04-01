#!/bin/sh
# This script invokes by /mtd_rwcommon/samboot/init.sh

main() {
  echo "[samboot/boot.sh] started"
  EnsureEnvVariables;
  if [ "$?" != "0" ]; then 
    return 0;
  fi
  
  BOOT_BIN=$SM_BOOTUSB/samboot/bin;
  SM_BIN=$SM_HOME/tmp/bin;
  rm -f -R $SM_BIN;
  mkdir -p $SM_BIN;
  
  BusyboxInstall;

  echo "[samboot/boot.sh] start ftpd 21"
  /dtv/bin/busybox tcpsvd -vE 0.0.0.0 21 /dtv/bin/busybox ftpd -w / &
  /dtv/bin/remshd &

  ln -s /dev/loop3 /dtv/loopnone
  sync
  /dtv/bin/busybox losetup /dtv/loopnone  "$SM_BOOTUSB/samboot/image/samyext4.img"
  /dtv/bin/busybox mount -t ext4 -o sync,exec /dtv/loopnone /mnt
  sync
  
  # /mnt/bin/busybox2 sh -x /mnt/rcSGO /mnt >> /mnt/sam.log 2>&1 
  
  echo "[samboot/boot.sh] completed"
}

BusyboxInstall() {
  echo "[samboot/boot.sh] busybox install"
  cp $BOOT_BIN/busybox $SM_BIN/busybox
  cp $BOOT_BIN/remshd $SM_BIN/remshd
  cp $BOOT_BIN/samygo_telnetd $SM_BIN/samygo_telnetd

  chmod 777 $SM_BIN/*
  $SM_BIN/busybox --install -s $SM_BIN
  ln -s $SM_BIN /dtv/bin
  sync

  export PATH=/dtv/bin:$PATH
  export LD_LIBRARY_PATH=$SM_BIN:$LD_LIBRARY_PATH
  sync
}

EnsureEnvVariables() {
  if [ "$SM_HOME" == "" ]; then 
    echo "[SM_HOME] not defined";
    return -1;
  fi
  
  if [ "$SM_BOOTUSB" == "" ]; then
    echo "[SM_BOOTUSB]: not defined";
    return -1;
  fi 
  return 0;
}

main;