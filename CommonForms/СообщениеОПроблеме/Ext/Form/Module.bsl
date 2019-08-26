﻿
#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Отправить(Команда)

	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче 
	// параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	Если ЗначениеЗаполнено(ОписаниеПроблемы) Тогда
		Возврат;
	КонецЕсли;

	Попытка

		ОбменВызовСервера.ОтправитьИПолучитьДанные(ТекущаяДата(), "ОтправитьОтчетОПроблеме", Ложь, ОписаниеПроблемы);

		ТекстЗаголовка = НСтр("ru = 'Сообщение успешно отправлено'; en = 'Message sent'");
		ТекстПредупреждения = НСтр("ru = 'Ответственные лица оповещены о проблеме.'; en = 'Responsible persons are notified on a problem.'");

		ПоказатьПредупреждение( , ТекстПредупреждения, , ТекстЗаголовка);

		Закрыть();

	Исключение

		Инфо = ИнформацияОбОшибке();

		РаботаСПротоколомСобытийВызовСервера.ДобавитьОшибку(ПодробноеПредставлениеОшибки(Инфо));

		ТекстЗаголовка = НСтр("ru = 'Ошибка при отправке сообщения'; en = 'Message not sent'");
		ТекстПредупреждения = 
			НСтр("ru = 'Не удалось отправить сообщение. 
				|Воспользуйтесь другими способами связи. 
				|Текст сообщения можно скопировать.
				|Подробности ошибки см. в протоколе'; en = 'Message not sent.
				|Try another way of communication
				|Message text may be copied.
				|See events protocol for details.'");

		ПоказатьПредупреждение( , ТекстПредупреждения, , ТекстЗаголовка);

	КонецПопытки;

КонецПроцедуры

#КонецОбласти

