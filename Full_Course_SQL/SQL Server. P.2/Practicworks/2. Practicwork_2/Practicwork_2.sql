/*Задание 1. 
Создайте базу данных «Спортивный магазин». Эта база данных должна содержать информацию о товарах, продажах, 
сотрудниках, клиентах. 
Необходимо хранить следующую информацию: 
1. О товарах: название товара, вид товара (одежда, обувь, и т.д.), количество товара в наличии, себестоимость, 
производитель, цена продажи 
2. О продажах: название проданного товара, цена продажи, количество, дата продажи, информация о продавце 
(ФИО сотрудника, выполнившего продажу), 
информация о покупателе (ФИО покупателя, если купил зарегистрированный покупатель) 
3. О сотрудниках: ФИО сотрудника, должность, дата приёма на работу, пол, зарплата 
4. О клиентах: ФИО клиента, email, контактный телефон, пол, история заказов, процент скидки, подписан ли на почтовую рассылку.
Продумайте правильную структуру базы данных. Для создания базы данных используйте запрос CREATE DATABASE. 
Для создания таблицы используйте запрос CREATE TABLE. Обязательно при создании таблиц задавать связи между ними. */

create database SportShop_PZ_2;
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

--наполним базу данных значениями
use SportShop_PZ_2;
go

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

--проверочный запрос
select Clients.Name+' '+Clients.Surname as [Покупатель], Products.Name as [Товары], Sales.Number as [Количество], 
Sales.DateSales as [Дата продажи], sum(Products.Price*Sales.Number)
from Clients join Sales on Clients.Id=Sales.ClientsId
			 join Products on Products.Id=Sales.ProductsId
group by Clients.Surname, Clients.Name, Products.Name, Sales.Number, Sales.DateSales



/*Задание 2. 
Для базы данных из первого задания создайте триггеры, которые будут решать задачи ниже: 
1. При продаже товара, заносить информацию о продаже в таблицу «История». Таблица «История» используется 
для дубляжа информации о всех продажах 
2. Если после продажи товара не осталось ни одной единицы данного товара, необходимо перенести информацию 
о полностью проданном товаре в таблицу «Архив» 
3. Не позволять регистрировать уже существующего клиента. При вставке проверять наличие клиента по ФИО и email 
4. Запретить удаление существующих клиентов 
5. Запретить удаление сотрудников, принятых на работу до 2015 года 
6. При новой покупке товара нужно проверять общую сумму покупок клиента. Если сумма превысила 50000 грн, 
необходимо установить процент скидки в 15% 
7. Запретить добавлять товар конкретной фирмы. Например, товар фирмы «Спортинвентарь» 
8. При продаже проверять количество товара в наличии. Если осталась одна единица товара, необходимо внести 
информацию об этом товаре 
в таблицу «Последняя Единица».*/


--1. При продаже товара, заносить информацию о продаже в таблицу «История». Таблица «История» используется 
--для дубляжа информации о всех продажах 

--Создадим таблицу History

create table History
(
Id int identity(1,1) not null primary key,
ProductsId int not null foreign key references Products(Id),
Operation nvarchar(200) not null,
CreatedAt datetime default getdate() not null,
);
go

--Создадим триггер по записи в таблицу History проданных товаров
create trigger "Сохранение информации о продажи товаров в таблице History"
on Sales
for insert as 
begin
--создадим локальную переменную @Name, которой присвоим название товара
declare @Name nvarchar(20)
select @Name = Products.Name
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--создадим локальную переменную @Manufacturer, которой присвоим название производителя
declare @Manufacturer nvarchar(50)
select @Manufacturer = Manufacturer.Name
from Manufacturer join Products on Manufacturer.Id=Products.ManufacturerId
				  join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--создадим локальную переменную @Number, которой присвоим количество проданных товаров
declare @Number int
select @Number = Sales.Number
from Sales 
where  Id = (Select Id from inserted)

--создадим локальную переменную @StockNumber, которой присвоим количество оставшихся на складе товаров
declare @StockNumber int
select @StockNumber = Products.StockNumber
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--проверка на наличие достаточного количества товара в остатках
if (@StockNumber - @Number >= 0)
begin
insert into History (ProductsId, Operation)
select ProductsId, 'Продан товар ' + @Name + ' в количестве ' + convert(nvarchar(10), Number) + ' штук от производителя ' + @Manufacturer
from inserted 
--удаление проданных товаров в столбце остатков - Products.StockNumber
update Products
set StockNumber = @StockNumber - @Number
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)
end
--если в запросе количество товара на продажу меньше, чем остатков, то продажа невозможна
else
print 'Продажа товара невозможна. Недостаточно товара на складе'
end;
go

--проверка
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values (23, 4, Getdate(), 3, 5);
go

select * from History


--2. Если после продажи товара не осталось ни одной единицы данного товара, необходимо перенести информацию 
--о полностью проданном товаре в таблицу «Архив» 

--создадим таблицу Archive
create table Archive
(
Id int identity(1,1) not null primary key,
ProductsId int not null foreign key references Products(Id),
Operation nvarchar(200) not null,
CreatedAt datetime default getdate() not null,
);
go

--отключим триггер "Сохранение информации о продажи товаров в таблице History", чтобы он не мешал новому триггеру
disable trigger "Сохранение информации о продажи товаров в таблице History" on Sales;
go


--создадаим триггер
create trigger "Сохранение информации о полностью проданных товарах в таблице Archive"
on Sales
for insert as 
begin
--создадим локальную переменную @Name, которой присвоим название товара
declare @Name nvarchar(20)
select @Name = Products.Name
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--создадим локальную переменную @Manufacturer, которой присвоим название производителя
declare @Manufacturer nvarchar(50)
select @Manufacturer = Manufacturer.Name
from Manufacturer join Products on Manufacturer.Id=Products.ManufacturerId
				  join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--создадим локальную переменную @Number, которой присвоим количество проданных товаров
declare @Number int
select @Number = Sales.Number
from Sales 
where  Id = (Select Id from inserted)

--создадим локальную переменную @StockNumber, которой присвоим количество оставшихся на складе товаров
declare @StockNumber int
select @StockNumber = Products.StockNumber
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--проверка на наличие достаточного количества товара в остатках
if (@StockNumber - @Number >= 0)
begin
insert into History (ProductsId, Operation)
select ProductsId, 'Продан товар ' + @Name + ' в количестве ' + convert(nvarchar(10), Number) + ' штук от производителя ' + @Manufacturer
from inserted 
--удаление проданных товаров в столбце остатков - Products.StockNumber
update Products
set StockNumber = @StockNumber - @Number
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)
end
if (@StockNumber - @Number = 0)
begin
print'Полностью распродан товар ' + @Name + ' от производителя ' + @Manufacturer
insert into Archive (ProductsId, Operation)
select ProductsId, 'Полностью распродан товар ' + @Name + ' от производителя ' + @Manufacturer + ' Последняя продажа в количестве - ' + convert(nvarchar(10), Number) + ' штук '
from inserted 
end
--если в запросе количество товара на продажу меньше, чем остатков, то продажа невозможна
if (@StockNumber - @Number < 0)
begin
print 'Продажа товара невозможна. Недостаточно товара на складе'
end
end;
go

--проверка
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values (30, 1, Getdate(), 4, 1);
go
select * from Archive
go

--3. Не позволять регистрировать уже существующего клиента. При вставке проверять наличие клиента по ФИО и email 

create trigger "Проверка регистрации клиентов по ФИО и email"  
on Clients
instead of insert
as
begin 

declare @Name nvarchar(50)
select @Name = Name
from  inserted

declare @Surname nvarchar(50)
select @Surname = Surname
from inserted

declare @Email nvarchar(100)
select @Email = Email
from inserted

--регистрация нового клиента, если клиент стаким ФИО или Емейлом еще не регистрировались
if (@Name in(select Name from Clients) and @Surname in(select Surname from Clients)) 
   begin
   print 'В регистрации отказано. Клиент с таким именем и фамилией уже зарегистрирован в системе'
   return
   end
else if (@Email in(select Email from Clients))
   begin
   print 'В регистрации отказано. Клиент с таким емейлом уже зарегистрирован в системе'
   return
   end
else 
   begin
   insert into Clients(Name, Surname, Email, GenderId) 
   select Name, Surname, Email, GenderId
   from inserted
   print 'Регистрация прошла успешно. Новый клиент зарегистрирован в системе'
   end

end;  
go

--проверка
insert into Clients(Name, Surname, Email, GenderId) values ('Антон', 'Мормышка', 'Mormysh@gmail.con', 1);
go
select * from Clients
go




--4. Запретить удаление существующих клиентов 

Create trigger "Запрет на удаление существующих клиентов"
on Clients
instead of delete
as
begin
declare @Name nvarchar(50)
declare @Surname nvarchar(50)

select @Name = Name 
from deleted
select @Surname = Surname
from deleted

if (@Name in (select Name from Clients) and @Surname in(select Surname from Clients))
print 'Удалять существующих клиентов нельзя!'
else
print 'Удалить несуществующих клиентов тоже нельзя! Их просто нет!)))'
end;
go

--проверка
delete from Clients
where Clients.Name='Антон' and Clients.Surname='Мормышка';
go

select * from Clients
go



--5. Запретить удаление сотрудников, принятых на работу до 2015 года 

Create trigger "Запрет на удаление сотрудников, принятых на работу до 2015 года"
on Employees
instead of delete
as
begin

declare @RecrutDate date
select @RecrutDate = RecruitmentDate
from deleted

if (@RecrutDate < '2015-01-01')
begin
print 'Удалять сотрудников, принятых на работу до 2015 года, по приказу директора - нельзя!'
return
end
if (@RecrutDate >= '2015-01-01')
begin
delete from Employees
where RecruitmentDate >=  @RecrutDate 
print 'Удаление сотрудников, принятых на работу после ' + convert(nvarchar(10),@RecrutDate) + ' прошло успешно!'
end
end;
go

--проверка
delete from Employees
where Employees.Name = 'Юрий';
go

select * from Employees
go



--6. При новой покупке товара нужно проверять общую сумму покупок клиента. Если сумма превысила 50000 грн, 
--необходимо установить процент скидки в 15% 

create trigger "Проверка суммы покупки и 15% скидки на сумму покупки 50000"
on Sales
for insert as 
begin

--создадим локальную переменную @Number, которой присвоим количество проданных товаров
declare @Number int
select @Number = Sales.Number
from Sales 
where  Id = (Select Id from inserted)

declare @Price money
select @Price = Products.Price
from Products join Sales on Products.Id=Sales.ProductsId
where Sales.ProductsId = (select ProductsId from inserted)

declare @Discount real
select @Discount = Clients.Discount
from Clients join Sales on Clients.Id=Sales.ClientsId
where ClientsId = (select ClientsId from inserted)

declare @SumPurchase money
select @SumPurchase = @Number*@Price

print 'Стоимость вашей покупки составляет - ' + convert(nvarchar(10), @SumPurchase) + ' гривен'

if @SumPurchase > 50000
begin
print'Поздравляем! Сумма покупки превысила 50000 гривен, поэтому устанавливается скидка 15%'
print 'Поэтому вместо суммы покупки - ' + convert(nvarchar(20), @SumPurchase) + ' гривен, с учетом 15% скидки Вы заплатите всего ' + convert(nvarchar(10), @SumPurchase/100*85)+ ' гривен'
update Clients
set Discount=15
where Id = (select ClientsId from inserted)
end
else
print'Приобщайтесь к программе скидок магазина! Если Вы сделаете покупки на сумму 50000 гривен, то Вы получите от нас скидку в 15%'
end;
go

--проверка
insert into Sales (ProductsId, Number, EmployeesId, ClientsId)
values (16, 30, 1, 4);
go

select * from Clients;
go


--7. Запретить добавлять товар конкретной фирмы. Например, товар фирмы «Спортинвентарь» 

create trigger "Запрет добавлять товары конкретной фирмы"
on Products
instead of insert
as
begin
declare @ManufacturerId int
select @ManufacturerId = ManufacturerId 
from inserted

declare @Manufacturer nvarchar(50)
select @Manufacturer = Name 
from Manufacturer
where Id = (select ManufacturerId from inserted)

declare @Name nvarchar(50)
select @Name = Name
from inserted

declare @TypeProductId int
select @TypeProductId = TypeProductId
from inserted

declare @Price money
select @Price = Price
from inserted

if @Manufacturer = 'Спортинвентарь'
print'Извините! Введены санкции против фирмы ' + @Manufacturer + ' и запрещено продавать ее товары'
else
begin
insert into Products(Name, TypeProductId, Price, ManufacturerId)
values (@Name, @TypeProductId, @Price, @ManufacturerId)
print'Товар фирмы ' + @Manufacturer + ' успешно добавлен в базу данных магазина'
end
end;
go

--проверка
insert into Products(Name, TypeProductId, Price, ManufacturerId)
values ('Snowball 23S', 8, 780, 3);
go

select * from Products;
go


--8. При продаже проверять количество товара в наличии. Если осталась одна единица товара, необходимо внести 
--информацию об этом товаре в таблицу «Последняя Единица».

--Создадим таблицу LastUnit

create table LastUnit
(
Id int identity(1,1) not null primary key,
IsLastUnit bit null default(0),
ProductsId int not null foreign key references Products(Id),
);
go

create trigger "Сохранение информации о последней единице продукции"
on Sales
for insert as 
begin

declare @ProductsId int
select @ProductsId = ProductsId
from inserted

declare @Number int
select @Number = Sales.Number
from Sales 
where  Id = (Select Id from inserted)

declare @StockNumber int
select @StockNumber = Products.StockNumber
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

if (@StockNumber - @Number = 1)
begin
print'Осталась единица продукции'
insert into LastUnit(IsLastUnit, ProductsId)
values(1, @ProductsId)
end
end;
go


--проверка
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values (29, 2, Getdate(), 4, 5);
go
select * from LastUnit
go