SAMSUNG UE48H6650

1. download image samyext4.img > https://disk.yandex.ru/d/5iVBV9aHqaPqpA  <br/>
1.1. place it in folder $/samboot/image

2. Format flashdisk FAT32<br/>
2.1. Copy all into flashdisk root folder<br/>
2.2. Insert flashdisk into TV USB-port<br/>
2.3. In TV-menu should be appear application "SamyGo"<br/>
2.4. Run, it do rooting tv<br/>
2.5. Reboot TV, after reboot should be able to connect using ftp, telnet<br/>

3. Access to TV<br/>
3.1. telnet 192.168.0.108:23 (with empty login/password)<br/>
3.2. ftp 192.168.0.108:23 (with empty login/password)<br/>
3.3. telnet has strictions, 
- all paths expect to be started from root folder<br/>
- sometimes need to confirm twice (press enter twice)<br/>
- errour output should be redirected using 2>&1;<br/>
for sample: ls -al / 2>&1<br/>
othewise not displayed all errors that happend while command returned

