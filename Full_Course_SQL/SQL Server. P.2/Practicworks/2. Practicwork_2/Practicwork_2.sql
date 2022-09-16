/*������� 1. 
�������� ���� ������ ����������� �������. ��� ���� ������ ������ ��������� ���������� � �������, ��������, 
�����������, ��������. 
���������� ������� ��������� ����������: 
1. � �������: �������� ������, ��� ������ (������, �����, ��.�.), ���������� ������ � �������, �������������, 
�������������, ���� ������� 
2. � ��������: �������� ���������� ������, ���� �������, ����������, ���� �������, ���������� � �������� 
(��� ����������, ������������ �������), 
���������� � ���������� (��� ����������, ���� ����� ������������������ ����������) 
3. � �����������: ��� ����������, ���������, ���� ����� �� ������, ���, �������� 
4. � ��������: ��� �������, email, ���������� �������, ���, ������� �������, ������� ������, �������� �� �� �������� ��������.
���������� ���������� ��������� ���� ������. ��� �������� ���� ������ ����������� ������ CREATE DATABASE. 
��� �������� ������� ����������� ������ CREATE TABLE. ����������� ��� �������� ������ �������� ����� ����� ����. */

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
Name nvarchar(30) check(Name<>'') default('���������') not null,
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

--�������� ���� ������ ����������
use SportShop_PZ_2;
go

insert into Gender (Name) values
								('�������'),
								('�������');
go

insert into Position (Name) values
								('�������� �� ��������'),
								('��������');
go

insert into Employees (Name, Surname, PositionId, RecruitmentDate, GenderId, Salary) values
								('����', '���������', 1, '2018-05-23', 2, 10000),
								('�����', '������������', 1, '2015-11-05', 2, 12000),
								('������', '�������', 2, '2019-03-21', 1, 11000),
								('����', '��������', 2, '2012-07-13', 1, 13000);
go

insert into Clients(Name, Surname, GenderId, Discount, MailingList) values
								('�����', '��������', 1, 12.5, 0),
								('�����', '���������', 2, 7.5, 0),
								('����', '�����������', 1, 15, 1),
								('����', '�����������', 2, 10.5, 0),
								('�����', '���������', 2, 5, 0),
								('��������', '������', 1, 10, 0),
								('�������', '���������', 1, 15, 1);
go

insert into Manufacturer(Name) values
								('����������'),
								('�����������'),
								('��������������'),
								('������������');
go

insert into TypeProduct(Name) values
								('���������'),
								('����'),
								('��������'),
								('�����'),
								('������'),
								('���������� �������'),
								('����'),
								('����'),
								('��������� �������'),
								('������'),
								('������� �������'),
								('���������');
go

insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId) values
								('����', 1, 100, 1700, 1),
								('������', 1, 98, 1650, 1),
								('����', 1, 110, 1780, 1),
								('�� �����', 2, 93, 750, 1),
								('�������', 2, 87, 1100, 1),
								('������', 2, 99, 1500, 1),
								('�������', 3, 66, 1500, 1),
								('������', 3, 33, 950, 1),
								('��������', 3, 46, 700, 1),
								('��� ����', 4, 88, 190, 2),
								('Snapback M&JJ', 4, 102, 350, 2),
								('Babolat cup', 4, 93, 250, 2),
								('DeFacto', 5, 96, 560, 2),
								('Under Armor', 5, 88, 950, 2),
								('Emerson', 5, 75, 590, 2),
								('����', 6, 110, 2900, 2),
								('������', 6, 115, 1700, 2),
								('��� ������', 6, 77, 1500, 2),
								('LiveUp', 7, 36, 192, 3),
								('Spart', 7, 47, 530, 3),
								('Hop-Sport', 7, 49, 380, 3),
								('���� ���������', 8, 96, 790, 3),
								('�������', 8, 43, 900, 3),
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
								('Inter Atletica �������', 12, 1, 31900, 4);
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

--����������� ������
select Clients.Name+' '+Clients.Surname as [����������], Products.Name as [������], Sales.Number as [����������], 
Sales.DateSales as [���� �������], sum(Products.Price*Sales.Number)
from Clients join Sales on Clients.Id=Sales.ClientsId
			 join Products on Products.Id=Sales.ProductsId
group by Clients.Surname, Clients.Name, Products.Name, Sales.Number, Sales.DateSales



/*������� 2. 
��� ���� ������ �� ������� ������� �������� ��������, ������� ����� ������ ������ ����: 
1. ��� ������� ������, �������� ���������� � ������� � ������� ���������. ������� ��������� ������������ 
��� ������� ���������� � ���� �������� 
2. ���� ����� ������� ������ �� �������� �� ����� ������� ������� ������, ���������� ��������� ���������� 
� ��������� ��������� ������ � ������� ������ 
3. �� ��������� �������������� ��� ������������� �������. ��� ������� ��������� ������� ������� �� ��� � email 
4. ��������� �������� ������������ �������� 
5. ��������� �������� �����������, �������� �� ������ �� 2015 ���� 
6. ��� ����� ������� ������ ����� ��������� ����� ����� ������� �������. ���� ����� ��������� 50000 ���, 
���������� ���������� ������� ������ � 15% 
7. ��������� ��������� ����� ���������� �����. ��������, ����� ����� ���������������� 
8. ��� ������� ��������� ���������� ������ � �������. ���� �������� ���� ������� ������, ���������� ������ 
���������� �� ���� ������ 
� ������� ���������� �������.*/


--1. ��� ������� ������, �������� ���������� � ������� � ������� ���������. ������� ��������� ������������ 
--��� ������� ���������� � ���� �������� 

--�������� ������� History

create table History
(
Id int identity(1,1) not null primary key,
ProductsId int not null foreign key references Products(Id),
Operation nvarchar(200) not null,
CreatedAt datetime default getdate() not null,
);
go

--�������� ������� �� ������ � ������� History ��������� �������
create trigger "���������� ���������� � ������� ������� � ������� History"
on Sales
for insert as 
begin
--�������� ��������� ���������� @Name, ������� �������� �������� ������
declare @Name nvarchar(20)
select @Name = Products.Name
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--�������� ��������� ���������� @Manufacturer, ������� �������� �������� �������������
declare @Manufacturer nvarchar(50)
select @Manufacturer = Manufacturer.Name
from Manufacturer join Products on Manufacturer.Id=Products.ManufacturerId
				  join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--�������� ��������� ���������� @Number, ������� �������� ���������� ��������� �������
declare @Number int
select @Number = Sales.Number
from Sales 
where  Id = (Select Id from inserted)

--�������� ��������� ���������� @StockNumber, ������� �������� ���������� ���������� �� ������ �������
declare @StockNumber int
select @StockNumber = Products.StockNumber
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--�������� �� ������� ������������ ���������� ������ � ��������
if (@StockNumber - @Number >= 0)
begin
insert into History (ProductsId, Operation)
select ProductsId, '������ ����� ' + @Name + ' � ���������� ' + convert(nvarchar(10), Number) + ' ���� �� ������������� ' + @Manufacturer
from inserted 
--�������� ��������� ������� � ������� �������� - Products.StockNumber
update Products
set StockNumber = @StockNumber - @Number
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)
end
--���� � ������� ���������� ������ �� ������� ������, ��� ��������, �� ������� ����������
else
print '������� ������ ����������. ������������ ������ �� ������'
end;
go

--��������
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values (23, 4, Getdate(), 3, 5);
go

select * from History


--2. ���� ����� ������� ������ �� �������� �� ����� ������� ������� ������, ���������� ��������� ���������� 
--� ��������� ��������� ������ � ������� ������ 

--�������� ������� Archive
create table Archive
(
Id int identity(1,1) not null primary key,
ProductsId int not null foreign key references Products(Id),
Operation nvarchar(200) not null,
CreatedAt datetime default getdate() not null,
);
go

--�������� ������� "���������� ���������� � ������� ������� � ������� History", ����� �� �� ����� ������ ��������
disable trigger "���������� ���������� � ������� ������� � ������� History" on Sales;
go


--��������� �������
create trigger "���������� ���������� � ��������� ��������� ������� � ������� Archive"
on Sales
for insert as 
begin
--�������� ��������� ���������� @Name, ������� �������� �������� ������
declare @Name nvarchar(20)
select @Name = Products.Name
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--�������� ��������� ���������� @Manufacturer, ������� �������� �������� �������������
declare @Manufacturer nvarchar(50)
select @Manufacturer = Manufacturer.Name
from Manufacturer join Products on Manufacturer.Id=Products.ManufacturerId
				  join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--�������� ��������� ���������� @Number, ������� �������� ���������� ��������� �������
declare @Number int
select @Number = Sales.Number
from Sales 
where  Id = (Select Id from inserted)

--�������� ��������� ���������� @StockNumber, ������� �������� ���������� ���������� �� ������ �������
declare @StockNumber int
select @StockNumber = Products.StockNumber
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)

--�������� �� ������� ������������ ���������� ������ � ��������
if (@StockNumber - @Number >= 0)
begin
insert into History (ProductsId, Operation)
select ProductsId, '������ ����� ' + @Name + ' � ���������� ' + convert(nvarchar(10), Number) + ' ���� �� ������������� ' + @Manufacturer
from inserted 
--�������� ��������� ������� � ������� �������� - Products.StockNumber
update Products
set StockNumber = @StockNumber - @Number
from Products join Sales on Products.Id=Sales.ProductsId
where  ProductsId = (Select ProductsId from inserted)
end
if (@StockNumber - @Number = 0)
begin
print'��������� ��������� ����� ' + @Name + ' �� ������������� ' + @Manufacturer
insert into Archive (ProductsId, Operation)
select ProductsId, '��������� ��������� ����� ' + @Name + ' �� ������������� ' + @Manufacturer + ' ��������� ������� � ���������� - ' + convert(nvarchar(10), Number) + ' ���� '
from inserted 
end
--���� � ������� ���������� ������ �� ������� ������, ��� ��������, �� ������� ����������
if (@StockNumber - @Number < 0)
begin
print '������� ������ ����������. ������������ ������ �� ������'
end
end;
go

--��������
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values (30, 1, Getdate(), 4, 1);
go
select * from Archive
go

--3. �� ��������� �������������� ��� ������������� �������. ��� ������� ��������� ������� ������� �� ��� � email 

create trigger "�������� ����������� �������� �� ��� � email"  
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

--����������� ������ �������, ���� ������ ������ ��� ��� ������� ��� �� ����������������
if (@Name in(select Name from Clients) and @Surname in(select Surname from Clients)) 
   begin
   print '� ����������� ��������. ������ � ����� ������ � �������� ��� ��������������� � �������'
   return
   end
else if (@Email in(select Email from Clients))
   begin
   print '� ����������� ��������. ������ � ����� ������� ��� ��������������� � �������'
   return
   end
else 
   begin
   insert into Clients(Name, Surname, Email, GenderId) 
   select Name, Surname, Email, GenderId
   from inserted
   print '����������� ������ �������. ����� ������ ��������������� � �������'
   end

end;  
go

--��������
insert into Clients(Name, Surname, Email, GenderId) values ('�����', '��������', 'Mormysh@gmail.con', 1);
go
select * from Clients
go




--4. ��������� �������� ������������ �������� 

Create trigger "������ �� �������� ������������ ��������"
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
print '������� ������������ �������� ������!'
else
print '������� �������������� �������� ���� ������! �� ������ ���!)))'
end;
go

--��������
delete from Clients
where Clients.Name='�����' and Clients.Surname='��������';
go

select * from Clients
go



--5. ��������� �������� �����������, �������� �� ������ �� 2015 ���� 

Create trigger "������ �� �������� �����������, �������� �� ������ �� 2015 ����"
on Employees
instead of delete
as
begin

declare @RecrutDate date
select @RecrutDate = RecruitmentDate
from deleted

if (@RecrutDate < '2015-01-01')
begin
print '������� �����������, �������� �� ������ �� 2015 ����, �� ������� ��������� - ������!'
return
end
if (@RecrutDate >= '2015-01-01')
begin
delete from Employees
where RecruitmentDate >=  @RecrutDate 
print '�������� �����������, �������� �� ������ ����� ' + convert(nvarchar(10),@RecrutDate) + ' ������ �������!'
end
end;
go

--��������
delete from Employees
where Employees.Name = '����';
go

select * from Employees
go



--6. ��� ����� ������� ������ ����� ��������� ����� ����� ������� �������. ���� ����� ��������� 50000 ���, 
--���������� ���������� ������� ������ � 15% 

create trigger "�������� ����� ������� � 15% ������ �� ����� ������� 50000"
on Sales
for insert as 
begin

--�������� ��������� ���������� @Number, ������� �������� ���������� ��������� �������
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

print '��������� ����� ������� ���������� - ' + convert(nvarchar(10), @SumPurchase) + ' ������'

if @SumPurchase > 50000
begin
print'�����������! ����� ������� ��������� 50000 ������, ������� ��������������� ������ 15%'
print '������� ������ ����� ������� - ' + convert(nvarchar(20), @SumPurchase) + ' ������, � ������ 15% ������ �� ��������� ����� ' + convert(nvarchar(10), @SumPurchase/100*85)+ ' ������'
update Clients
set Discount=15
where Id = (select ClientsId from inserted)
end
else
print'������������ � ��������� ������ ��������! ���� �� �������� ������� �� ����� 50000 ������, �� �� �������� �� ��� ������ � 15%'
end;
go

--��������
insert into Sales (ProductsId, Number, EmployeesId, ClientsId)
values (16, 30, 1, 4);
go

select * from Clients;
go


--7. ��������� ��������� ����� ���������� �����. ��������, ����� ����� ���������������� 

create trigger "������ ��������� ������ ���������� �����"
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

if @Manufacturer = '��������������'
print'��������! ������� ������� ������ ����� ' + @Manufacturer + ' � ��������� ��������� �� ������'
else
begin
insert into Products(Name, TypeProductId, Price, ManufacturerId)
values (@Name, @TypeProductId, @Price, @ManufacturerId)
print'����� ����� ' + @Manufacturer + ' ������� �������� � ���� ������ ��������'
end
end;
go

--��������
insert into Products(Name, TypeProductId, Price, ManufacturerId)
values ('Snowball 23S', 8, 780, 3);
go

select * from Products;
go


--8. ��� ������� ��������� ���������� ������ � �������. ���� �������� ���� ������� ������, ���������� ������ 
--���������� �� ���� ������ � ������� ���������� �������.

--�������� ������� LastUnit

create table LastUnit
(
Id int identity(1,1) not null primary key,
IsLastUnit bit null default(0),
ProductsId int not null foreign key references Products(Id),
);
go

create trigger "���������� ���������� � ��������� ������� ���������"
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
print'�������� ������� ���������'
insert into LastUnit(IsLastUnit, ProductsId)
values(1, @ProductsId)
end
end;
go


--��������
insert into Sales (ProductsId, Number, DateSales, EmployeesId, ClientsId) values (29, 2, Getdate(), 4, 5);
go
select * from LastUnit
go