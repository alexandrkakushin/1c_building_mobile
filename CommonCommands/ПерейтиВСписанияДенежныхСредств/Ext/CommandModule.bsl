﻿
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	СборСтатистикиВызовСервера.ЗаписатьПоказатель("ОбщаяКоманда.ПерейтиВСписанияДенежныхСредств");

	ОбщегоНазначенияКлиент.ОткрытьРазделСписанияДенежныхСредств(ПараметрыВыполненияКоманды);

КонецПроцедуры

#КонецОбласти
