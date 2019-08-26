﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ЗаполнитьСписокРазделов();

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если ИмяСобытия = "ВыполненоПодключениеКЦентральнойБазе" 
		Или ИмяСобытия = "ВыполненоПолноеУдаление" Тогда
		Закрыть();

	ИначеЕсли ИмяСобытия = "ИзмененРежимРаботыПриложения" Тогда
		ЗаполнитьСписокРазделов();

	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТабличнойЧастиСписокРазделов

&НаСервере
Процедура ЗаполнитьСписокРазделов()

	ОбщегоНазначенияВызовСервера.ЗаполнитьСписокРазделовНастроек(СписокРазделов);

КонецПроцедуры

&НаКлиенте
Процедура СписокРазделовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	
	ВыбраннаяСтрока = Элементы.СписокРазделов.ТекущиеДанные;

	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Раздел", ВыбраннаяСтрока.Раздел);
	ПараметрыФормы.Вставить("Заголовок", ВыбраннаяСтрока.Описание);

	ОткрытьФорму("ОбщаяФорма.НастройкиТелефонСтраницы", ПараметрыФормы, ЭтаФорма);

КонецПроцедуры

#КонецОбласти

