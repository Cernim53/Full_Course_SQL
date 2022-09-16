create database Sales_PZ_6;
go

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


/*Задание 1. 
Для базы данных «Продажи» из практического задания модуля «Работа с таблицами и представлениями в MS SQL Server» выполните набор действий: 
1. Создайте набор clustered (кластеризованных) индексов для тех таблиц, где это необходимо 
2. Создайте набор nonclustered (некластеризованных) индексов для тех таблиц, где это необходимо 
3. Решите нужны ли вам composite (композитные) индексы с учетом структуры базы данных и запросов. Если да, создайте индексы 
4. Решите нужны ли вам indexes with included columns (индексы с включенными столбцами). Учитывайте структуру базы данных и запросов. 
Если необходимость есть, создайте индексы 
5. Решите нужны ли вам filtered indexes (отфильтрованные индексы). Учитывайте структуру базы данных и запросов. Если необходимость есть, создайте индексы 
6. Проверьте execution plans (планы выполнения) для наиболее важных запросов с точки зрения частоты их использования. 
Если найдено слабое место по производительности, попробуйте решить возникшую проблему с помощью создания новых индексов.*/


--1. Создайте набор clustered (кластеризованных) индексов для тех таблиц, где это необходимо 

--Все три таблицы - dbo.Buyers, dbo.Sellers, dbo.ProductSales имеют кластеризованные индексы в виде первичных ключей. В таблице может быть только один кластеризованный индекс,
--поэтому других кластеризованных индексов мы не создаем



--2. Создайте набор nonclustered (некластеризованных) индексов для тех таблиц, где это необходимо 

--Мы можем создать некластеризованные индексы для таблиц с большим количеством записей, чтобы ускорить поиск данных по этим индексам. Для двух таблиц создадим составные
--некластеризованные индексы, включающие данные двух колонок - имени и фамилии продавцов и покупателей

create nonclustered index IX_NonClusteredNameSurnameBuyers on Buyers (Name asc, Surname asc);
go

create nonclustered index IX_NonClusteredNameSurnameSellers on Sellers (Name asc, Surname asc);
go



--3. Решите нужны ли вам composite (композитные) индексы с учетом структуры базы данных и запросов. Если да, создайте индексы 

--В задании 2 уже создал составные индексы для таблиц dbo.Buyers и dbo.Sellers, которые включают две колонки - имя и фамилию покупателей и продавцов.
--Такой индекс даст повышение производительности при поиске покупателей или продавцов по "полному имени и фамилии"
--В задании 2 созданы некластеризованные составные индексы
--Ниже приведен пример полнотабличного индекса

create nonclustered index IX_NonClusteredBuyersAllColumns on Buyers 
(Name asc, Surname asc, Mail asc, Fone asc);
go



--4. Решите нужны ли вам indexes with included columns (индексы с включенными столбцами). Учитывайте структуру базы данных и запросов. 
--Если необходимость есть, создайте индексы 

--Индексы с включенными столбцами позволяют увеличить производительность поиска. При этом короче сами индексы, а значит размер памяти, который они занимают. 
--Но включенные данные при этом сразу доступны
--Ниже приведено несколько примеров индексов с включенными столбцами, которые могут быть полезны для определенных запросов

create nonclustered index IX_NonClusteredNameSurnameBuyersAndFone on Buyers 
(Name asc, Surname asc)
include (Fone);
go

create nonclustered index IX_NonClusteredNameSurnameSellersAndMailFone on Sellers 
(Name asc, Surname asc)
include (Mail, Fone);
go



--5. Решите нужны ли вам filtered indexes (отфильтрованные индексы). Учитывайте структуру базы данных и запросов. Если необходимость есть, создайте индексы 
--Фильтрованные индексы могут быть полезны, когда нужно, чтобы выполнились некоторые условия при поиске и отборе данных
--Ниже приведен пример некластеризованных составных отфильтрованных индексов с включенным столбцом NameSales, который выделяется т.к. имеет формат nvarchar(MAX)

create nonclustered index IX_NonClusteredNamePriceDateOfProductSales on ProductSales 
(Price asc, DateSales asc)
include (NameSales)
where Price is not null and DateSales > '2000-01-01';				--	цена товара not null и дата продажи - после 1 января 2000 года
go


--6. Проверьте execution plans (планы выполнения) для наиболее важных запросов с точки зрения частоты их использования. 
--Если найдено слабое место по производительности, попробуйте решить возникшую проблему с помощью создания новых индексов.

select NameSales as [Название товара], Price as [Стоимость продажи], Buyers.Name+' '+Buyers.Surname as [Покупатель], Sellers.Name+' '+Sellers.Surname as [Продавец], 
DateSales as [Дата продажи]
from ProductSales join Buyers on Buyers.Id=ProductSales.BuyersId
				  join Sellers on Sellers.Id=ProductSales.SellersId
where DateSales > '2020-01-01';
go

--не найдены слабые места спроизводительностью