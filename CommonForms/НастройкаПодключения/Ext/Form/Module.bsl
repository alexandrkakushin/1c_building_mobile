﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ОбменВызовСервера.СброситьСостояниеЗагрузкиЧастейСообщений();

	Набор = Константы.СоздатьНабор();
	Набор.Прочитать();

	ЗначениеВРеквизитФормы(Набор, "НаборКонстант");

	Элементы.ДекорацияВнимание.Видимость = 
		НаборКонстант.МаксимальныйРазмерФайла > 500 
		Или НаборКонстант.МаксимальныйРазмерФайла = 0;

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	УстановитьВидимостьКнопокОчистки();

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если ИмяСобытия = "ПовторитьСинхронизацию" Тогда

		Готово(Неопределено);

	ИначеЕсли ИмяСобытия = "ВыполненоПодключениеКЦентральнойБазе" Тогда

		Закрыть();

	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаборКонстантАдресЦентральнойБазыПриИзменении(Элемент)

	ЗаписатьОбъект();
	УстановитьВидимостьКнопокОчистки();

КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантПользовательЦентральнойБазыПриИзменении(Элемент)

	ЗаписатьОбъект();
	УстановитьВидимостьКнопокОчистки();

КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантПарольПользователяПриИзменении(Элемент)

	ЗаписатьОбъект();
	УстановитьВидимостьКнопокОчистки();

КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантСрокУстареванияДанныхПриИзменении(Элемент)

	ЗаписатьОбъект();

КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантМаксимальныйРазмерФайлаПриИзменении(Элемент)

	ЗаписатьОбъект();

КонецПроцедуры

&НаКлиенте
Процедура НаборКонстантМаксимальныйРазмерФайлаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Элементы.ДекорацияВнимание.Видимость = 
		ВыбранноеЗначение > 500 Или ВыбранноеЗначение = 0;

КонецПроцедуры

&НаКлиенте
Процедура ДекорацияВниманиеНажатие(Элемент)

	ТекстЗаголовка = НСтр("ru = 'Подключение'; en = 'Connection'");
	ТекстСообщения = НСтр("ru = 'Выбранная настройка максимального размера файла может негативно 
							|повлиять на скорость и время первоначального подключения.
							|
							|Рекомендуемый максимальный размер файла не более 500 кб.'; 
							|en = 'The chosen control of the maximum size of the file can negatively 
							|affect the speed and time of initial connection.
							|
							|The recommended maximum size of the file no more than 500 kb.'");

	ПоказатьПредупреждение(, ТекстСообщения, , ТекстЗаголовка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово(Команда)

	ОбменКлиент.ВыполнитьПодключениеКСерверу(ЭтаФорма, НаборКонстант, ДатаНачалаСинхронизации);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УстановитьВидимостьКнопокОчистки()

	Элементы.НаборКонстантАдресЦентральнойБазы.КнопкаОчистки = 
		ЗначениеЗаполнено(НаборКонстант.АдресЦентральнойБазы);

	Элементы.НаборКонстантПользовательЦентральнойБазы.КнопкаОчистки = 
		ЗначениеЗаполнено(НаборКонстант.ПользовательЦентральнойБазы);

	Элементы.НаборКонстантПарольПользователя.КнопкаОчистки = 
		ЗначениеЗаполнено(НаборКонстант.ПарольПользователя);

КонецПроцедуры

&НаСервере
Процедура ЗаписатьОбъект()

	Набор = РеквизитФормыВЗначение("НаборКонстант");
	Набор.Записать();

	ЗначениеВРеквизитФормы(Набор, "НаборКонстант");

	Модифицированность = Ложь;

	ОбновитьПовторноИспользуемыеЗначения();

КонецПроцедуры

#КонецОбласти