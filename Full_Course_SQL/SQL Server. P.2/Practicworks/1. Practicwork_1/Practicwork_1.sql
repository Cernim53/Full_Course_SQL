/*Задание 1. Создайте базу данных «Телефонный справочник». Эта база данных должна содержать одну таблицу «Люди». 
В таблице нужно хранить: ФИО человека, дату рождения, пол, телефон, город проживания, страна проживания, домашний адрес. 
Для создания базы данных используйте запрос CREATE DATABASE. Для создания таблицы используйте запрос CREATE TABLE. */


-- Создание базы данных Phonebook_PZ_1

create database Phonebook_PZ_1
go

-- Создание таблицы People со столбцами Id, Name, Surname, BirthDate, Gender, Fone, City, Country и Adress

create table People
(
Id int identity(1,1) not null,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
BirthDate date not null,
Gender nvarchar(10) not null,
Fone nvarchar(20) null,
City nvarchar(50) not null,
Country nvarchar(50) not null,
Adress nvarchar(MAX) not null,
);
go

--Создание первичного ключа для столбца Id

alter table People 
add constraint pkTable_1 primary key (Id)
go

create table People
--Можно было сразу создать первичный ключ, при создании таблицы People.
-- Тогда первая строка должна была бы быть такой:
-- Id int identity(1,1) not null primary key,


/*Задание 2. Создайте базу данных «Продажи». База данных должна содержать информацию о продавцах, покупателях, продажах. 
Необходимо хранить следующую информацию: 
1. О продавцах: ФИО, email, контактный телефон 
2. О покупателях: ФИО, email, контактный телефон 
3. О продажах: покупатель, продавец, название товара, цена продажи, дата сделки. 
Для создания базы данных используйте запрос CREATE DATABASE. 
Для создания таблицы используйте запрос CREATE TABLE. Обязательно при создании таблиц задавать связи между ними.*/

--Создание базы данных Sales_PZ_1

create database Sales_PZ_1;
go

--Создание таблиц Sellers, Buyers, Product_sales с соответствующими столбцами и значениями, ключами, а также 
--с соответсвующими отношениями между таблицами

create table Sellers
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Mail nvarchar(100) null,
Fone nvarchar(20) null,
);
go

create table Buyers
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Mail nvarchar(100) null,
Fone nvarchar(20) null,
);
go

create table ProductSales
(
Id int identity(1,1) not null primary key,
SellersId int not null references Sellers(Id),
BuyersId int not null references Buyers(Id),
Name nvarchar(MAX) not null,
Price money check(Price>0) not null,
DataSales date not null,
);
go

--проверка: вывести данные из таблиц

select Sellers.Name+' '+Sellers.Surname as [Продавец], Buyers.Name+' '+Buyers.Surname as [Покупатель], 
ProductSales.Name as [Товар], ProductSales.Price as [Цена продажи], ProductSales.DataSales as [Дата продажи]
from Sellers join ProductSales on Sellers.Id=ProductSales.SellersId
			 join Buyers on Buyers.Id=ProductSales.BuyersId
order by ProductSales.DataSales;




/*Задание 3. Создайте базу данных «Музыкальная коллекция». База данных должна содержать информацию о музыкальных дисках, исполнителях, стилях. 
Необходимо хранить следующую информацию: 
1. О музыкальном диске: название диска, исполнитель, дата выпуска, стиль, издатель 
2. О стилях: названия стилей 
3. Об исполнителях: название 
4. Об издателях: название, страна 
5. О песнях: название песни, название диска, длительность песни, музыкальный стиль песни, исполнитель. 
Продумайте правильную структуру базы данных. Для создания базы данных используйте запрос CREATE DATABASE. 
Для создания таблицы используйте запрос CREATE TABLE. Обязательно при создании таблиц задавать связи между ними. */

--Создание базы данных MusicCollection_PZ_1

create database MusicCollection_PZ_1
go

--Создание таблиц Discs, Styles, Artists, Publishers, Countries, Songs с соответствующими столбцами и значениями, ключами, а также 
--с соответсвующими отношениями между таблицами

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
StylesId int not null references Styles(Id),
ArtistsId int not null references Artists(Id),
PublishersId int not null references Publishers(Id),
);
go

create table Songs
(
Id int identity(1,1) not null primary key,
Name nvarchar(MAX) check(Name<>'') not null,
Duration time check(Duration>'0:0') not null,
DisksId int not null references Discs(Id),
StylesId int not null references Styles(Id),
ArtistsId int not null references Artists(Id),
);
go


/*Задание 4. Все задания необходимо выполнить по отношению к базе данных из третьего задания: 
1. Добавьте к уже существующей таблице с информацией о музыкальном диске столбец с краткой рецензией на него 
2. Добавьте к уже существующей таблице с информацией об издателе столбец с юридическим адресом главного офиса 
3. Измените в уже существующей таблице с информацией о песнях размер поля, хранящий название песни 
4. Удалите из уже существующей таблицы с информацией об издателе столбец с юридическим адресом главного офиса
5. Удалите связь между таблицами «музыкальных дисков» и «исполнителей» 
6. Добавьте связь между таблицами «музыкальных дисков» и «исполнителей». */

--1
Alter table Discs
add Review nvarchar(MAX) null;
go

--2
Alter table Publishers
add LegalAddress nvarchar(MAX) null;
go

--3
--Т.к. в поле Name установлено ограничение (Name<>''), которое блокирует изменение поля Name, 
--необходимо сначала снять ограничение, а затем изменить само поле

Alter table Songs
drop CK__Songs__Name__74794A92;
go

--теперь меняем значение поля Name nvarchar(MAX) на Name nvarchar(100)
Alter table Songs 
alter column Name nvarchar(100) not null;
go

--и возвращаем проверочное ограничение (Name<>'')
Alter table Songs
add constraint SK_Songs_Name_not_empty check(Name<>'');
go

--4
Alter table Publishers
drop column LegalAddress;
go

--5
Alter table Discs
drop constraint FK__Discs__ArtistsId__70A8B9AE;
go

--6
Alter table Discs
add foreign key (ArtistsId) references Artists(Id);
go

--проверка: вывести данные из таблиц
use MusicCollection_PZ_1
go

insert into Countries(Name) values ('США'), 
								   ('Украина');
go
insert into Publishers(Name, CountriesId) values 
								   ('Epic Records', 1), 
								   ('Первое музыкальное издательство', 2), 
								   ('Студія 211', 2);
go
insert into Styles (Name) values   ('R&B'),
								   ('ритм-н-блюз'),
								   ('нью диско'),
								   ('инди поп'),
								   ('арт рок');
go
insert into Artists (Name, Surname) values 
								   ('Майкл', 'Джексон'),
								   ('Дмитрий', 'Монатик'),
								   ('Святослав', 'Вакарчук');
go
insert into Discs (Name, ReleaseDate, StylesId, ArtistsId, PublishersId) values
								   ('Invincible', '2001-10-30', 1, 1, 1),
								   ('Dangerous', '1991-11-26', 2, 1, 1),
								   ('Love it ритм', '2019-05-17', 3, 2, 2),
								   ('Звучит', '2016-05-25', 4, 2, 2),
								   ('Без мене', '2016-05-19', 5, 3, 3);
go
insert into Songs (Name, Duration, DisksId, StylesId, ArtistsId) values
								   ('Unbreakable', '06:26', 1, 1, 1),
								   ('Remember the time', '04:00', 2, 2, 1),
								   ('Глубоко...', '04:12', 3, 3, 2),
								   ('Кружит', '03:18', 4, 4, 2),
								   ('Віддай мені свою любов', '04:04', 5, 5, 3);
go

--запрос на выведение записей
select Artists.Name+' '+Artists.Surname as [Исполнитель], Songs.Name as [Песня], Discs.Name as [Альбом], Songs.Duration as [Продолжительность],
Styles.Name as [Стиль исполнения], Publishers.Name as [Издатель], Countries.Name as [Страна]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Songs on Discs.Id=Songs.DisksId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
go

/*Задание 5. Создайте следующие представления. В качестве базы данных используйте базу данных из третьего задания: 
1. Представление отображает названия всех стилей 
2. Представление отображает названия всех издателей 
3. Представление отображает полную информацию о диске: название диска, исполнитель, дата выпуска, стиль, издатель.*/

--1
create view StylesName as 
select Styles.Name as [Названия стилей]
from Styles;
go

select * 
from StylesName;
go

--2
create view "Название всех издателей" as
select Publishers.Name as [Название издателей]
from Publishers;
go

select *
from "Название всех издателей";
go

--3
create view "Полная информация о диске" as
select Discs.Name as [Название диска / альбома], Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.ReleaseDate as [Дата выпуска],
Styles.Name as [Стиль исполнения], Publishers.Name as [Издатель]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId;
go

select *
from "Полная информация о диске";
go