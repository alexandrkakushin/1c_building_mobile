﻿
#Область ПрограммныйИнтерфейс

// Формирует заголовок "Заявки на обслужвание" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок..
//
Функция ЗаголовокСписаниеДенежныхСредств() Экспорт

	Возврат НСтр("ru = 'Списания денежных средств'; en = 'todo'");

КонецФункции





// Формирует заголовок "Признак ""Прочтено"" для письма..." на языке системы.
//
// Параметры:
//  Признак	 - Булево - Значение реквизита "Прочтено";
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаИзменениеИзменениеПризнакаПрочтено(Признак) Экспорт

	Возврат СтрШаблон(
				НСтр("ru = 'Признак ""Прочтено"" для письма установлен в %1'; 
					 |en = 'Reading mark for email is set as %1'"),
				?(Признак, 
					НСтр("ru = 'Прочтено'; en = 'Read'"), 
					НСтр("ru = 'Не прочтено'; en = 'Unread'")));
	
КонецФункции

// Формирует заголовок "Признак ""На контроле"" для исходящего письма установлен" на языке системы.
//
// Параметры:
//  Признак - Булево - Значение реквизита "На контроле";
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаИзменениеИзменениеПризнакаКонтроля(Признак) Экспорт

	Возврат СтрШаблон(
				НСтр("ru = 'Признак ""На контроле"" для исходящего письма установлен в %1'; 
					 |en = '""Monitored"" state for outcoming email is set as %1'"),
				?(Признак, 
					НСтр("ru = 'Да'; en = 'On'"), 
					НСтр("ru = 'Нет'; en = 'Off'")));
	
КонецФункции

// Формирует заголовок "Письмо перемещено в папку" на языке системы.
//
// Параметры:
//  НоваяПапка	 - СправочникСсылка.ПапкиПисем - Новая папка письма;
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаИзменениеПапкиПисьма(НоваяПапка) Экспорт
	
	Возврат СтрШаблон(
				НСтр("ru = 'Письмо перемещено в папку %1'; 
					 |en = 'Email moved to folder %1'"),
				НоваяПапка);

КонецФункции

// Формирует заголовок "Объект изменен на клиенте" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаОбъектИзмененНаКлиенте() Экспорт
	
	Возврат НСтр("ru = 'Объект изменен на клиенте'; 
				 |en = 'The object is modified on the client'");

КонецФункции

// Формирует заголовок "Загружено изменение объекта" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаЗагруженоИзменениеОбъекта() Экспорт

	Возврат НСтр("ru = 'Загружено изменение объекта'; 
				 |en = 'The new version is loaded'");

КонецФункции

// Формирует заголовок "Загружен новый объект" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаЗагруженНовыйОбъект() Экспорт

	Возврат НСтр("ru = 'Загружен новый объект'; 
				 |en = 'The new object is loaded'");

КонецФункции

// Формирует заголовок "Создан новый объект" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаСозданНовыйОбъект() Экспорт

	Возврат НСтр("ru = 'Создан новый объект'; 
				 |en = 'The new object is created'");

КонецФункции

// Формирует заголовок " файле обнаружен объект" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаВФайлеОбнаруженОбъект() Экспорт

	Возврат НСтр("ru = 'В файле обнаружен объект'; en = 'Object found'");

КонецФункции

// Формирует заголовок "В файле обнаружен объект, но ссылка не получена" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ТекстПротоколаВФайлеОбнаруженОбъектНоСсылкаНеПолучена() Экспорт

	Возврат НСтр("ru = 'В файле обнаружен объект, но ссылка не получена';
				 |en = 'Object found, but the ref isn''t received'");

КонецФункции

// Формирует заголовок "Объект помещен в исходящее сообщение" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок..
//
Функция ТекстПротоколаОбъектПомещенВСообщение() Экспорт

	Возврат НСтр("ru = 'Объект помещен в исходящее сообщение'; en = 'Object placed in file'");

КонецФункции


// Формирует заголовок "Календарь" на языке системы. 
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок..
//
Функция ЗаголовокКалендарь() Экспорт

	Возврат НСтр("ru = 'Календарь'; en = 'Calendar'");

КонецФункции

// Формирует заголовок "Почта" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокПочта() Экспорт

	Возврат НСтр("ru = 'Почта'; en = 'Mail'");

КонецФункции

// Формирует заголовок "На контроле" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокНаКонтроле() Экспорт

	Возврат НСтр("ru = 'На контроле'; en = 'Monitoring'");
	
КонецФункции

// Формирует заголовок "Всего задач" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокВсегоЗадач() Экспорт

	Возврат НСтр("ru = 'Всего задач'; en = 'Tasks'");

КонецФункции 

// Формирует заголовок "Просрочено" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокПросрочено() Экспорт
	
	Возврат НСтр("ru = 'Просрочено'; en = 'Expired'");
	
КонецФункции


// Формирует заголовок "Продолжить" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыПродолжить() Экспорт

	Возврат НСтр("ru = 'Продолжить'; en = 'Continue'");

КонецФункции

// Формирует заголовок "Остановить" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыОстановить() Экспорт

	Возврат НСтр("ru = 'Остановить'; en = 'Pause'");

КонецФункции

// Формирует заголовок "Сохранить" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыСохранить() Экспорт

	Возврат НСтр("ru = 'Сохранить'; en = 'Save'");

КонецФункции

// Формирует заголовок "Не сохранять" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыНеСохранять() Экспорт

	Возврат НСтр("ru = 'Не сохранять'; en = 'Don't save'");

КонецФункции

// Формирует заголовок "Удалить" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыУдалить() Экспорт

	Возврат НСтр("ru = 'Удалить'; en = 'Delete'");

КонецФункции 

// Формирует заголовок "Не удалять" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыНеУдалять() Экспорт

	Возврат НСтр("ru = 'Не удалять'; en = 'Cancel'");

КонецФункции 


// Формирует заголовок "На контроль" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыНаКонтроль() Экспорт

	Возврат НСтр("ru = 'На контроль'; en = 'Monitoring'");

КонецФункции

// Формирует заголовок "Записать в календарь" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыЗаписатьВКалендарь() Экспорт

	Возврат НСтр("ru = 'Записать в календарь'; en = 'Bring in a calendar'");

КонецФункции

// Формирует заголовок "Записать в календарь" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыНаписатьПисьмо() Экспорт

	Возврат НСтр("ru = 'Написать письмо'; en = 'Write email'");

КонецФункции

// Формирует заголовок "Флаг" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыИзменитьФлаг() Экспорт

	Возврат НСтр("ru = 'Флаг'; en = 'Flag'");

КонецФункции

// Формирует заголовок "Принять к исполнению" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыПринятьНаИсполнение() Экспорт

	Возврат НСтр("ru = 'Принять к исполнению'; en = 'Accept task'");

КонецФункции

// Формирует заголовок "Отменить принятие к исполнению" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыОтказатьсяОтИсполнения() Экспорт

	Возврат НСтр("ru = 'Отменить принятие к исполнению'; en = 'Revoke task acceptance'");

КонецФункции

// Формирует заголовок "Красный" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыКрасный() Экспорт

	Возврат НСтр("ru = 'Красный'; en = 'Red'");

КонецФункции

// Формирует заголовок "Синий" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыСиний() Экспорт

	Возврат НСтр("ru = 'Синий'; en = 'Blue'");

КонецФункции

// Формирует заголовок "Желтый" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыЖелтый() Экспорт

	Возврат НСтр("ru = 'Желтый'; en = 'Yellow'");

КонецФункции

// Формирует заголовок "Зеленый" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыЗеленый() Экспорт

	Возврат НСтр("ru = 'Зеленый'; en = 'Green'");

КонецФункции

// Формирует заголовок "Оранжевый" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыОранжевый() Экспорт

	Возврат НСтр("ru = 'Оранжевый'; en = 'Oreange'");

КонецФункции

// Формирует заголовок "Лиловый" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыЛиловый() Экспорт

	Возврат НСтр("ru = 'Лиловый'; en = 'Purple'");

КонецФункции

// Формирует заголовок "Красный" на языке системы.
// 
// Возвращаемое значение:
//  Строка - Сформированный заголовок.
//
Функция ЗаголовокКомандыОчистить() Экспорт

	Возврат НСтр("ru = 'Очистить'; en = 'Clean'");

КонецФункции

#КонецОбласти