﻿
#Область ПрограммныйИнтерфейс

// Выводит сообщение с временем когда была последняя синхронизация данных.
//
// Параметры:
//  Элементы					 - ЭлементыФормы - Элементы текущей формы.
//  ОписаниеПоследнегоОбновления - Строка - Описание срока последней синхронизации.
//
Процедура УстановитьПодписьКДатеОбновления(Элементы, ОписаниеПоследнегоОбновления) Экспорт

	ДанныеДляПодписи = ПолучитьПодписьКДатеОбновленияИНаличиеДанныхДляОтправки();
	ОписаниеПоследнегоОбновления = ДанныеДляПодписи.ОписаниеПоследнегоОбновления;

	Если ДанныеДляПодписи.ЕстьНеотправленныеДанные Тогда
		НужнаяСтраница = Элементы.Внимание;
	Иначе
		НужнаяСтраница = Элементы.Обычная;
	КонецЕсли;

	// Отобразим нужную страницу формы, если это необходимо
	Если Не Элементы.ГруппаКнопкаОбновить.ТекущаяСтраница = НужнаяСтраница Тогда
		Элементы.ГруппаКнопкаОбновить.ТекущаяСтраница = НужнаяСтраница;
	КонецЕсли;

КонецПроцедуры

// Начинает процесс синхронизации.
//
// Параметры:
//  ФормаИсточник - Форма - Форма инициатор процедуры обмена;
//
Процедура НачатьСинхронизацию(ФормаИсточник) Экспорт

	// Выполняем проверку, не было ли до этого прерванной очиски базы
	ИнициированаОчисткаБазы = 
		ОбщегоНазначенияВызовСервера.ПолучитьЗначениеКонстанты("ИнициированаОчисткаБазы");
		
	Если ИнициированаОчисткаБазы Тогда
		ОчисткаБазыДанныхКлиент.ПродолжитьОчисткуБазыДанных();
		Возврат;
	КонецЕсли;
	
	// Выполняем проверку, выполнялась синхронизация хотя бы один раз или нет
	ДатаПоследнегоОбновления = 
		ОбщегоНазначенияВызовСервера.ПолучитьЗначениеКонстанты("ДатаПоследнегоОбновления");

	Если ЗначениеЗаполнено(ДатаПоследнегоОбновления) Тогда

		ФормаИсточник.ОтключитьОбработчикОжидания("ОбработчикОжиданияУстановитьПодписьКДатеОбновления");

		ФормаИсточник.Элементы.ГруппаКнопкаОбновить.ТекущаяСтраница = 
			ФормаИсточник.Элементы.ВПроцессе;

		ФормаИсточник.ПодключитьОбработчикОжидания(
			"ВыполнитьСинхронизациюНачало", 0.1, Истина);

	Иначе
		ПоказатьФормуНастройкиПодключения();
	КонецЕсли;

КонецПроцедуры

// Завершает процесс синхронизации
//
// Параметры:
//  ФормаИсточник				 - Форма - Форма инициатор процедуры обмена;
//  СведенияОЗагруженныхДанных	 - Структура - Результат обмена с сервером.
//
Процедура ЗавершитьСинхронизацию(
	ФормаИсточник, СведенияОЗагруженныхДанных = Неопределено) Экспорт

	ОбщегоНазначенияВызовСервера.УстановитьПараметрыСеанса();

	Оповестить("СоздатьУведомления");
	Оповестить("СинхронизацияЗавершена", СведенияОЗагруженныхДанных);

	ОбменКлиент.НайтиИПоказатьОшибкиПриСинхронизации();

	ФормаИсточник.ПодключитьОбработчикОжидания(
		"ОбработчикОжиданияУстановитьПодписьКДатеОбновления", 60, Ложь);

КонецПроцедуры

// Отображает формы выбора способа подключения при если база пустая.
//
Процедура ПоказатьФормуНастройкиПодключения() Экспорт

	ОткрытьФорму("ОбщаяФорма.ВыборСпособаПодключения");

КонецПроцедуры

// Начинает процесс первичного подключения к серверу 1С:Документооборота.
//
// Параметры:
//  ЭтаФорма				 - Форма - Форма, в которой произошел вызов;
//  НаборКонстант			 - КонстантыНабор - Набор констант, хранящий текущие настройки;
//  ДатаНачалаСинхронизации	 - Дата - Дата начала синхронизации.
//
Процедура ВыполнитьПодключениеКСерверу(ЭтаФорма, НаборКонстант, ДатаНачалаСинхронизации) Экспорт

	ЭтоДемоРежим = НРег(НаборКонстант.ПользовательЦентральнойБазы) = "test"
					И НРег(НаборКонстант.ПарольПользователя) = "test";

	ОбщегоНазначенияВызовСервера.УстановитьДемоРежим(ЭтоДемоРежим);

	Если Не ЭтоДемоРежим Тогда
		Если НРег(НаборКонстант.АдресЦентральнойБазы) = "https://" 
		 Или НРег(НаборКонстант.АдресЦентральнойБазы) = "http://" 
		 Или НаборКонстант.АдресЦентральнойБазы = "" Тогда
		
			ЗаголовокПредупреждения = НСтр("ru = 'Подключение'; en = 'Connection'");
			ТекстПредупреждения     = НСтр("ru = 'Не указан адрес сервера.'; 
										|en = 'The server address is not specified'");

			ПоказатьПредупреждение( , ТекстПредупреждения, , ЗаголовокПредупреждения);

			Возврат;

		КонецЕсли;
	КонецЕсли;

	ДатаНачалаСинхронизации = ТекущаяДата();

	ОбщегоНазначенияВызовСервера.ОчиститьОчередьСообщенияИПолученныеДанныеНаСервере();

	ПараметрыОбработчика = Новый Структура;
	ПараметрыОбработчика.Вставить("ЭтаФорма", ЭтаФорма);
	ПараметрыОбработчика.Вставить("ДатаНачалаСинхронизации", ДатаНачалаСинхронизации);

	ОбработчикЗавершения = Новый ОписаниеОповещения("ПодключитьсяЗавершение", ОбменКлиент, 
		ПараметрыОбработчика);

	Форма = ОткрытьФорму("ОбщаяФорма.Синхронизация",, 
		ЭтаФорма,,,, 
		ОбработчикЗавершения, 
		РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);

	ПараметрыВызова = Новый Структура;
	ПараметрыВызова.Вставить("РежимСинхронизации", "ПодключитьНовоеУстройство");
	ПараметрыВызова.Вставить("ДатаНачалаСинхронизации", ДатаНачалаСинхронизации);

	Форма.ВыполнитьСинхронизацию(ПараметрыВызова);

КонецПроцедуры

// Выполняет действия после завершения синхронизации.
//
// Параметры:
//  Результат               - Произвольный - Результат выполнения синхронизации;
//  ДатаНачалаСинхронизации - ДатаВремя - Дата начала процесса синхронизации.
//
Процедура ПодключитьсяЗавершение(Результат, ДатаНачалаСинхронизации) Экспорт

	ЕстьОшибкиПриПодключении = Результат;

	Если ЕстьОшибкиПриПодключении = Ложь Тогда
		Оповестить("ВыполненоПодключениеКЦентральнойБазе", ДатаНачалаСинхронизации);
	КонецЕсли;

КонецПроцедуры

// Показывает пользователю сообщения с ошибками обмена.
//
// Возвращаемое значение:
//  Булево - Истина, если есть ошибки для показа.
//
Функция НайтиИПоказатьОшибкиПриСинхронизации() Экспорт

	ЕстьОшибки = Ложь;
	МоментыВремениСобытий = 
		ОбщегоНазначенияВызовСервера.ПолучитьОтметкиВремениНепоказанныеОшибок(Ложь);

	Если МоментыВремениСобытий.Количество() > 0 Тогда

		ПараметрыФормы = Новый Структура("МоментыВремениСобытий", МоментыВремениСобытий);
		ОткрытьФорму("РегистрСведений.ПротоколСобытий.Форма.ФормаСпискаСобытий", ПараметрыФормы);

		ЕстьОшибки = Истина;

	КонецЕсли;

	Возврат ЕстьОшибки;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьПодписьКДатеОбновленияИНаличиеДанныхДляОтправки()

	ТекущаяДата = ТекущаяДата();
	ДатаПоследнегоОбновления = Дата(1,1,1);
	ЕстьДанныеДляОтправки = Ложь;

	ОбщегоНазначенияВызовСервера.ПолучитьДатуПоследнегоОбновленияИНаличиеДанныхДляОтправки(
		ДатаПоследнегоОбновления, ЕстьДанныеДляОтправки);

	Если Не ЗначениеЗаполнено(ДатаПоследнегоОбновления) Тогда

		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Не настроено подключение'; en = 'Check connection settings'");

		СтруктураВозврата = Новый Структура;
		СтруктураВозврата.Вставить("ОписаниеПоследнегоОбновления", ОписаниеПоследнегоОбновления);
		СтруктураВозврата.Вставить("ЕстьНеотправленныеДанные"    , Ложь);

	Иначе

		Период = (ТекущаяДата - ДатаПоследнегоОбновления)/60;
		ОписаниеПоследнегоОбновления = 
			ПолучитьОписаниеПоследнегоОбновления(Период, ТекущаяДата, ДатаПоследнегоОбновления);

		СтруктураВозврата = Новый Структура;
		СтруктураВозврата.Вставить("ОписаниеПоследнегоОбновления", ОписаниеПоследнегоОбновления);
		СтруктураВозврата.Вставить("ЕстьНеотправленныеДанные"    , ЕстьДанныеДляОтправки);

	КонецЕсли;

	Возврат СтруктураВозврата;

КонецФункции

Функция ПолучитьОписаниеПоследнегоОбновления(Период, ТекущаяДата, ДатаПоследнегоОбновления)

	ОписаниеПоследнегоОбновления = "";

	Если Период < 1 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено только что'; en = 'Updated just now'");

	ИначеЕсли Период < 2 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено минуту назад'; en = 'Updated a minute ago'");

	ИначеЕсли Период < 3 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено 2 минуты назад'; en = 'Updated 2 minutes ago'");

	ИначеЕсли Период < 4 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено 3 минуты назад'; en = 'Updated 3 minutes ago'");

	ИначеЕсли Период < 5 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено 4 минуты назад'; en = 'Updated 4 minutes ago'");

	ИначеЕсли Период < 6 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено 5 минуты назад'; en = 'Updated 5 minutes ago'");

	ИначеЕсли Период < 15 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено 15 минут назад'; en = 'Updated 15 minutes ago'");

	ИначеЕсли Период < 30 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено 30 минут назад'; en = 'Updated 30 minutes ago'");

	ИначеЕсли Период < 60 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено менее часа назад'
			   |; en = 'Updated less than an hour ago'");

	ИначеЕсли Период < 120 Тогда
		ОписаниеПоследнегоОбновления = 
			НСтр("ru = 'Обновлено менее 2 часов назад'
			   |; en = 'Updated less than an 2 hours ago'");

	ИначеЕсли ДатаПоследнегоОбновления < КонецДня(ТекущаяДата) 
		И ДатаПоследнегоОбновления > НачалоДня(ТекущаяДата) Тогда
		ОписаниеПоследнегоОбновления = 
			СтрШаблон(
				НСтр("ru = 'Обновлено сегодня в %1'; en = 'Updated today at %1'"),
				Формат(ДатаПоследнегоОбновления, "ДФ='HH:mm'"));

	ИначеЕсли ДатаПоследнегоОбновления < НачалоДня(ТекущаяДата)
		И ДатаПоследнегоОбновления > НачалоДня(ТекущаяДата - 24*60*60) Тогда
		ОписаниеПоследнегоОбновления = 
			СтрШаблон(
				НСтр("ru = 'Обновлено вчера в %1'; en = 'Updated yesterday at %1'"),
				Формат(ДатаПоследнегоОбновления, "ДФ='HH:mm'"));

	Иначе
		ОписаниеПоследнегоОбновления = 
			СтрШаблон(
				НСтр("ru = 'Обновлено %1'; en = 'Updated %1'"),
				Формат(ДатаПоследнегоОбновления, "ДФ='dd.MM.yyyy HH:mm'"));
	КонецЕсли;

	Возврат ОписаниеПоследнегоОбновления;

КонецФункции 

#КонецОбласти