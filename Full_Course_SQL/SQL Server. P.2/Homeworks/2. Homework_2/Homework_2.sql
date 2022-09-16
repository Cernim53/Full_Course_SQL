--Создадим таблицы

use SportShop_HW_2;
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

--Наполним таблицы данными

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
insert into Clients(Name, Surname, GenderId, Discount, MailingList) values
								('Семен', 'Степанов', 1, 12.5, 0),
								('Алена', 'Михайлова', 2, 7.5, 0),
								('Влад', 'Ярославский', 1, 15, 1),
								('Юлия', 'Венедиктова', 2, 10.5, 0),
								('Ольга', 'Чепурнова', 2, 5, 0),
								('Анатолий', 'Бобров', 1, 10, 0),
								('Ярослав', 'Коновалов', 1, 15, 1);
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
К базе данных «Спортивный магазин» из практического задания к этому модулю создайте следующие триггеры: 
1. При добавлении нового товара триггер проверяет его наличие на складе, если такой товар есть 
и новые данные о товаре совпадают с уже существующими данными, вместо добавления происходит 
обновление информации о количестве товара 
2. При увольнении сотрудника триггер переносит информацию об уволенном сотруднике в таблицу «Архив сотрудников» 
3. Триггер запрещает добавлять нового продавца, если количество существующих продавцов больше 6. */



--1. При добавлении нового товара триггер проверяет его наличие на складе, если такой товар есть и новые данные о товаре совпадают 
--с уже существующими данными, вместо добавления происходит обновление информации о количестве товара 

create trigger "Проверка при вставке продуктов. Добавление новой записи или увеличение остатков"
on Products
instead of insert
as
begin

declare @Name nvarchar(50)
declare @TypeProductId int
declare @StockNumberNew int
declare @StockNumberOld int
declare @Price money
declare @ManufacturerId int

select @Name = Name,
	   @TypeProductId = TypeProductId,
	   @StockNumberNew = StockNumber,
	   @Price = Price,
	   @ManufacturerId = ManufacturerId
from inserted

select @StockNumberOld = StockNumber
from Products
where Name = @Name and TypeProductId = @TypeProductId and Price = @Price and ManufacturerId = @ManufacturerId

if (@Name in (select Name from Products)) and
   (@TypeProductId in (select TypeProductId from Products)) and
   (@Price in (select Price from Products)) and
   (@ManufacturerId in (select ManufacturerId from Products))
begin

update Products
set StockNumber = @StockNumberOld + @StockNumberNew
where Name = @Name and TypeProductId = @TypeProductId and Price = @Price and ManufacturerId = @ManufacturerId

print'Количество товаров '+ @Name + ' на складе увеличилось со '+ convert(nvarchar(10), @StockNumberOld) + ' до ' + convert(nvarchar(10), @StockNumberOld + @StockNumberNew) + ' штук'
end
else
begin
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId)
values (@Name, @TypeProductId, @StockNumberNew, @Price, @ManufacturerId)
print'Вставлен новый товар '+ @Name + ' в количестве ' + convert(nvarchar(10), @StockNumberNew) + ' штук, по цене ' + convert(nvarchar(10), @Price) + ' гривен за штуку'
end
end;
go

--проверка
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId)
values ('Скелетон', 1, 32, 1670, 1)

select * from Products

-- и
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId)
values ('Spart', 7, 12, 530, 3)

select * from Products



--2. При увольнении сотрудника триггер переносит информацию об уволенном сотруднике в таблицу «Архив сотрудников» 

--Создадим таблицу ArchiveEmployees, в которую запишем все данные об уволенных сотрудниках + дату увольнения

create table ArchiveEmployees
(
Id int identity(1,1) primary key,
Name nvarchar(50) check (Name<>'') not null,
Surname nvarchar(50) check (Surname<>'') not null,
PositionId int not null foreign key references Position(Id),
RecruitmentDate date not null,
DismissalDate date default(getdate()) null,
GenderId int not null foreign key references Gender(Id),
Salary money check(Salary>0) not null,
);
go

--Создадим триггер

create trigger "Сохраняем информацию об уволенных сотрудниках в Архиве сотрудников"
on Employees 
instead of delete
as
begin 
declare @Name nvarchar(50), @Surname nvarchar(50), @PositionId int, @GenderId int,
@RecruitmentDate date, @Salary money

select @Name = Name, @Surname = Surname
from deleted

select @PositionId = PositionId, @RecruitmentDate = RecruitmentDate, @GenderId = GenderId, @Salary = Salary
from Employees
where Name = @Name and Surname=@Surname

--проверка, есть ли такой сотрудник
if not exists (select * from Employees where Name = @Name and Surname = @Surname)
print'Такого работника в списке нет!'
else
begin
insert into ArchiveEmployees(Name, Surname, PositionId, RecruitmentDate, DismissalDate, GenderId, Salary)
values (@Name, @Surname, @PositionId, @RecruitmentDate, default, @GenderId, @Salary)
print'Информация об уволенном сотруднике успешно сохранена в таблице ArchiveEmployees'
print'@Name = '+@Name+' @Surname = '+@Surname+' @PositionId = '+ convert(nvarchar(10), @PositionId)+' @RecruitmentDate = '
+ convert(nvarchar(10), @RecruitmentDate)+' @GenderId = '+ convert(nvarchar(10), @GenderId) + ' @Salary = '+ convert(nvarchar(10), @Salary)

delete from Employees
where Name = @Name and Surname = @Surname
print'Информация об уволенном сотруднике успешно удалена из таблицы Employees'
end
end;
go

--проверка

delete from Employees
where Name = 'Игорь' and Surname = 'Суслов'
go

select * from Employees
go
select * from ArchiveEmployees
go


--3. Триггер запрещает добавлять нового продавца, если количество существующих продавцов больше 6.

create trigger "Добавлять не больше 6 продавцов"
on Employees
instead of insert
as
begin
declare @Count int, @Name nvarchar(50), @Surname nvarchar(50), @PositionId int, @GenderId int , @Salary money
select @Count = (select count(Id) from Employees)
select @Name = Name, @Surname = Surname, @PositionId = PositionId, @GenderId = GenderId , @Salary = Salary
from inserted

if @Count > 6
print'Вы не можете добавить нового продавца. Ограничение - существующих продавцов уже больше 6'
else
begin
insert into Employees(Name, Surname, PositionId, RecruitmentDate, GenderId, Salary)
values(@Name, @Surname, @PositionId, getdate(), @GenderId, @Salary)
print'Вы добавили нового продавца'
end
end;
go

--проверка

insert into Employees(Name, Surname, PositionId, GenderId, Salary)
values('Кончита', 'Бавандита', 1, 2, 1200)
go

select * from Employees
go

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--Создадим таблицы

use MusicCollection_HW_2;
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

--Наполним таблицы данными

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
								   ('Обійми', '00:03:44', 7, 4, 3),
								   ('Rolling in the Deep', '00:03:46', 8, 6, 4),
								   ('Kontra bas', '00:03:41', 8, 6, 4);
go



/*Задание 2. 
К базе данных «Музыкальная коллекция» из практического задания модуля «Работа с таблицами и представлениями в MS SQL Server» 
создайте следующие триггеры: 
1. Триггер не позволяющий добавить уже существующий в коллекции альбом
2. Триггер не позволяющий удалять диски Майкла Джексона
3. При удалении диска триггер переносит информацию об удаленном диске в таблицу «Архив» 
4. Триггер не позволяющий добавлять в коллекцию диски музыкального стиля «Dark Power Pop». */


--1. Триггер не позволяющий добавить уже существующий в коллекции альбом

create trigger "Запрет добавлять существующий в коллекции альбом"
on Discs
instead of insert
as
begin

declare @Name nvarchar(50), @ReleaseDate date, @DurationDisc time, @NumberSongs int, @StylesId int, @ArtistsId int, @PublishersId int

select @Name = Name, @ReleaseDate = ReleaseDate, @DurationDisc = DurationDisc, @NumberSongs = NumberSongs, @StylesId = StylesId, 
@ArtistsId = ArtistsId, @PublishersId = PublishersId
from inserted

if @Name in (select Name from Discs)
print'Вставка запрещена! Такой альбом уже существует в коллекции'
else
begin
insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values (@Name, @ReleaseDate, @DurationDisc, @NumberSongs, @StylesId, @ArtistsId, @PublishersId)
print'Вставка успешно осуществлена!'
end
end;
go

--проверка

insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values ('Без меж', '2016-05-19', '00:51:25', 11, 5, 3, 3)
go

insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values ('Dont Happyend', '2014-09-19', '00:43:20', 15, 7, 3, 3)
go

select * from Discs
go

--2. Триггер не позволяющий удалять диски Майкла Джексона

create trigger "Запрет удалять диски Майкла Джексона"
on Discs
instead of delete
as
begin

declare @ArtistId int
select @ArtistId = ArtistsId
from deleted

if @ArtistId = (select Id from Artists where Name = 'Майкл' and Surname = 'Джексон')
print'Удаление запрещено! Диски Майкла Джексона удалять нельзя!'
else
begin
delete from Discs
where ArtistsId = @ArtistId 
print'Удаление успешно завершилось!'
end

end;
go

--проверка

delete from Discs
where ArtistsId = 1; 
go

select * from Discs
go

--3. При удалении диска триггер переносит информацию об удаленном диске в таблицу «Архив» 

--Создадим таблицу "Архив дисков"
create table ArchivDiscs
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) check(Name<>'') not null,
ReleaseDate date not null,
DurationDisc time check(DurationDisc>'0:0:0') not null,
NumberSongs int not null,
StylesId int not null references Styles(Id),
ArtistsId int not null references Artists(Id),
PublishersId int not null references Publishers(Id),
DeleteDate date null default(getdate()),
);
go

--удалим триггер "Запрет удалять диски Майкла Джексона"

drop trigger "Запрет удалять диски Майкла Джексона"
on database;
go

--Создадим сам триггер

create trigger "Сохранение информации об удаленных дисках в Архиве дисков"
on Discs
instead of delete
as
begin

declare @Name nvarchar(50), @ReleaseDate date, @DurationDisc time, @NumberSongs int, @StylesId int,  @ArtistsId int, @PublishersId int
select @Name = Name, @ReleaseDate = ReleaseDate, @DurationDisc = DurationDisc, @NumberSongs = NumberSongs, @StylesId = StylesId, 
@ArtistsId = ArtistsId, @PublishersId = PublishersId
from deleted
if exists (select Name from Discs where Name = @Name)
begin
insert into ArchivDiscs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId,  ArtistsId, PublishersId, DeleteDate)
values (@Name, @ReleaseDate, @DurationDisc, @NumberSongs, @StylesId,  @ArtistsId, @PublishersId, getdate())
print'Информация об удаленном альбоме сохранена в таблице ArchivDiscs'
delete from Discs
where Name = @Name; 
print'Альбом успешно удален'
end
else
print'Задайте название альбома на удаление'
end;
go


--проверка

delete from Discs
where Name = 'Dangerous'; 
go

select * from Discs;
go

select * from ArchivDiscs;
go


--4. Триггер не позволяющий добавлять в коллекцию диски музыкального стиля «Dark Power Pop». 

--Удалим триггер "Запрет добавлять существующий в коллекции альбом"
drop trigger "Запрет добавлять существующий в коллекции альбом"
on database;
go

--создадим новый триггер

create trigger "Запрет добавлять в коллекцию альбомы музыкального стиля Dark Power Pop"
on Discs
instead of insert
as
begin

declare @Name nvarchar(50), @ReleaseDate date, @DurationDisc time, @NumberSongs int, @StylesId int, @ArtistsId int, @PublishersId int

select @Name = Name, @ReleaseDate = ReleaseDate, @DurationDisc = DurationDisc, @NumberSongs = NumberSongs, @StylesId = StylesId, 
@ArtistsId = ArtistsId, @PublishersId = PublishersId
from inserted

if @StylesId = (select StylesId 
				 from Discs join Styles on Styles.Id=Discs.StylesId 
				 where Styles.Name = 'Dark Power Pop')
print'Вставка запрещена! Диски с музыкальным стилем Dark Power Pop запрещено вставлять  в коллекцию'
else
begin
insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values (@Name, @ReleaseDate, @DurationDisc, @NumberSongs, @StylesId, @ArtistsId, @PublishersId)
print'Вставка успешно осуществлена!'
end
end;
go

--проверка

insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values ('Dont Happyend', '2014-09-19', '00:43:20', 15, 7, 3, 3)
go

select * from Discs
go

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--Создадим базу данных Sales_HW_2 и таблицы

create database Sales_HW_2;
go

use Sales_HW_2;
go

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

--Заполним их данными

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
					( 5, 5, 'велосипед', 8000, '2019-02-07');
go



/*Задание 3. 
К базе данных «Продажи» из практического задания модуля «Работа с таблицами и представлениями в MS SQL Server» 
создайте следующие триггеры: 
1. При добавлении нового покупателя триггер проверяет наличие покупателей с такой же фамилией. При нахождении совпадения 
триггер записывает об этом информацию в специальную таблицу 
2. При удалении информации о покупателе триггер переносит его историю покупок в таблицу «История покупок» 
3. При добавлении продавца триггер проверяет есть ли он в таблице продавцов, если запись существует добавление нового продавца отменяется 
4. При добавлении покупателя триггер проверяет есть ли он в таблице покупателей, если запись существует добавление нового покупателя отменяется 
5. Триггер не позволяет вставлять информацию о продаже таких товаров: яблоки, груши, сливы, кинза.*/


--1. При добавлении нового покупателя триггер проверяет наличие покупателей с такой же фамилией. При нахождении совпадения 
--триггер записывает об этом информацию в специальную таблицу 

--Создадаим таблицу NamesakersBuyers

create table NamesakersBuyers
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Mail nvarchar(100) null,
Fone nvarchar(20) null,
);
go

--Создадим сам триггер

create trigger "Проверка нового покупателя при вставке"
on Buyers
instead of insert
as
begin

declare @Name nvarchar(50), @Surname nvarchar(50), @Mail nvarchar(100), @Fone nvarchar(20)
select @Name = Name, @Surname = Surname, @Mail = Mail, @Fone = Fone
from inserted

if @Surname in (select Surname from Buyers)
begin
print'Обнаружен покупатель - однофамилец'
insert into NamesakersBuyers (Name, Surname, Mail, Fone)
values (@Name, @Surname, @Mail, @Fone)
print'Новый покупатель- однофамилец занесен в таблицу NamesakersBuyers'
insert into Buyers (Name, Surname, Mail, Fone)
values (@Name, @Surname, @Mail, @Fone)
return
end
else
begin
print'Новый покупатель имеет уникальную фамилию'
insert into Buyers (Name, Surname, Mail, Fone)
values (@Name, @Surname, @Mail, @Fone)
end
end;
go

--проверка

insert into Buyers(Name, Surname, Mail, Fone)
values ('Мария', 'Крофтова', 'MariyaCro@gmail.com', '25-24-51');
go

select * from Buyers;
go

select * from NamesakersBuyers;
go

--приостановим действие триггера

disable trigger "Проверка нового покупателя при вставке"
on Buyers;
go


--2. При удалении информации о покупателе триггер переносит его историю покупок в таблицу «История покупок» 

--Создадим архивную таблицу HistoryOfSales

create table HistoryOfSales
(
Id int identity(1,1) not null primary key,
SellersId int null,
BuyersId int null,
NameSales nvarchar(MAX) null,
Price money check(Price>0) null,
DateSales date null,
DeleteDate date null default(getdate()),
ProductSalesId int null,
);
go

--Создадаим сам триггер

create trigger "Сохранение истории покупок при удалении покупателя"
on Buyers
instead of delete
as
begin 

declare @Name nvarchar(50), @Surname nvarchar(50)
select @Name = Name, @Surname = Surname
from deleted

declare @BuyersId int, @SellersId int, @NameSales nvarchar(MAX), @Price money, @DateSales date, @ProductSalesId int

select @BuyersId = BuyersId, @SellersId = SellersId, @NameSales = NameSales, @Price = Price, @DateSales = DateSales 
from ProductSales join Buyers on Buyers.Id=ProductSales.BuyersId
where Name = @Name and Surname = @Surname

select @ProductSalesId = (select Id from ProductSales where BuyersId = @BuyersId and SellersId = @SellersId)

print'@SellersId = ' + convert(nvarchar(50), @SellersId)									--проверка
print'@BuyersId = '  + convert(nvarchar(50), @BuyersId) 
print'@NameSales = ' + @NameSales 
print'@Price = ' + convert(nvarchar(10), @Price)
print'@DateSales = ' + convert(nvarchar(20), @DateSales)
print'@ProductSalesId = ' + convert(nvarchar(20), @ProductSalesId)
print'@Name = ' + @Name + ' @Surname = ' + @Surname


if exists (select * from Buyers where Name = @Name and Surname = @Surname)
begin
insert into HistoryOfSales(SellersId, BuyersId, NameSales, Price, DateSales, DeleteDate, ProductSalesId)
values (@SellersId, @BuyersId, @NameSales, @Price, @DateSales, default, @ProductSalesId)

print 'Информация об истории покупок удаленного покупателя сохранена в таблице HistoruOfSales'
delete from Buyers
where Name = @Name and Surname=@Surname
print 'Удаление прошло успешно!'
end
else
begin
print 'Удалить невозможно! Такого покупателя в списке нет'
end
end;
go


--проверка

delete from Buyers
where Name = 'Артур' and Surname = 'Коньков';
go

select * from Buyers;
go

select * from ProductSales;
go

select * from HistoryOfSales;
go


--3. При добавлении продавца триггер проверяет есть ли он в таблице продавцов, если запись существует добавление нового продавца отменяется 

create trigger "Проверка продавцов на существование при вставке"
on Buyers
instead of insert
as
begin

declare @Name nvarchar(50), @Surname nvarchar(50)
select @Name = Name, @Surname = Surname
from inserted

if exists (select * from Buyers where Name = @Name and Surname = @Surname)
print'Вставка не возможна! Такой продавец уже существует!'
else
begin
insert into Buyers (Name, Surname)
values (@Name, @Surname)
print 'Вставка нового продаца прошла успешно!'
end
end;
go

--проверка

insert into Buyers (Name, Surname)
values ('Светлана', 'Хорунжая');
go

select * from Buyers;
go

--4. При добавлении покупателя триггер проверяет есть ли он в таблице покупателей, если запись существует добавление нового покупателя отменяется 

create trigger "Проверка покупателей на существование при вставке"
on Sellers
instead of insert
as
begin

declare @Name nvarchar(50), @Surname nvarchar (50)
select @Name = Name, @Surname = Surname
from inserted
if exists (select * from Sellers where Name = @Name and Surname = @Surname)
print'Вставка не возможна! Такой покупатель уже существует!'
else
begin
insert into Sellers(Name, Surname)
values (@Name, @Surname)
print 'Вставка нового покупателя прошла успешно!'
end

end;
go

--проверка

insert into Sellers(Name, Surname)
values ('Оксана', 'Кислова');
go

select * from Sellers;
go



--5. Триггер не позволяет вставлять информацию о продаже таких товаров: яблоки, груши, сливы, кинза.

create trigger "Запрет на вставку яблок, груш, слив, кинзы"
on ProductSales
instead of insert
as
begin

declare @NameSales nvarchar(MAX), @SellersId int, @BuyersId int, @Price money, @DateSales date
select @NameSales = NameSales, @SellersId = SellersId, @BuyersId = BuyersId, @Price = Price, @DateSales = DateSales
from inserted
if @NameSales in ('яблоки', 'яблоко', 'груши', 'груша', 'сливы', 'слива', 'кинза')
print'Запрещено вставлять такие продукты: яблоки, груши, сливы, кинзу'
else
begin
insert into ProductSales (NameSales, SellersId, BuyersId, Price, DateSales)
values (@NameSales, @SellersId, @BuyersId, @Price, @DateSales);
print'Продукт ' + convert(nvarchar(50), @NameSales) + ' успешно добавлен в таблицу ProductSales!'
end

end;
go

--проверка

insert into ProductSales (NameSales, SellersId, BuyersId, Price, DateSales)
values ('орехи', 1, 2, 50, getdate());
go

select * from ProductSales;
go