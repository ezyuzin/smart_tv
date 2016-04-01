Вариант 1) через скайп:
1. Стартовый скрипт плагина e:\samapp\JavaScript\Main.js
1.1. При установке копирует в папку телевизора /mtd_rwcommon/moip/engines/Skype/
    * libSkype.so 
    * runSamyGO.sh

2. Модуль libSkype.so при загрузке телевизора выполняет скрипт runSamyGO.sh
3. Скрипт runSamyGO.sh ищет на подключеных usbDiskах скрипт $/samapp/data/boot/initd.sh
3.1. Если скрипт не найден, телевизор загружается в обычном порядке
3.2. Если скрипт найден, он исполняется

Вариант 2) через стартовый скрипт vd_tools.sh
1. Положить загрузочный скрипт в папку 
/mtd_rwarea/vd_tools.sh
/mtd_rwarea/agent.conf
