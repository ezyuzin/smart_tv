SAMSUNG UE48H6650

1. скачать образ samyext4.img > https://disk.yandex.ru/d/5iVBV9aHqaPqpA  <br/>
1.1. положить его в папку $/samboot/image

2. Отформатировать флешку в FAT32<br/>
2.1. Скопировать все в корень флешки<br/>
2.2. Вставить флешку в TV<br/>
2.3. В меню приложений должно появится приложение SamyGo<br/>
2.4. Запускаем его, рутуем телевизор<br/>
2.5. перегружаем телевизор, должен появится ftp и telnet доступ<br/>

3. доступ<br/>
3.1. telnet 192.168.0.108:23 (без логин пароля)<br/>
3.2. ftp 192.168.0.108:23 (без логин пароля)<br/>
3.3. telnet кастрированный, все команды нужно выполнять от корня.<br/>
иногда подтверждать дважды<br/>
вывод потока с ошибками нужно перенаправлять через 2>&1;<br/>
пример: ls -al / 2>&1<br/>
иначе остаемся без сообщений о ошибках

