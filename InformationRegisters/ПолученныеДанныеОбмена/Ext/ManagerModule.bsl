﻿
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавляет запись в регистр ПолученныеДанныеОбмена.
//
// Параметры:
//  ИдентификаторСообщения	 - УникальныйИдентификатор - Идентификатор сообщения;
//  НомерЧасти				 - Число - Номер записываемой части сообщения;
//  ДанныеЧасти				 - ХранилищеЗначения - Данные части сообщения.
//
Процедура ДобавитьЗапись(ИдентификаторСообщения, НомерЧасти, ДанныеЧасти) Экспорт

	МенеджерЗаписиРегистра = РегистрыСведений.ПолученныеДанныеОбмена.СоздатьМенеджерЗаписи();

	МенеджерЗаписиРегистра.ИдентификаторСообщения = ИдентификаторСообщения;
	МенеджерЗаписиРегистра.НомерЧасти    = НомерЧасти;
	МенеджерЗаписиРегистра.Данные        = ДанныеЧасти;
	МенеджерЗаписиРегистра.МоментВремени = ТекущаяУниверсальнаяДатаВМиллисекундах();

	МенеджерЗаписиРегистра.Записать();

КонецПроцедуры

// Удаляет из регистра все записи, относящиеся к указанному сообщению.
//
// Параметры:
//  ИдентификаторСообщения	 - УникальныйИдентификатор - Идентификатор удаляемого сообщения.
//
Процедура УдалитьСообщение(ИдентификаторСообщения) Экспорт

	НаборЗаписейРегистра = РегистрыСведений.ПолученныеДанныеОбмена.СоздатьНаборЗаписей();
	НаборЗаписейРегистра.Отбор.ИдентификаторСообщения.Значение      = ИдентификаторСообщения;
	НаборЗаписейРегистра.Отбор.ИдентификаторСообщения.Использование = Истина;
	НаборЗаписейРегистра.Записать();

КонецПроцедуры

// Собирает из частей первое сообщение
//
// Параметры:
//  Счетчик	 - Число - Номер получаемого сообщения в очереди.
// 
// Возвращаемое значение:
//  Структура - Параметры сообщения обмена
//   ** ИмяФайла               - Строка - Имя файла с записанным сообщением;
//   ** ИдентификаторСообщения - УникальныйИдентификатор - Идентификатор сообщения.
//
Функция ПолучитьСообщение(Счетчик = Неопределено) Экспорт

	ИскомыйИдентификатор = Неопределено;

	Если Счетчик <> Неопределено Тогда

		Выборка        = РегистрыСведений.ПолученныеДанныеОбмена.Выбрать(, "МоментВремени Возр");
		Идентификатор  = Неопределено;
		ТекущийСчетчик = 0;

		Пока Выборка.Следующий() Цикл

			Если Выборка.ИдентификаторСообщения <> Идентификатор Тогда
				Идентификатор  = Выборка.ИдентификаторСообщения;
				ТекущийСчетчик = ТекущийСчетчик + 1;
			КонецЕсли;
			Если ТекущийСчетчик = Счетчик Тогда
				ИскомыйИдентификатор = Идентификатор;
				Прервать;
			КонецЕсли;

		КонецЦикла;

	КонецЕсли;

	ВыборкаПервойЧасти = РегистрыСведений.ПолученныеДанныеОбмена.Выбрать(, "МоментВремени Возр");
	Если ИскомыйИдентификатор = Неопределено Тогда
		ВыборкаПервойЧасти.Следующий();
	Иначе
		Пока ВыборкаПервойЧасти.Следующий() Цикл
			Если ВыборкаПервойЧасти.ИдентификаторСообщения = ИскомыйИдентификатор Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	ИдентификаторСообщения               = ВыборкаПервойЧасти.ИдентификаторСообщения;
	МассивИменФайловЧастейДляОбъединения = Новый Массив;

	СтруктураОтбора = Новый Структура("ИдентификаторСообщения", ИдентификаторСообщения); 
	ВыборкаЧастей   = РегистрыСведений.ПолученныеДанныеОбмена.Выбрать(СтруктураОтбора);

	Пока ВыборкаЧастей.Следующий() Цикл
		ДанныеСообщения = ВыборкаЧастей.Данные.Получить();
		//ИмяВременногоФайла = ПолучитьИмяВременногоФайла("xml");
		//ВыборкаЧастей.Данные.Получить().Записать(ИмяВременногоФайла);
		//МассивИменФайловЧастейДляОбъединения.Добавить(ИмяВременногоФайла);	
	КонецЦикла;

	//ИмяФайлаСообщения = ПолучитьИмяВременногоФайла("xml");
	//ОбъединитьФайлы(МассивИменФайловЧастейДляОбъединения, ИмяФайлаСообщения);

	//Для Каждого Часть Из МассивИменФайловЧастейДляОбъединения Цикл
	//	УдалитьФайлы(Часть);
	//КонецЦикла;

	Сообщение = Новый Структура;
	Сообщение.Вставить("Данные", ДанныеСообщения);
	Сообщение.Вставить("ИдентификаторСообщения", ИдентификаторСообщения);

	Возврат Сообщение;

КонецФункции

// Удаляет все полученные данные обмена и настраивает систему для приема новых данных.
//
Процедура ОчиститьРегистр() Экспорт

	Константы.ИдентификаторПоследнегоЗагруженногоСообщения.Установить(УникальныйИдентификаторПустой());
	Константы.НомерПоследнейЗагруженнойЧастиСообщения.Установить(0);

	НаборЗаписей = РегистрыСведений.ПолученныеДанныеОбмена.СоздатьНаборЗаписей();
	НаборЗаписей.Записать();

КонецПроцедуры

#КонецОбласти

#КонецЕсли

