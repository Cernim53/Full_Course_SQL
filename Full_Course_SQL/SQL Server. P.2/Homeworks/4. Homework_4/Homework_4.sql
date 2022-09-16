create database SportShop_HW_4;
go

create table Gender
(
Id int identity(1,1) primary key,
Name nvarchar(10) check (Name<>'') not null,
);
go
create table Position
(
Id int identity(1,1) primary key,
Name nvarchar(30) check(Name<>'') default('сотрудник') not null,
);
go
create table Employees
(
Id int identity(1,1) primary key,
Name nvarchar(50) check (Name<>'') not null,
Surname nvarchar(50) check (Surname<>'') not null,
PositionId int not null foreign key references Position(Id),
RecruitmentDate date not null,
GenderId int not null foreign key references Gender(Id),
Salary money check(Salary>0) not null,
);
go
create table Clients
(
Id int identity(1,1) primary key,
Name nvarchar(50) check (Name<>'') not null,
Surname nvarchar(50) check (Surname<>'') not null,
Email nvarchar(100) null,
Fone nvarchar(20) null,
GenderId int not null foreign key references Gender(Id),
PurchaseHistory nvarchar(MAX) null,
Discount real default(0.0) not null,
MailingList bit default(0) not null,
BirthDate date not null,
);
go
create table Manufacturer
(
Id int identity(1,1) primary key,
Name nvarchar(100) check(Name<>'') not null,
);
go
create table TypeProduct
(
Id int identity(1,1) not null primary key ,
Name nvarchar(50) check(Name<>'') not null,
);
go
create table Products
(
Id int identity(1,1) not null primary key ,
Name nvarchar(50) check(Name<>'') not null,
TypeProductId int not null foreign key references TypeProduct(Id),
StockNumber int default(0) not null,
CostPrice money check(CostPrice>0) null,
Price money check(Price>0) not null,
Details nvarchar(100) null,
ManufacturerId int not null foreign key references Manufacturer(Id),
);
go
create table Sales
(
Id int identity(1,1) not null primary key,
ProductsId int not null foreign key references Products(Id) on delete cascade,
Number int default(0) not null,
DateSales date default(getdate()) not null,
EmployeesId int not null foreign key references Employees(Id) on delete cascade,
ClientsId int null foreign key references Clients(Id) on delete cascade,
);
go

--заполним ее данными

insert into Gender (Name) values
								('мужчина'),
								('женщина');
go
insert into Position (Name) values
								('менеджер по продажам'),
								('менеджер');
go
insert into Employees (Name, Surname, PositionId, RecruitmentDate, GenderId, Salary) values
								('Анна', 'Чистякова', 1, '2018-05-23', 2, 10000),
								('Ирина', 'Скоропадская', 1, '2015-11-05', 2, 12000),
								('Сергей', 'Новиков', 2, '2019-03-21', 1, 11000),
								('Юрий', 'Антифеев', 2, '2012-07-13', 1, 13000);
go
insert into Clients(Name, Surname, GenderId, Discount, MailingList, BirthDate) values
								('Семен', 'Степанов', 1, 12.5, 0, '1980-07-13'),
								('Алена', 'Михайлова', 2, 7.5, 0, '1972-11-09'),
								('Влад', 'Ярославский', 1, 15, 1, '2000-04-03'),
								('Николай', 'Амбросимов', 1, 7, 1, '1975-09-28'),
								('Юлия', 'Венедиктова', 2, 10.5, 0, '1997-08-27'),
								('Ольга', 'Чепурнова', 2, 5, 0, '2003-12-29'),
								('Анатолий', 'Бобров', 1, 10, 0, '1986-01-10'),
								('Ярослав', 'Коновалов', 1, 15, 1, '1995-03-19'),
								('Степан', 'Фомин', 1, 5, 0, '1974-12-29'),
								('Юлия', 'Николаева', 2, 10, 0, '1975-01-19');
go
insert into Manufacturer(Name) values
								('Спортобувь'),
								('Спортодежда'),
								('Спортинвентарь'),
								('Спорттехника');
go
insert into TypeProduct(Name) values
								('кроссовки'),
								('кеды'),
								('мокасины'),
								('кепки'),
								('куртки'),
								('спортивные костюмы'),
								('гири'),
								('мячи'),
								('теннисные ракетки'),
								('батуты'),
								('беговые дорожки'),
								('тренажеры');
go
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId) values
								('Найк', 1, 100, 1700, 1),
								('Адидас', 1, 98, 1650, 1),
								('Пума', 1, 110, 1780, 1),
								('Ли Купер', 2, 93, 750, 1),
								('Скечерс', 2, 87, 1100, 1),
								('Адидас', 2, 99, 1500, 1),
								('Бастион', 3, 66, 1500, 1),
								('Конорс', 3, 33, 950, 1),
								('Виолетта', 3, 46, 700, 1),
								('Нью веар', 4, 88, 190, 2),
								('Snapback M&JJ', 4, 102, 350, 2),
								('Babolat cup', 4, 93, 250, 2),
								('DeFacto', 5, 96, 560, 2),
								('Under Armor', 5, 88, 950, 2),
								('Emerson', 5, 75, 590, 2),
								('Пума', 6, 110, 2900, 2),
								('Адидас', 6, 115, 1700, 2),
								('Нью Баланс', 6, 77, 1500, 2),
								('LiveUp', 7, 36, 192, 3),
								('Spart', 7, 47, 530, 3),
								('Hop-Sport', 7, 49, 380, 3),
								('Найк Меркуриал', 8, 96, 790, 3),
								('Феррари', 8, 43, 900, 3),
								('Select Street', 8, 97, 650, 3),
								('Wilson Court Zone', 9, 56, 700, 3),
								('Wilson blade tean', 9, 32, 1100, 3),
								('Babolat pure aero', 9, 21, 1500, 3),
								('Fun fit', 10, 5, 5450, 4),
								('Atleto', 10, 4, 4600, 4),
								('Kidigo', 10, 2, 7800, 4),
								('EnergyFit', 11, 6, 9000, 4),
								('WiciGer ', 11, 3, 22000, 4),
								('Sporttop Wave ', 11, 1, 39900, 4),
								('Supretto Six', 12, 7, 2400, 4),
								('RN-Sport Super', 12, 3, 6100, 4),
								('Inter Atletica Максима', 12, 1, 31900, 4);
go
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values
								( 1, 1, '2020-06-14', 1, 1),
								( 8, 1, '2020-06-14', 1, 1),
								( 11, 1, '2020-06-14', 2, 1),
								( 14, 1, '2020-06-14', 2, 1),
								( 18, 1, '2020-06-14', 2, 1),
								( 19, 1, '2020-06-14', 3, 1),
								( 26, 2, '2020-06-14', 3, 1),

								( 2, 1, '2020-06-17', 1, 2),
								( 4, 1, '2020-06-17', 1, 2),
								( 12, 2, '2020-06-17', 2, 2),
								( 13, 1, '2020-06-17', 2, 2),
								( 17, 1, '2020-06-17', 2, 2),
								( 23, 2, '2020-06-17', 3, 2),
								( 27, 2, '2020-06-17', 3, 2),

								( 3, 20, '2020-06-22', 1, 3),
								( 5, 20, '2020-06-22', 1, 3),
								( 10, 20, '2020-06-22', 2, 3),
								( 15, 20, '2020-06-22', 2, 3),
								( 16, 20, '2020-06-22', 2, 3),
								( 19, 3, '2020-06-22', 3, 3),
								( 20, 3, '2020-06-22', 3, 3),
								( 21, 6, '2020-06-22', 3, 3),
								( 22, 8, '2020-06-22', 3, 3),
								( 24, 8, '2020-06-22', 3, 3),
								( 25, 10, '2020-06-22', 3, 3),
								( 28, 2, '2020-06-22', 4, 3),
								( 32, 4, '2020-06-22', 4, 3),
								( 34, 6, '2020-06-22', 4, 3),

								( 7, 1, '2020-06-27', 1, 4),
								( 8, 1, '2020-06-27', 1, 4),
								( 12, 1, '2020-06-27', 2, 4),
								( 13, 1, '2020-06-27', 2, 4),
								( 14, 1, '2020-06-27', 2, 4),
								( 15, 1, '2020-06-27', 2, 4),
								( 17, 1, '2020-06-27', 2, 4),
								( 23, 1, '2020-06-27', 3, 4),
								( 27, 4, '2020-06-27', 3, 4),

								( 3, 1, '2020-06-30', 1, 5),
								( 10, 1, '2020-06-30', 2, 5),
								( 23, 1, '2020-06-30', 3, 5),
								( 26, 2, '2020-06-30', 3, 5),
								
								( 11, 1, '2020-07-02', 2, 6),
								( 18, 2, '2020-07-02', 2, 6),
								( 21, 2, '2020-07-02', 3, 6),
								( 31, 1, '2020-07-02', 4, 6),
								
								( 2, 10, '2020-07-05', 1, 7),
								( 5, 10, '2020-07-05', 1, 7),
								( 8, 10, '2020-07-05', 1, 7),
								( 11, 10, '2020-07-05', 2, 7),
								( 15, 10, '2020-07-05', 2, 7),
								( 16, 10, '2020-07-05', 2, 7),
								( 19, 4, '2020-07-05', 3, 7),
								( 30, 1, '2020-07-05', 4, 7),
								( 36, 1, '2020-07-05', 4, 7);
								
go

/*Задание 1. 
Для базы данных «Спортивный магазин» из практического задания модуля «Триггеры, хранимые процедуры и пользовательские функции» 
создайте следующие пользовательские функции: 
1. Пользовательская функция возвращает количество уникальных покупателей 
2. Пользовательская функция возвращает среднюю цену товара конкретного вида. Вид товара передаётся в качестве параметра. 
Например, среднюю цену обуви 
3. Пользовательская функция возвращает среднюю цену продажи по каждой дате, когда осуществлялись продажи 
4. Пользовательская функция возвращает информацию о последнем проданном товаре. Критерий определения последнего проданного товара: дата продажи 
5. Пользовательская функция возвращает информацию о первом проданном товаре. Критерий определения первого проданного товара: дата продажи
6. Пользовательская функция возвращает информацию о заданном виде товаров конкретного производителя. Вид товара и название производителя 
передаются в качестве параметров 
7. Пользовательская функция возвращает информацию о покупателях, которым в этом году исполнится 45 лет */


--1. Пользовательская функция возвращает количество уникальных покупателей 

create function numberUniqueBuyers()
returns int
as
begin
declare @NumberBuyers int
set @NumberBuyers = (select count(Id) from Clients)				--используется count(Id), т.к. клиенты не повторяются
return @NumberBuyers
end;
go

--проверка

select dbo.numberUniqueBuyers() as 'Количество уникальных покупателей';
go


--2. Пользовательская функция возвращает среднюю цену товара конкретного вида. Вид товара передаётся в качестве параметра. 
--Например, среднюю цену обуви 

create function getAveragePriceOfProducts(@TypeProducts nvarchar(20))
returns money
as
begin
declare @AveragePrice money
set @AveragePrice = (select avg(Price) 
					 from Products join TypeProduct on TypeProduct.Id=Products.TypeProductId
					 group by TypeProduct.Name
					 having TypeProduct.Name=@TypeProducts)
return @AveragePrice
end;
go


--проверка

select dbo.getAveragePriceOfProducts('куртки') as 'Средняя цена товаров данного вида';
go


--3. Пользовательская функция возвращает среднюю цену продажи по каждой дате, когда осуществлялись продажи 

create function getAvaregePriceOnDate()
returns table
as
return (select Sales.DateSales as [Дата], avg(Sales.Number*Products.Price) as [Средняя цена продажи]
		from Products join Sales on Products.Id=Sales.ProductsId
		group by Sales.DateSales);
go

--проверка

select * from getAvaregePriceOnDate();
go


--4. Пользовательская функция возвращает информацию о последнем проданном товаре. Критерий определения последнего проданного товара: дата продажи 

create function infoAboutLastSalesProducts()
returns table
as
return (select Sales.DateSales as [Дата последней продажи], Products.Name as [Последние проданные товары]
		from Products join Sales on Products.Id=Sales.ProductsId
		where Sales.DateSales >= all(select distinct DateSales from Sales)
);
go

--проверка

select * from infoAboutLastSalesProducts();
go


--5. Пользовательская функция возвращает информацию о первом проданном товаре. Критерий определения первого проданного товара: дата продажи

create function infoAboutFirstSalesProducts()
returns table
as
return (select Sales.DateSales as [Дата первой продажи], Products.Name as [Первые проданные товары]
		from Products join Sales on Products.Id=Sales.ProductsId
		where Sales.DateSales <= all(select distinct DateSales from Sales)
);
go

--проверка

select * from infoAboutFirstSalesProducts();
go


--6. Пользовательская функция возвращает информацию о заданном виде товаров конкретного производителя. Вид товара и название производителя 
--передаются в качестве параметров 

create function infoAboutProductsOneManufacturers(@TypeProducts nvarchar(20), @NameManufacturer nvarchar(50))
returns table
as
return (select top(100) Products.Name as [Название товара], TypeProduct.Name as [Вид товара], Products.Price as [Цена товара], Manufacturer.Name as [Производитель]
		from Products join Sales on Products.Id=Sales.ProductsId
							   join Manufacturer on Manufacturer.Id=Products.ManufacturerId
							   join TypeProduct on TypeProduct.Id=Products.TypeProductId
		where TypeProduct.Name = @TypeProducts and Manufacturer.Name = @NameManufacturer
		order by Products.Name);
go


--проверка

select * from infoAboutProductsOneManufacturers('тренажеры', 'Спорттехника');
go


--7. Пользовательская функция возвращает информацию о покупателях, которым в этом году исполнится 45 лет 

create function infoAboutBuyersWhoWill45(@Age int)
returns @infoAboutBuyersTable table
		(Name nvarchar(50), Surname nvarchar(50), BirthDate date) --Email nvarchar(100), Fone nvarchar(20), Gender nvarchar(10), BirthDate date)
as
begin
insert @infoAboutBuyersTable
select Clients.Name as [Имя], Clients.Surname as [Фамилия], Clients.BirthDate as [Дата рождения]     
		from Clients
		where (year(Clients.BirthDate) = year(getdate()) - @Age and month(Clients.BirthDate) = month(getdate()) and day(Clients.BirthDate) > day(getdate())) or
			  (year(Clients.BirthDate) = year(getdate()) - @Age and month(Clients.BirthDate) > month(getdate()))
return 
end;
go


--проверка

select * from infoAboutBuyersWhoWill45(45);
go

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

create database MusicCollection_HW_4;
go

use MusicCollection_HW_4;
go

create table Styles
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) check(Name<>'') not null,
);
go
create table Artists
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) check(Name<>'') not null,
Surname nvarchar(50) check(Surname<>'') not null,
);
go
create table Countries
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
);
go
create table Publishers
(
Id int identity(1,1) not null primary key,
Name nvarchar(100) check(Name<>'') not null,
CountriesId int not null references Countries(Id),
);
go
create table Discs
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) check(Name<>'') not null,
ReleaseDate date not null,
DurationDisc time check(DurationDisc>'0:0:0') not null,
NumberSongs int not null,
StylesId int not null references Styles(Id),
ArtistsId int not null references Artists(Id),
PublishersId int not null references Publishers(Id),
);
go
create table Songs
(
Id int identity(1,1) not null primary key,
Name nvarchar(MAX) check(Name<>'') not null,
Duration time check(Duration>'0:0:0') not null,
DisksId int not null references Discs(Id) on delete cascade,
StylesId int not null references Styles(Id),
ArtistsId int not null references Artists(Id),
);
go

--Наполним ее данными

insert into Countries(Name) values ('США'), 
								   ('Украина'),
								   ('Великобритания');
go
insert into Publishers(Name, CountriesId) values 
								   ('Epic Records', 1), 
								   ('Первое музыкальное издательство', 2), 
								   ('Lavina Music', 2),
								   ('Susy Records', 2),
								   ('Columbia', 3);
go
insert into Styles (Name) values   ('R&B'),
								   ('ритм-н-блюз'),
								   ('нью диско'),
								   ('инди поп'),
								   ('арт рок'),
								   ('соул'),
								   ('Dark Power Pop');
go
insert into Artists (Name, Surname) values 
								   ('Майкл', 'Джексон'),
								   ('Дмитрий', 'Монатик'),
								   ('Святослав', 'Вакарчук'),
								   ('Адель', 'Эдкинс');
go
insert into Discs (Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId) values
								   ('Invincible', '2001-10-30', '01:17:10', 16, 1, 1, 1),
								   ('Dangerous', '1991-11-26', '01:13:12', 14, 2, 1, 1),
								   ('Thriller', '1982-11-08', '00:42:19', 9, 2, 1, 1),
								   ('Love it ритм', '2019-05-17', '01:01:06', 20, 3, 2, 2),
								   ('Звучит', '2016-05-25', '00:44:03', 16, 4, 2, 2),
								   ('Без меж', '2016-05-19', '00:51:25', 11, 5, 3, 3),
								   ('Без меж', '2019-11-28', '00:43:17', 7, 6, 2, 4),
								   ('Земля', '2013-05-13', '00:48:53', 12, 4, 3, 4),
								   ('21', '2011-01-24', '00:48:12', 11, 6, 4, 5),
								   ('Mong', '2014-05-13', '00:41:43', 11, 6, 4, 5);
go
insert into Songs (Name, Duration, DisksId, StylesId, ArtistsId) values
								   ('Unbreakable', '00:06:26', 1, 1, 1),
								   ('Remember the time', '00:04:00', 2, 2, 1),
								   ('Billie Jean', '00:10:37', 3, 2, 1),
								   ('Глубоко...', '00:04:12', 4, 3, 2),
								   ('Кружит', '00:03:18', 5, 4, 2),
								   ('Віддай мені свою любов', '00:04:04', 6, 5, 3),
								   ('Сідай коло мене - співай', '00:05:12', 7, 6, 2),
								   ('Обійми', '00:03:44', 8, 4, 3),
								   ('Rolling in the Deep', '00:03:46', 9, 6, 4),
								   ('Kontra bas', '00:03:41', 9, 6, 4);
go

/*Задание 2. 
Для базы данных «Музыкальная коллекция» из практического задания модуля «Работа с таблицами и представлениями в MS SQL Server» 
создайте следующие пользовательские функции: 
1. Пользовательская функция возвращает все диски заданного года. Год передаётся в качестве параметра 
2. Пользовательская функция возвращает информацию о дисках с одинаковым названием альбома, но разными исполнителями 
3. Пользовательская функция возвращает информацию о всех песнях, в чьем названии встречается заданное слово. Слово передаётся в качестве параметра 
4. Пользовательская функция возвращает количество альбомов в стилях ритм-н-блюз и соул  
5. Пользовательская функция возвращает информацию о средней длительности песни заданного исполнителя. Название исполнителя передаётся в качестве параметра 
6. Пользовательская функция возвращает информацию о самой долгой и самой короткой песне 
7. Пользовательская функция возвращает информацию об исполнителях, которые создали альбомы в двух и более стилях.*/


--1. Пользовательская функция возвращает все диски заданного года. Год передаётся в качестве параметра 

create function getDiscsOfYear(@YearDiscs int)
returns table
as 
return (select Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Название альбома/диска], Discs.ReleaseDate as [Дата выпуска], 
Discs.NumberSongs as [Количество песен], Discs.DurationDisc as [Продолжительность диска], Publishers.Name as [Издательство]
		from Discs join Artists on Artists.Id=Discs.ArtistsId
				   join Publishers on Publishers.Id=Discs.PublishersId
		where year(Discs.ReleaseDate) = @YearDiscs);
go

--проверка

select * from getDiscsOfYear(2016);
go


--2. Пользовательская функция возвращает информацию о дисках с одинаковым названием альбома, но разными исполнителями 

create function infoAboutDiscsSameTitlesDifferentArtists()
returns table
as
return (select Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Название альбома/диска], Discs.ReleaseDate as [Дата выпуска], 
Discs.NumberSongs as [Количество песен], Discs.DurationDisc as [Продолжительность диска], Publishers.Name as [Издательство]
		from Discs join Artists on Artists.Id=Discs.ArtistsId
				   join Publishers on Publishers.Id=Discs.PublishersId
		where Discs.Name in (select Name 
							 from Discs
							 group by Name
							 having count(Name) > 1));
go

--проверка

select * from infoAboutDiscsSameTitlesDifferentArtists();
go


--3. Пользовательская функция возвращает информацию о всех песнях, в чьем названии встречается заданное слово. Слово передаётся в качестве параметра 

create function infoAboutSongsWithWord (@Word nvarchar(20))
returns table
as
return (select Songs.Name as [Название песни], Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Название альбома/диска], 
Songs.Duration as [Продолжительность трека], Styles.Name as [Стиль исполнения]
		from Discs join Artists on Artists.Id=Discs.ArtistsId
				   join Publishers on Publishers.Id=Discs.PublishersId
				   join Songs on Discs.Id=Songs.DisksId
				   join Styles on Styles.Id=Songs.StylesId
		where Songs.Name like convert(nvarchar(1), '%') + @Word + convert(nvarchar(1), '%'));
go

--проверка

select * from infoAboutSongsWithWord('ко');
go


--4. Пользовательская функция возвращает количество альбомов в стилях ритм-н-блюз и соул  

create function numberDiscsInStylesRnbAndSoul()
returns  int
as
begin
declare @NumberDiscs int
set @NumberDiscs = (select count(Discs.Id) 
					from Discs join Styles on Styles.Id=Discs.StylesId
					where Styles.Name in ('ритм-н-блюз', 'соул'))
return @NumberDiscs
end;
go

--проверка

select dbo.numberDiscsInStylesRnbAndSoul() as [Количество альбомов в стилях ритм-н-блюз и соул];
go


--5. Пользовательская функция возвращает информацию о средней длительности песни заданного исполнителя. Название исполнителя передаётся в качестве параметра 

create function infoAboutAvgDurationSongs(@NameArtists nvarchar(20), @SurnameArtists nvarchar(20))
returns time
as
begin
declare @AvgDurationSongs time
--сначала преобразование во float, поиск среднего значения, затем преобразование назад в time
set @AvgDurationSongs = (select cast(cast(avg(cast(cast(Songs.Duration as datetime) as float)) as datetime) as time(1))   
						 from Songs join Artists on Artists.Id=Songs.ArtistsId
						 where Artists.Name=@NameArtists and Artists.Surname=@SurnameArtists)
return @AvgDurationSongs
end;
go

--проверка

select dbo.infoAboutAvgDurationSongs('Майкл', 'Джексон') as [Средняя длительность песни исполнителя];
go


--6. Пользовательская функция возвращает информацию о самой долгой и самой короткой песне 

create function infoAboutLongestAndShortestSongs()
returns table
as
return (select Songs.Name as [Название песни], Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Название альбома/диска], 
Songs.Duration as [Продолжительность трека], Styles.Name as [Стиль исполнения]
		from Discs join Artists on Artists.Id=Discs.ArtistsId
				   join Publishers on Publishers.Id=Discs.PublishersId
				   join Songs on Discs.Id=Songs.DisksId
				   join Styles on Styles.Id=Songs.StylesId
		where Songs.Duration = (select max(Duration) from Songs) or Songs.Duration = (select min(Duration) from Songs));
go

--проверка

select * from infoAboutLongestAndShortestSongs();
go


--7. Пользовательская функция возвращает информацию об исполнителях, которые создали альбомы в двух и более стилях.

create function infoAboutArtisrsWithMultyStyles()
returns table
as
return (select Songs.Name as [Название песни], Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Название альбома/диска], 
Songs.Duration as [Продолжительность трека], Styles.Name as [Стиль исполнения]
		from Discs join Artists on Artists.Id=Discs.ArtistsId
				   join Publishers on Publishers.Id=Discs.PublishersId
				   join Songs on Discs.Id=Songs.DisksId
				   join Styles on Styles.Id=Songs.StylesId
		where Artists.Surname in (select Artists.Surname 
								  from Artists join Discs on Artists.Id=Discs.ArtistsId
								  group by Artists.Surname
								  having count(distinct Discs.StylesId)>1));
go

--проверка

select * from infoAboutArtisrsWithMultyStyles();
go
