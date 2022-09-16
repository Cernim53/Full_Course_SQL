
/*Задание 1. Создайте следующие пользовательские функции: 
1. Пользовательская функция возвращает приветствие в стиле «Hello, ИМЯ!» Где ИМЯ передаётся в качестве параметра. 
Например, если передали Nick, то будет Hello, Nick! 
2. Пользовательская функция возвращает информацию о текущем количестве минут 
3. Пользовательская функция возвращает информацию о текущем годе 
4. Пользовательская функция возвращает информацию о том: чётный или нечётный год 
5. Пользовательская функция принимает число и возвращает yes, если число простое и no, если число не простое.  
6. Пользовательская функция принимает в качестве параметров пять чисел. Возвращает сумму минимального и максимального значения 
из переданных пяти параметров
7. Пользовательская функция показывает все четные или нечетные числа в переданном диапазоне. 
Функция принимает три параметра: начало диапазона, конец диапазона, чёт или нечет показывать. */

use Sales_PZ_4;
go


--1. Пользовательская функция возвращает приветствие в стиле «Hello, ИМЯ!» Где ИМЯ передаётся в качестве параметра. 
--Например, если передали Nick, то будет Hello, Nick! 

create function HelloMan(@Name nvarchar(20))
returns table
as
return select 'Hello, ' + @Name + '!' as [Приветствие];
go

--проверка
select * from HelloMan('Андрей');
go


--2. Пользовательская функция возвращает информацию о текущем количестве минут 

create function HowIsMinute()
returns table
as
return select datename(minute, getdate()) as [Текущие минуты];
go

--проверка
select * from HowIsMinute();
go


--3. Пользовательская функция возвращает информацию о текущем годе 

create function WhatYearIsIt()
returns table
as
return select year(getdate()) as [Текущий год];
go

--проверка

select * from WhatYearIsIt();
go


--4. Пользовательская функция возвращает информацию о том: чётный или нечётный год 

create function IsYearEvenOreOdd()
returns nvarchar(20)
as
begin
declare @Answer nvarchar(20)
if year(getdate())%2 = 0
set @Answer = 'Четный год'
else
set @Answer = 'Нечетный год'
return @Answer 
end;
go

--проверка

select dbo.IsYearEvenOreOdd();
go


--5. Пользовательская функция принимает число и возвращает yes, если число простое и no, если число не простое.  

create function isNumberPrime(@Number int)
returns nvarchar(5)
as
begin
declare @Answer nvarchar(5), @iterator int = 2
if @Number<2										--простое число - это целое положительное число, больше 1, кот. делится только на 1 и на само себя
begin 
	set @Answer = 'нет'
	goto Answer
end
while @iterator < @Number							--цикл - проход по числам от 2 до введенного числа @Number
begin
	if @Number%@iterator = 0						--проверка на деление без остатка чисел в интервале до числа @Number; если есть хотя бы одно такое число,  
	begin											--то @Number не является простым
	set @Answer = 'нет'
	goto Answer
end
set @iterator += 1
end													--конец цикла

set @Answer = 'да'
Answer:
return @Answer
end;
go

--проверка

select dbo.isNumberPrime(7) as [Является ли число простым ?];
go


--6. Пользовательская функция принимает в качестве параметров пять чисел. Возвращает сумму минимального и максимального значения 
--из переданных пяти параметров

create function sumMinAndMax(@Number1 int, @Number2 int, @Number3 int, @Number4 int, @Number5 int)
returns int
as
begin
declare @Sum int, @Max int, @Min int
declare @NumberArray table (Number int)		--создаем табличную переменную @NumberArray, куда заносим все 5 входящих параметров - чисел

insert into @NumberArray(Number) values (@Number1) 
insert into @NumberArray(Number) values (@Number2) 
insert into @NumberArray(Number) values (@Number3) 
insert into @NumberArray(Number) values (@Number4) 
insert into @NumberArray(Number) values (@Number5) 

set @Max = (select Max(Number) from @NumberArray)
set @Min = (select Min(Number) from @NumberArray)
set @Sum = @Max + @Min
return @Sum
end;
go


--проверка

select dbo.sumMinAndMax(143, 1, 999, 254, -33) as [Сумма min и max];
go

--7. Пользовательская функция показывает все четные или нечетные числа в переданном диапазоне. 
--Функция принимает три параметра: начало диапазона, конец диапазона, чёт или нечет показывать

create function IsNumberEvenOreOdd(@BeginRange int, @EndRange int, @isEvenOreOdd bit)
returns @NumbersTable table (Numbers int) 
as
begin
declare @iterator int
set @iterator = @BeginRange

if @isEvenOreOdd = 0
begin
	while @iterator <= @EndRange
	begin
		if @iterator%2!=0
		insert into @NumbersTable(Numbers) values(@iterator)
		set @iterator+=1
	end
end
if @isEvenOreOdd = 1
begin
	while @iterator <= @EndRange
	begin
		if @iterator%2=0
		insert into @NumbersTable(Numbers) values(@iterator)
		set @iterator+=1
	end
end
return 
end;
go

--проверка
--0 - нечетные числа
--1 - четные числа

select Numbers as [Перечень четных/нечетных чисел в заданном интервале]
from IsNumberEvenOreOdd(35, 124, 0);
go


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

create database Sales_PZ_4

--создадим таблицы

create table Sellers
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Mail nvarchar(100) null default('unknown'),
Fone nvarchar(20) null default('unknown'),
);
go

create table Buyers
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Mail nvarchar(100) null default('unknown'),
Fone nvarchar(20) null default('unknown'),
);
go

create table ProductSales
(
Id int identity(1,1) not null primary key,
SellersId int not null foreign key references Sellers(Id) on delete cascade,
BuyersId int not null foreign key references Buyers(Id) on delete cascade,
NameSales nvarchar(MAX) not null,
Price money check(Price>0) not null,
DateSales date not null,
);
go

--заполним базу данными

insert into Sellers (Name, Surname, Mail, Fone) values
					('Олег', 'Степанов', 'OlegSt@gmail.com', '22-33-45'),
					('Илья', 'Мартынов', 'Martyn@gmail.com', '32-17-63'),
					('Светлана', 'Кобзева', 'Svetic@gmail.com', '34-23-07'),
					('Антон', 'Пичугов', 'API@gmail.com', '42-86-99'),
					('Ирма', 'Мацакария', 'WAch@gmail.com', '24-35-84');
go

insert into Buyers (Name, Surname, Mail, Fone) values
					('Ирина', 'Положай', 'IPOL@gmail.com', '22-15-03'),
					('Надежда', 'Средовская', 'Sreda@gmail.com', '54-76-01'),
					('Артур', 'Коньков', 'Artchy@gmail.com', '32-90-74'),
					('Яков', 'Степанян', 'Stepa@gmail.com', '36-80-21'),
					('Мария', 'Кожедубова', 'MariyaKo@gmail.com', '41-41-80');
go

insert into ProductSales (SellersId, BuyersId, NameSales, Price, DateSales) values
					( 1, 1, 'дом', 235000, '2020-05-16'),
					( 2, 2, 'дача', 125000, '2020-07-11'),
					( 3, 3, 'гараж', 50000, '2019-10-03'),
					( 4, 4, 'автомобиль', 180000, '2020-08-01'),
					( 5, 5, 'велосипед', 8000, '2019-02-07'),
					( 4, 4, 'прицеп', 60000, '2020-08-01');
go


/*Задание 2. 
Для базы данных «Продажи» из практического задания модуля «Работа с таблицами и представлениями в MS SQL Server» создайте следующие пользовательские функции: 
1. Пользовательская функция возвращает минимальную продажу конкретного продавца. ФИО продавца передаётся в качестве параметра пользовательской функции 
2. Пользовательская функция возвращает минимальную покупку конкретного покупателя. ФИО покупателя передаётся в качестве параметра пользовательской функции 
3. Пользовательская функция возвращает общую сумму продаж на конкретную дату. Дата продажи передаётся в качестве параметра 
4. Пользовательская функция возвращает дату, когда общая сумма продаж за день была максимальной 
5. Пользовательская функция возвращает информацию о всех продажах заданного товара. Название товара передаётся в качестве параметра 
6. Пользовательская функция возвращает информацию о всех продавцах однофамильцах 
7. Пользовательская функция возвращает информацию о всех покупателях однофамильцах 
8. Пользовательская функция возвращает информацию о всех покупателях и продавцах однофамильцах.*/


--1. Пользовательская функция возвращает минимальную продажу конкретного продавца. ФИО продавца передаётся в качестве параметра пользовательской функции 

create function minSalesOneSellers(@Name nvarchar(50), @Surname nvarchar(50))
returns table
as
return (select Min(Price) as [Минимальная продажа]
	    from ProductSales join Sellers on Sellers.Id=ProductSales.SellersId
		group by Name, Surname
		having Name = @Name and Surname = @Surname);
go


--проверка

select * from minSalesOneSellers('Антон', 'Пичугов');
go


--2. Пользовательская функция возвращает минимальную покупку конкретного покупателя. ФИО покупателя передаётся в качестве параметра пользовательской функции 

create function minSalesOneBuyers(@Name nvarchar(50), @Surname nvarchar(50))
returns table
as
return (select Min(Price) as [Минимальная продажа]
	    from ProductSales join Buyers on Buyers.Id=ProductSales.SellersId
		group by Name, Surname
		having Name = @Name and Surname = @Surname);
go


--проверка

select * from minSalesOneBuyers('Яков', 'Степанян');
go


--3. Пользовательская функция возвращает общую сумму продаж на конкретную дату. Дата продажи передаётся в качестве параметра 

create function totalSalesOnDate(@dateSales date)
returns table
as
return (select Sum(Price) as [Общая сумма продаж в данный день]
	    from ProductSales 
		group by DateSales
		having DateSales = @dateSales);
go


--проверка

select * from totalSalesOnDate('2020-08-01');
go


--4. Пользовательская функция возвращает дату, когда общая сумма продаж за день была максимальной 

create function getDateMaxSales()
returns table
as
return (select DateSales as [Дата], sum(Price) as [Общая сумма продаж за день] 
		from ProductSales
		group by DateSales
		having sum(Price) >= all(select sum(Price) from ProductSales group by DateSales));
go


--проверка

select * from getDateMaxSales();
go


--5. Пользовательская функция возвращает информацию о всех продажах заданного товара. Название товара передаётся в качестве параметра 
--добавим записей

insert into ProductSales(SellersId, BuyersId, NameSales, Price, DateSales)
values (1, 5, 'гараж', 63000, getdate());
go
insert into ProductSales(SellersId, BuyersId, NameSales, Price, DateSales)
values (5, 2, 'гараж', 46000, getdate());
go

--

create function infoAboutAllSalesOneProduct(@NameProductSales nvarchar(max))
returns table
as
return (select NameSales as [Наименование товара], Price as [Цена], Buyers.Name +' ' +Buyers.Surname as [Покупатель], Sellers.Name+ ' '+ Sellers.Surname as [Продавец], 
DateSales as [Дата продажи]
		from ProductSales join Buyers on Buyers.Id=ProductSales.BuyersId 
						  join Sellers on Sellers.Id=ProductSales.SellersId
		where NameSales = @NameProductSales);
go


--проверка

select * from infoAboutAllSalesOneProduct('гараж');
go

--6. Пользовательская функция возвращает информацию о всех продавцах однофамильцах 
--добавим записей

insert into Sellers(Name, Surname)
values ('Артем', 'Степанов');
go
insert into Sellers(Name, Surname)
values ('Алиса', 'Кобзева');
go
--


create function infoAboutSellersNameSakes()
returns table
as
return (select top(100) Name+' '+Surname as [Продавцы однофамильцы]		--top(100) использовал, чтобы можно было применить order by
		from Sellers
		where Surname in (select Surname
						  from Sellers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name);
go

--проверка

select * from infoAboutSellersNameSakes();
go


--7. Пользовательская функция возвращает информацию о всех покупателях однофамильцах 
--добавим записей

insert into Buyers(Name, Surname)
values ('Сергей', 'Положай');
go
insert into Buyers(Name, Surname)
values ('Карине', 'Степанян');
go
--

create function infoAboutBuyersNameSakes()
returns table
as
return (select top(100) Name+' '+Surname as [Покупатели однофамильцы]		
		from Buyers
		where Surname in (select Surname
						  from Buyers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name);
go

--проверка

select * from infoAboutBuyersNameSakes();
go


--8. Пользовательская функция возвращает информацию о всех покупателях и продавцах однофамильцах.

create function infoAboutAllBuyersAndSellersNameSakes()
returns table
as
return (select top(100) 'Продавцы' as [Продавцы или покупатели], Name+' '+Surname as [Однофамильцы]		
		from Sellers
		where Surname in (select Surname
						  from Sellers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name
		union all
		select top(100) 'Покупатели' as [Продавцы или покупатели], Name+' '+Surname as [Однофамильцы]		
		from Buyers
		where Surname in (select Surname
						  from Buyers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name);
go

--проверка

select * from infoAboutAllBuyersAndSellersNameSakes();
go

