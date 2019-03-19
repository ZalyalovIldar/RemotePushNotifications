# RemotePushNotifications

## Home work: 
**Предисловие:** 
Каждого отдельно добавляю в девелопер программу университета, и вам нужно будет самим для своего приложения сгенерить все нужные сертификаты для работы с пушами. Не забудьте что bundleID проекта должен быть уникальным, так что проверяйте уже существующие сначала.  
**Основное задание будет следующее:**  
Вам предстоит настроить работу **«внешних»** и **«внутренних»** пушей. Под "внунтренними" пушами, имеется в виду их кастомное отображение внутри приложения. Т.к. сейчас пушки видны только если приложение свернуто, вам нужно будет вручную отлавливать факт того, что пришла пушка, пока вы находитесь в приложении и отображать свою вьюху, как например делается в ВК, Телеграмм, когда вы находясь внутри приложения видите пуш уведомление о сообщении.  
**Внешние** отвечают за отображение, реакцию пользователя снаружи приложения, а **внутренние** соотвественно за отображение пушей внутри приложения, обработку нажатия на них.     

В целом приложение состоит из следующих экранов:  
1. Экран с нотификациями, новые выше старых. (таблица, где в ячейках заголовок нотиф., картинка (если есть), описание в 3 строки макс.)  
2. Экран с подробным просмотром нотификации.(на скроле картинка, заголовок, полное описание)
3. Экран с картинкой. (просто картинка из пушки по центру, либо плейсхолдер) 
Экран с картинкой - 1-ый UITab, экран нотификациями и детальнй просмотр - 2-ой UITab, т.е. в приложении UITabBarController соединяет эти 2 экраны.
Нотификации кэшируются в CoreData/Realm.  

Логика работы:  
**Внешняя нотификация**: Приходит push notification, нажимая на него попадаем на экран детального просмотра этой пушки. Можем нажать "назад", свайпнуть и попасть в список нотификаций где видим последнюю пришедшую нотификацию. Если в пушке была картинка - мы можем ее посмотреть на табе с картинкой.   
**Внутренняя нотификация**: Находимся на любом табе, сверху выпадает нотификация, на нее можно тапнуть и перейти так же в детальный просмотр нотификаций или же ее можно свайпнуть и убрать. Остальная логика такая же как у "внешней" нотификации.  

**Ссылка на Pusher для теста пушей: https://github.com/noodlewerk/NWPusher**
