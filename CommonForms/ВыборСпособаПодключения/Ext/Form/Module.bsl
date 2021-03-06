﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	СтрокаТаб = ТаблицаКоманд.Добавить();
	СтрокаТаб.Команда = "НастроитьВручную";
	СтрокаТаб.ОписаниеКоманды = 
		НСтр("ru = 'Настроить подключение вручную'; 
			 |en = 'Set manually'");
	СтрокаТаб.Пояснение = 
		НСтр("ru = 'Адрес подключения, имя пользователя и пароль будут введены вручную.'; 
			 |en = 'Server addres, user name and password must be set manually'");

	СтрокаТаб = ТаблицаКоманд.Добавить();
	СтрокаТаб.Команда = "ДемоРежим";
	СтрокаТаб.ОписаниеКоманды = 
		НСтр("ru = 'Попробовать с демо-данными'; 
			 |en = 'Try demo-mode'");
	СтрокаТаб.Пояснение = 
		НСтр("ru = 'Программа будет заполнена демонстрационными данными.'; 
			 |en = 'The program will be filled with demonstration data'");

	НаборКонстант.ПериодПервичнойЗагрузкиДанных = 7;

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если ИмяСобытия = "ВыполненоПодключениеКЦентральнойБазе" Тогда
		ПодключитьОбработчикОжидания("ЗакрытьФорму", 0.1, Истина);
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ТаблицаКомандВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;

	ТекущиеДанные = Элементы.ТаблицаКоманд.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Режим = ТекущиеДанные.Команда;
	Если Режим = "НастроитьВручную" Тогда
		НастроитьВручную();

	ИначеЕсли Режим = "ДемоРежим" Тогда
		ЗаполнитьДемоДанными();

	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура НастроитьВручную()

	ОткрытьФорму("ОбщаяФорма.НастройкаПодключения");

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДемоДанными()

	НаборКонстант.АдресЦентральнойБазы        = "";
	НаборКонстант.ПользовательЦентральнойБазы = "test";
	НаборКонстант.ПарольПользователя          = "test";
	НаборКонстант.ПериодПервичнойЗагрузкиДанных = 180;

	ЗаписатьОбъект();

	ОбменКлиент.ВыполнитьПодключениеКСерверу(ЭтаФорма, НаборКонстант, ДатаНачалаСинхронизации);

КонецПроцедуры


&НаКлиенте
Процедура ОбработчикЧтенияШтрихКода(ДанныеШтрихКода, Результат, Сообщение, ДопПараметры) Экспорт

	Если Результат Или Не ЗначениеЗаполнено(Сообщение) Тогда

		#Если МобильноеПриложениеКлиент Тогда
			СредстваМультимедиа.ЗакрытьСканированиеШтрихКодов();
		#КонецЕсли

		ОбработатьШтрихКод(ДанныеШтрихКода);

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработчикРучногоВводаШтрихкода(ДанныеШтрихКода, ДопПараметры) Экспорт

	Если ЗначениеЗаполнено(ДанныеШтрихКода) Тогда
		ОбработатьШтрихКод(ДанныеШтрихКода);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработатьШтрихКод(ДанныеШтрихКода)

	// Разбираем полученный код на составляющие
	ПараметрыПодключения = СтрРазделить(ДанныеШтрихКода, ";");

	// Выполняем проверку количества полученных параметров
	Если Не ПараметрыПодключения.Количество() = 6 Тогда

		ЗаголовокПодключения = Заголовок;
		ТекстПредупреждения = СтрШаблон(
			НСтр("ru = 'Ожидаемое количество полей в QR-коде 6, прочитано %1'; 
				|en = 'The expected quantity of fields in a QR code 6, is read %1'"),
			ПараметрыПодключения.Количество());

		ПоказатьПредупреждение(, ТекстПредупреждения, ,ЗаголовокПодключения);
		Возврат;

	КонецЕсли;
	
	НаборКонстант.АдресЦентральнойБазы = ПараметрыПодключения[0];
	НаборКонстант.ПользовательЦентральнойБазы = ПараметрыПодключения[1];
	НаборКонстант.ПодробнаяИнформацияОСинхронизации = Число(ПараметрыПодключения[3]);
	
	СрокХранения = Число(ПараметрыПодключения[4]) * 86400;
	
	Если СрокХранения <= 0 Тогда
		// храним всегда
		НаборКонстант.ХранитьЗаписиКалендаряВТечениеПериода = -1;
		НаборКонстант.ХранитьПисьмаВТечениеПериода = -1;
	ИначеЕсли СрокХранения <= 86400 Тогда
		НаборКонстант.ХранитьЗаписиКалендаряВТечениеПериода = 86400;
		НаборКонстант.ХранитьПисьмаВТечениеПериода = 86400
	ИначеЕсли СрокХранения > 86400 И СрокХранения <= 604800 Тогда
		НаборКонстант.ХранитьЗаписиКалендаряВТечениеПериода = 604800;
		НаборКонстант.ХранитьПисьмаВТечениеПериода = 604800
	ИначеЕсли СрокХранения > 604800 И СрокХранения <= 2592000 Тогда
		НаборКонстант.ХранитьЗаписиКалендаряВТечениеПериода = 2592000;
		НаборКонстант.ХранитьПисьмаВТечениеПериода = 2592000
	ИначеЕсли СрокХранения > 2592000 И СрокХранения <= 15552000 Тогда
		НаборКонстант.ХранитьЗаписиКалендаряВТечениеПериода = 15552000;
		НаборКонстант.ХранитьПисьмаВТечениеПериода = 15552000
	ИначеЕсли СрокХранения > 15552000  Тогда
		НаборКонстант.ХранитьЗаписиКалендаряВТечениеПериода = 31536000;
		НаборКонстант.ХранитьПисьмаВТечениеПериода = 31536000
	КонецЕсли;
	
	МаксРазмерФайла = Число(ПараметрыПодключения[5]);
	Если МаксРазмерФайла = 1 Или МаксРазмерФайла = 0 Тогда
		// Загружаем только заголовки
		НаборКонстант.МаксимальныйРазмерФайла = 1; 
	ИначеЕсли МаксРазмерФайла > 1 И МаксРазмерФайла <= 100 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 100;
	ИначеЕсли МаксРазмерФайла > 100 И МаксРазмерФайла <= 200 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 200;
	ИначеЕсли МаксРазмерФайла > 200 И МаксРазмерФайла <= 300 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 300;
	ИначеЕсли МаксРазмерФайла > 300 И МаксРазмерФайла <= 400 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 400;
	ИначеЕсли МаксРазмерФайла > 400 И МаксРазмерФайла <= 500 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 500;
	ИначеЕсли МаксРазмерФайла > 500 И МаксРазмерФайла <= 1024 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 1024;
	ИначеЕсли МаксРазмерФайла > 1024 И МаксРазмерФайла <= 2048 Тогда
		НаборКонстант.МаксимальныйРазмерФайла = 2048;
	Иначе
		// Загружаем полностью
		НаборКонстант.МаксимальныйРазмерФайла = 0; 
	КонецЕсли;

	ЗаписатьОбъект();

	Если НРег(ПараметрыПодключения[1]) = "test" Тогда
		ЗаполнитьДемоДанными();
	Иначе
		ОткрытьФорму("ОбщаяФорма.НастройкаПодключения");
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаписатьОбъект()

	Набор = РеквизитФормыВЗначение("НаборКонстант");
	Набор.Записать();

	ЗначениеВРеквизитФормы(Набор, "НаборКонстант");

	Модифицированность = Ложь;

	ОбновитьПовторноИспользуемыеЗначения();

КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму()

	Закрыть();

КонецПроцедуры

#КонецОбласти
