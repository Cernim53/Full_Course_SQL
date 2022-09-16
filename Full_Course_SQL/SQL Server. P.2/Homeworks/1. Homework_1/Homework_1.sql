--Предварительная работа
--Создадим базу данных MusicCollection_HW_1 с таблицами Styles, Artists, Countries, Publishers, Discs, Songs, 

create database MusicCollection_HW_1;
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
DisksId int not null references Discs(Id),
StylesId int not null references Styles(Id),
ArtistsId int not null references Artists(Id),
);
go

--Наполним базу данных значениями

use MusicCollection_HW_1
go

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
								   ('соул');
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
								   ('Земля', '2013-05-13', '00:48:53', 12, 4, 3, 4),
								   ('21', '2011-01-24', '00:48:12', 11, 6, 4, 5);
go
insert into Songs (Name, Duration, DisksId, StylesId, ArtistsId) values
								   ('Unbreakable', '00:06:26', 1, 1, 1),
								   ('Remember the time', '00:04:00', 2, 2, 1),
								   ('Billie Jean', '00:10:37', 3, 2, 1),
								   ('Глубоко...', '00:04:12', 4, 3, 2),
								   ('Кружит', '00:03:18', 5, 4, 2),
								   ('Віддай мені свою любов', '00:04:04', 6, 5, 3),
								   ('Обійми', '00:03:44', 7, 4, 3),
								   ('Rolling in the Deep', '00:03:46', 8, 6, 4);
go


/*Задание 1. Все задания необходимо выполнить по отношению к базе данных «Музыкальная коллекция», описанной 
в практическом задании для этого модуля. Создайте следующие представления: 
1. Представление отображает названия всех исполнителей 
2. Представление отображает полную информацию о всех песнях: название песни, название диска, 
длительность песни, музыкальный стиль песни, исполнитель 
3. Представление отображает информацию о музыкальных дисках конкретной группы. Например, The Beatles 
4. Представление отображает название самого популярного в коллекции исполнителя. Популярность определяется по количеству дисков в коллекции 
5. Представление отображает топ-3 самых популярных в коллекции исполнителей. Популярность определяется по количеству дисков в коллекции 
6. Представление отображает самый долгий по длительности музыкальный альбом.*/

--1
create view "Перечень всех исполнителей" as
select Artists.Name+' '+Artists.Surname as [Исполнители]
from Artists;
go

select * from "Перечень всех исполнителей";
go

--2
create view "Информация о всех песнях" as
select Songs.Name as [Название песни], Discs.Name as [Название альбома/диска], Songs.Duration as [Длительность песни], 
Styles.Name as [Музыкальный стиль], Artists.Name+' '+Artists.Surname as [Исполнитель]
from Songs  join Discs on Discs.Id=Songs.DisksId
			join Styles on Styles.Id=Discs.StylesId and Styles.Id=Songs.StylesId
			join Artists on Artists.Id=Discs.ArtistsId and Artists.Id=Songs.ArtistsId;
go

select * from "Информация о всех песнях";
go

--3
create view "Информация о дисках М.Джексона" as
select Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Диски/альбомы], Discs.ReleaseDate as [Дата выпуска], Publishers.Name as [Издатель]
from Discs  join Publishers on Publishers.Id=Discs.PublishersId
			join Artists on Artists.Id=Discs.ArtistsId
where Artists.Name = 'Майкл' and Artists.Surname = 'Джексон';
go

select * from "Информация о дисках М.Джексона";
go

--4
create view "Самый популярный исполнитель в коллекции" as
select Artists.Name+' '+Artists.Surname as [Исполнитель], count(Discs.ArtistsId) as [Количество дисков]
from Artists join Discs on Artists.Id=Discs.ArtistsId
group by Artists.Surname, Artists.Name, Discs.ArtistsId
having count(Discs.ArtistsId) >= all (select count(Discs.ArtistsId) 
									  from Artists join Discs on Artists.Id=Discs.ArtistsId
									  group by Artists.Surname, Artists.Name, Discs.ArtistsId);
go

select * from "Самый популярный исполнитель в коллекции";
go

--5
create view "TOP-3 самых популярных исполнителей" as
select Top(3) Artists.Name+' '+Artists.Surname as [Исполнитель], count(Discs.ArtistsId) as [Количество дисков]
from Artists join Discs on Artists.Id=Discs.ArtistsId
group by Artists.Surname, Artists.Name, Discs.ArtistsId;
go

select * from "TOP-3 самых популярных исполнителей";
go

--6
create view "Самый длинный диск" as
select Artists.Name+' '+Artists.Surname as [Исполнитель], Discs.Name as [Название альбома/диска], Discs.DurationDisc as [Продолжительность альбома/диска]
from Artists join Discs on Artists.Id=Discs.ArtistsId
where Discs.DurationDisc >= all(select Discs.DurationDisc from Discs);
go

select * from "Самый длинный диск";
go


/*Задание 2. Все задания необходимо выполнить по отношению к базе данных «Музыкальная коллекция», описанной 
в практическом задании для этого модуля: 
1. Создайте обновляемое представление, которое позволит вставлять новые стили 
2. Создайте обновляемое представление, которое позволит вставлять новые песни 
3. Создайте обновляемое представление, которое позволит обновлять информацию об издателе 
4. Создайте обновляемое представление, которое позволит удалять исполнителей 
5. Создайте обновляемое представление, которое позволит обновлять информацию о конкретном исполнителе. 
Например, Muse. */

--1
create view "Добавление новых стилей" as
select Styles.Name
from Styles;
go

insert into "Добавление новых стилей"(Name)
values ('альтернативный рок');
go

--2
create view "Добавление новой песни" as
select Songs.Name, Songs.Duration, Songs.DisksId, Songs.StylesId, Songs.ArtistsId
from Songs
go

insert into "Добавление новой песни"(Name, Duration, DisksId, StylesId, ArtistsId)
values ('На небі', '00:03:41', 7, 5, 3);
go

--3
-- Добавим к названию издателя слово "Records", если в названии издателя присутствует слово "music" и не присутствует слово "records"
create view "Обновление информации об издателе" as
select Publishers.Name
from Publishers;
go

update "Обновление информации об издателе"
set Name += ' Records' where Name like '%music%' and Name not like '%records%';
go

--4
create view "Удаление исполнителей" as
select Artists.Name, Artists.Surname
from Artists;
go

delete from "Удаление исполнителей"
where Name='Майкл' and Surname='Джексон';
go

--Удаление не произошло, потому что:
--Это представление будет работать, если нет ограничения по внешнему ключу на данные из другой таблицы
--Если такое ограничение есть, то его сначала нужно удалить, затем удалить нужную строку(строки), затем опять 
--восстановить ограничение по внешнему ключу
--удалим два ограничения по внешнему ключу для данных с таблицы Artists, т.е. по ArtistsId

Alter table Songs
drop FK__Songs__ArtistsId__02C769E9;
go
Alter table Discs
drop FK__Discs__ArtistsId__7B264821;
go

--теперь удаление прошло успешно
delete from "Удаление исполнителей"
where Name='Майкл' and Surname='Джексон';
go

--проверочный запрос
select *
from Artists;
go

--восстановим ограничения по внешним ключам ArtistsId для таблиц Songs и Discs с таблицей Artists(Id)
alter table Songs
add foreign key (ArtistsId) references Artists(Id);
go
alter table Discs
add foreign key (ArtistsId) references Artists(Id);
go


--5
--Добавим статус/состояние для исполнителя Дмитрий Монатик
--для этого добавим в таблицу Artists столбец Status

Alter table Artists
add Status nvarchar(MAX) default('unknown');
go

--теперь добавим запись о статусе Дмитрия Монатика
create view "Обновление информации об исполнителе" as
select Artists.Name, Artists.Surname, Artists.Status
from Artists;
go

update "Обновление информации об исполнителе"
set Status = 'Дмитрий Монатик записывает очередной, четвертый по счету альбом. Дмитрий планирует включить в альбом 15 песен о любви'
where Name='Дмитрий' and Surname='Монатик';
go


/*Задание 3. Все задания необходимо выполнить по отношению к базе данных «Продажи», описанной в практическом задании для этого модуля: 
1. Создайте обновляемое представление, которое отображает информацию о всех продавцах 
2. Создайте обновляемое представление, которое отображает информацию о всех покупателях 
3. Создайте обновляемое представление, которое отображает информацию о всех продажах конкретного товара. Например, автомобилей и домов 
4. Создайте представление, отображающее все осуществленные сделки
5. Создайте представление, отображающее информацию о самом активном продавце. Определяем самого активного продавца 
по максимальной общей сумме продаж 
6. Создайте представление, отображающее информацию о самом активном покупателе. Определяем самого активного покупателя 
по максимальной общей сумме покупок. 
Используйте опции CHECK OPTION, SCHEMABINDING, ENCRYPTION там, где это необходимо или полезно.*/

use Sales_PZ_1
go

--1
create view "Информация о всех продавцах"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [ФИО продавцов], Buyers.Fone as [Телефон], Buyers.Mail as [EMAIL]
from Buyers;
go

select * from "Информация о всех продавцах";
go

--2
create view "Информация о всех покупателях"
with encryption as
select Sellers.Name+' '+Sellers.Surname as [ФИО покупателей], Sellers.Fone as [Телефон], Sellers.Mail as [EMAIL]
from Sellers;
go

select * from "Информация о всех покупателях";
go

--3
create view "Информация о продажах автомобилей и домов"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [ФИО продавцов], Sellers.Name+' '+Sellers.Surname as [ФИО покупателей], 
ProductSales.Name as [Проданный товар], ProductSales.Price as [Цена], ProductSales.DataSales as [дата продажи]
from Buyers join ProductSales on Buyers.Id=ProductSales.BuyersId
			join Sellers on Sellers.Id=ProductSales.SellersId
where ProductSales.Name like '%автомобиль%' or ProductSales.Name like '%дом%';
go

select * from "Информация о продажах автомобилей и домов";
go

--4
create view "Информация о всех сделках"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [ФИО продавцов], Sellers.Name+' '+Sellers.Surname as [ФИО покупателей], 
ProductSales.Name as [Проданный товар], ProductSales.Price as [Цена], ProductSales.DataSales as [дата продажи]
from Buyers join ProductSales on Buyers.Id=ProductSales.BuyersId
			join Sellers on Sellers.Id=ProductSales.SellersId;
go

select * from "Информация о всех сделках";
go

--5
create view "Информация о самом активном продавце"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [ФИО продавцов], sum(ProductSales.Price) as [Сумма продаж]
from Buyers join ProductSales on Buyers.Id=ProductSales.BuyersId
group by Buyers.Surname, Buyers.Name
having sum(ProductSales.Price) >= all(select sum(ProductSales.Price) 
									  from ProductSales, Buyers 
									  where Buyers.Id=ProductSales.BuyersId
									  group by Buyers.Surname, Buyers.Name)
with check option;
go

select * from "Информация о самом активном продавце";
go

--6
create view "Информация о самом активном покупателе"
with encryption as
select Sellers.Name+' '+Sellers.Surname as [ФИО покупателей], sum(ProductSales.Price) as [Сумма покупок]
from Sellers join ProductSales on Sellers.Id=ProductSales.SellersId
group by Sellers.Surname, Sellers.Name
having sum(ProductSales.Price) >= all(select sum(ProductSales.Price) 
									  from ProductSales, Sellers 
									  where Sellers.Id=ProductSales.SellersId
									  group by Sellers.Surname, Sellers.Name)
with check option;
go

select * from "Информация о самом активном покупателе";
go