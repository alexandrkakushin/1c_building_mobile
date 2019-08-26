﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче 
	// параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	Страницы = Неопределено;
	Отказ    = Не Параметры.Свойство("Страницы", Страницы);

	Отказ    = Истина;

	Если Отказ Тогда
		Возврат;
	КонецЕсли;

	Для Каждого Страница Из Страницы Цикл

		Элементы["Версия"+Страница].Видимость = Истина;

	КонецЦикла;

КонецПроцедуры

#КонецОбласти
