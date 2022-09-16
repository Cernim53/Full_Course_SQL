--�������� ���� ������
create database SportShop_HW_3
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

--�������� �� �������

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

/*������� 1. 
��� ���� ������ ����������� ������� �� ������������� ������� ������ ���������, �������� ��������� � ���������������� ������� 
�������� ��������� �������� ���������: 
1. �������� ��������� ���������� ������ ���������� ����� ������� 
2. �������� ��������� ���������� ������ ���������� ������� ����������� ����. ��� ������ ��������� � �������� ���������. 
��������, ���� � �������� ��������� ������� �����, ����� �������� ��� �����, ������� ���� � ������� 
3. �������� ��������� ���������� ���-3 ����� ������ ��������. ���-3 ������������ �� ���� ����������� 
4. �������� ��������� ���������� ���������� � ����� �������� ��������. ���������� ������������ �� ����� ����� ������ �� �� �����
5. �������� ��������� ��������� ���� �� ���� ���� ����� ���������� ������������� � �������. �������� ������������� ��������� � �������� ���������. 
�� ������ ������ �������� ��������� ������ ������� yes � ��� ������, ���� ����� ����, � no, ���� ������ ��� 
6. �������� ��������� ���������� ���������� � ����� ���������� ������������� ����� �����������. ������������ ����� ����������� ������������ 
�� ����� ����� ������ 
7. �������� ��������� ������� ���� ��������, ������������������ ����� ��������� ����. ���� ��������� � �������� ���������. 
��������� ���������� ���������� ��������� �������. */

--1. �������� ��������� ���������� ������ ���������� ����� ������� 

create procedure sp_infoAboutProducts
as
begin
select Products.Name as [������������ �������], TypeProduct.Name as [��� ���������], Products.StockNumber as [������� �� ������], 
Products.Price as [����], Products.CostPrice as [�������������],  Products.Details as [�����������] --, Manufacturer.Name as [�������������]
from Products join TypeProduct on TypeProduct.Id=Products.TypeProductId 
			  join Manufacturer on Manufacturer.Id=Products.ManufacturerId
order by Products.Name, TypeProduct.Name
end;
go

--��������
exec sp_infoAboutProducts;
go

--2. �������� ��������� ���������� ������ ���������� ������� ����������� ����. ��� ������ ��������� � �������� ���������. 
--��������, ���� � �������� ��������� ������� �����, ����� �������� ��� �����, ������� ���� � ������� 

create procedure sp_infoAboutAllProductsOfOneType
@TypeProductName nvarchar(50)
as
begin
select Products.Name as [������������ �������], TypeProduct.Name as [��� ���������], Products.StockNumber as [������� �� ������], 
Products.Price as [����], Products.CostPrice as [�������������],  Products.Details as [�����������] --, Manufacturer.Name as [�������������]
from Products join TypeProduct on TypeProduct.Id=Products.TypeProductId 
			  join Manufacturer on Manufacturer.Id=Products.ManufacturerId
where TypeProduct.Name = @TypeProductName
order by Products.Name, TypeProduct.Name
end;
go

--��������
exec sp_infoAboutAllProductsOfOneType '���������';
go


--3. �������� ��������� ���������� ���-3 ����� ������ ��������. ���-3 ������������ �� ���� ����������� (� ����� �������, �� ���� ������ �������)

create procedure sp_top3_OldestClients
as
begin
select top (3) Clients.Name+' '+Clients.Surname as [�������], Sales.DateSales as [���� ������ �������]
from Clients join Sales on Clients.Id=Sales.ClientsId
group by DateSales, Name, Surname
having DateSales = min(DateSales) 
end;
go

--��������
exec sp_top3_OldestClients;
go


--4. �������� ��������� ���������� ���������� � ����� �������� ��������. ���������� ������������ �� ����� ����� ������ �� �� �����

create procedure sp_mostSuccessfulEmployees
as
begin
select Employees.Name+' '+Employees.Surname as [��������], Position.Name as [���������], sum(Sales.Number*Products.Price) as [����� ����� ������]
from Employees join Position on Position.Id=Employees.PositionId
			   join Sales on Employees.Id = Sales.EmployeesId
			   join Products on Products.Id = Sales.ProductsId
group by Employees.Name, Employees.Surname, Position.Name
having sum(Sales.Number*Products.Price) >= all(select sum(Sales.Number*Products.Price) 
											   from Sales join Products on 	Products.Id = Sales.ProductsId
														  join Employees on Employees.Id = Sales.EmployeesId
											   group by Employees.Name, Employees.Surname)
end;
go

--��������
exec sp_mostSuccessfulEmployees;
go


--5. �������� ��������� ��������� ���� �� ���� ���� ����� ���������� ������������� � �������. �������� ������������� ��������� � �������� ���������. 
--�� ������ ������ �������� ��������� ������ ������� yes � ��� ������, ���� ����� ����, � no, ���� ������ ��� 

create procedure sp_isProductInStocks
@conclusion nvarchar(10) output,
@ManufacturerName nvarchar(100)
as
begin
if exists (select * from Products join Manufacturer on Manufacturer.Id=Products.ManufacturerId
		   where StockNumber <> 0 and Manufacturer.Name = @ManufacturerName)
set @conclusion = 'Yes'
else
set @conclusion = 'No'
print @conclusion
end;
go

--��������
declare @Conclusions nvarchar(10)
exec sp_isProductInStocks @Conclusions output, @ManufacturerName = '������������';
go


--6. �������� ��������� ���������� ���������� � ����� ���������� ������������� ����� �����������. ������������ ����� ����������� ������������ 
--�� ����� ����� ������ 

create procedure sp_mostSuccessfulManufacturer
as
begin
select Manufacturer.Name as [�������������], sum(Sales.Number*Products.Price) as [����� ����� ������]
from Manufacturer join Products on Manufacturer.Id=Products.ManufacturerId
				  join Sales on Products.Id = Sales.ProductsId
group by Manufacturer.Name
having sum(Sales.Number*Products.Price) >= all(select sum(Sales.Number*Products.Price) 
											   from Sales join Products on 	Products.Id = Sales.ProductsId
														  join Manufacturer on Manufacturer.Id=Products.ManufacturerId
											   group by Manufacturer.Name)
end;
go

--��������
exec sp_mostSuccessfulManufacturer;
go


--7. �������� ��������� ������� ���� ��������, ������������������ ����� ��������� ����. ���� ��������� � �������� ���������. 
--��������� ���������� ���������� ��������� �������.

create procedure sp_deleteClientsAfterOneDate
@NumberDeletedEntries int output,
@DateSalesProducts date
as
begin
declare @NumberClients_1 int
declare @NumberClients_2 int

select @NumberClients_1 = count(Clients.Id) from Clients

delete from Clients 
where Id in (select Sales.ClientsId from Sales where DateSales > @DateSalesProducts)

select @NumberClients_2 = count(Clients.Id) from Clients
set @NumberDeletedEntries = @NumberClients_1 - @NumberClients_2
print'���� ������� '+ convert(nvarchar(10), @NumberDeletedEntries) + ' ��������, ������������������ ����� ' + convert(nvarchar(10), @DateSalesProducts)
end;
go

--��������
declare @NumberDeleted int
exec sp_deleteClientsAfterOneDate @NumberDeleted output, @DateSalesProducts = '2020-06-15';
go

select * from Clients;
go


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--��������� ���� ������

create database MusicCollection_HW_3;
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

--�������� �� �������

insert into Countries(Name) values ('���'), 
								   ('�������'),
								   ('��������������');
go
insert into Publishers(Name, CountriesId) values 
								   ('Epic Records', 1), 
								   ('������ ����������� ������������', 2), 
								   ('Lavina Music', 2),
								   ('Susy Records', 2),
								   ('Columbia', 3);
go
insert into Styles (Name) values   ('R&B'),
								   ('����-�-����'),
								   ('��� �����'),
								   ('���� ���'),
								   ('��� ���'),
								   ('����'),
								   ('Dark Power Pop');
go
insert into Artists (Name, Surname) values 
								   ('�����', '�������'),
								   ('�������', '�������'),
								   ('���������', '��������'),
								   ('�����', '������');
go
insert into Discs (Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId) values
								   ('Invincible', '2001-10-30', '01:17:10', 16, 1, 1, 1),
								   ('Dangerous', '1991-11-26', '01:13:12', 14, 2, 1, 1),
								   ('Thriller', '1982-11-08', '00:42:19', 9, 2, 1, 1),
								   ('Love it ����', '2019-05-17', '01:01:06', 20, 3, 2, 2),
								   ('������', '2016-05-25', '00:44:03', 16, 4, 2, 2),
								   ('��� ���', '2016-05-19', '00:51:25', 11, 5, 3, 3),
								   ('�����', '2013-05-13', '00:48:53', 12, 4, 3, 4),
								   ('21', '2011-01-24', '00:48:12', 11, 6, 4, 5),
								   ('Mong', '2014-05-13', '00:41:43', 11, 6, 4, 5);
go
insert into Songs (Name, Duration, DisksId, StylesId, ArtistsId) values
								   ('Unbreakable', '00:06:26', 1, 1, 1),
								   ('Remember the time', '00:04:00', 2, 2, 1),
								   ('Billie Jean', '00:10:37', 3, 2, 1),
								   ('�������...', '00:04:12', 4, 3, 2),
								   ('������', '00:03:18', 5, 4, 2),
								   ('³���� ��� ���� �����', '00:04:04', 6, 5, 3),
								   ('�����', '00:03:44', 7, 4, 3),
								   ('Rolling in the Deep', '00:03:46', 8, 6, 4),
								   ('Kontra bas', '00:03:41', 8, 6, 4);
go

/*������� 2. 
��� ���� ������ ������������ ���������� �� ������������� ������� ������ ������� � ��������� � ��������������� � MS SQL Server� 
�������� ��������� �������� ���������: 
1. �������� ��������� ���������� ������ ���������� ������������ ������ 
2. �������� ��������� ���������� ������ ���������� ����� ����������� ������ ����������� ��������. �������� �������� ��������� � �������� ��������� 
3. �������� ��������� ���������� �������� ������ ����������� ����� 
4. ������������ ����� ������������ �� ���������� ������ � ��������� 
5. �������� ��������� ���������� ���������� � ����� ����������� ����� � ���������� ����������� �����. �������� 
����� ��������� � �������� ���������, ���� �������� ����� all, ������ ��� �� ���� ������ 
6. �������� ��������� ������� ��� ����� ��������� �����. �������� ����� ��������� � �������� ���������. 
��������� ���������� ���������� ��������� �������� 
7. �������� ��������� ���������� ���������� � ����� ������� ������ � ����� ��������. 
�������� � ��������� ������������ �� ���� ������� 
8. �������� ��������� ������� ��� ����� � �������� ������� ���� �������� �����. 
����� ��������� � �������� ���������. ��������� ���������� ���������� ��������� ��������.*/


--1. �������� ��������� ���������� ������ ���������� ������������ ������ 

create procedure sp_infoAboutDiscs
as
begin
select Discs.Name as [�������� �������/�����], Artists.Name + ' ' + Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������], 
Discs.DurationDisc as [�����������������], Discs.NumberSongs as [���������� �����], Styles.Name as [����� ����������], 
Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
order by Artists.Surname, Artists.Name, Discs.Name
end;
go

--��������

exec sp_infoAboutDiscs;
go


--2. �������� ��������� ���������� ������ ���������� ����� ����������� ������ ����������� ��������. �������� �������� ��������� � �������� ��������� 

create procedure sp_infoAboutDiscsOnePublishers
@Publisher nvarchar(100)
as
begin
select Discs.Name as [�������� �������/�����], Artists.Name + ' ' + Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������], 
Discs.DurationDisc as [�����������������], Discs.NumberSongs as [���������� �����], Styles.Name as [����� ����������], 
Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
where Publishers.Name = @Publisher
order by Artists.Surname, Artists.Name, Discs.Name
end;
go

--��������

exec sp_infoAboutDiscsOnePublishers @Publisher = 'Epic Records';
go


--3. �������� ��������� ���������� �������� ������ ����������� ����� 
--4. ������������ ����� ������������ �� ���������� ������ � ��������
--��� ����� ������� ��������� ����� ���������

create procedure sp_mostPopularStyle
as
begin
select Styles.Name as [����� ���������� �����], count(Discs.Id) as [���������� ������ � ���� �����]
from Styles join Discs on Styles.Id=Discs.StylesId
group by Styles.Name
having count(Discs.Id) >= all(select count(Discs.Id) 
							  from Styles join Discs on Styles.Id=Discs.StylesId 
							  group by Styles.Name)
end;
go

--��������

exec sp_mostPopularStyle;
go


--5. �������� ��������� ���������� ���������� � ����� ����������� ����� � ���������� ����������� �����. �������� ����� ��������� 
--� �������� ���������, ���� �������� ����� all, ������ ��� �� ���� ������ 

create procedure sp_infoAboutDiscsWithMaximumSongsForStyles
@StylesName nvarchar(50)
as 
begin
if @StylesName = 'all'
begin
select Discs.Name as [�������� �������/�����], Artists.Name + ' ' + Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������], 
Discs.DurationDisc as [�����������������], Discs.NumberSongs as [���������� �����], Styles.Name as [����� ����������], 
Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
where Discs.NumberSongs in (select MAX(NumberSongs) from Styles join Discs on Styles.Id=Discs.StylesId group by Styles.Name)			   
order by Artists.Surname, Artists.Name, Discs.Name
end

else
begin
select Discs.Name as [�������� �������/�����], Artists.Name + ' ' + Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������], 
Discs.DurationDisc as [�����������������], Discs.NumberSongs as [���������� �����], Styles.Name as [����� ����������], 
Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
where Styles.Name = @StylesName and Discs.NumberSongs >= all(select NumberSongs 
															 from Discs join Styles on Styles.Id=Discs.StylesId
															 where Styles.Name = @StylesName)
order by Artists.Surname, Artists.Name, Discs.Name
end
end;
go

--��������

exec sp_infoAboutDiscsWithMaximumSongsForStyles @StylesName = '����-�-����';
go
--���
exec sp_infoAboutDiscsWithMaximumSongsForStyles @StylesName = 'all';
go


---6. �������� ��������� ������� ��� ����� ��������� �����. �������� ����� ��������� � �������� ���������. 
--��������� ���������� ���������� ��������� �������� 

create procedure sp_deleteDiscsOneStyle
@NumberDeletedEntries int output,
@StylesName nvarchar(50)
as
begin

declare @NumberDiscs_1 int
declare @NumberDiscs_2 int
select @NumberDiscs_1 = count(Id) from Discs

delete from Discs 
where StylesId in (select Id from Styles where Name = @StylesName)

select @NumberDiscs_2 = count(Id) from Discs
set @NumberDeletedEntries = @NumberDiscs_1 - @NumberDiscs_2
print'���� ������� '+ convert(nvarchar(10), @NumberDeletedEntries) + ' ������, ����� ' + convert(nvarchar(10), @StylesName)
end;
go

--��������
declare @NumberDeleted int
exec sp_deleteDiscsOneStyle @NumberDeleted output, @StylesName = '���� ���';
go

select * from Discs;
go


--7. �������� ��������� ���������� ���������� � ����� ������� ������� � ����� ��������. 
--�������� � ��������� ������������ �� ���� ������� 

create procedure sp_infoAboutOldestYoungestDiscs
as
begin
select Discs.Name as [����� ������ ������], Artists.Name + ' ' + Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������], 
Discs.DurationDisc as [�����������������], Discs.NumberSongs as [���������� �����], Styles.Name as [����� ����������], 
Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
where Discs.ReleaseDate <= all(select ReleaseDate from Discs) 
select Discs.Name as [����� ������� ������], Artists.Name + ' ' + Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������], 
Discs.DurationDisc as [�����������������], Discs.NumberSongs as [���������� �����], Styles.Name as [����� ����������], 
Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
where Discs.ReleaseDate >= all(select ReleaseDate from Discs) 
end;
go

--��������

exec sp_infoAboutOldestYoungestDiscs;
go


--8. �������� ��������� ������� ��� ����� � �������� ������� ���� �������� �����. 
--����� ��������� � �������� ���������. ��������� ���������� ���������� ��������� ��������.

create procedure sp_deleteDiscsOneWord
@NumberDeletedEntries int output,
@Word nvarchar(50)
as
begin
declare @NumberDiscs_1 int
declare @NumberDiscs_2 int
select @NumberDiscs_1 = count(Id) from Discs
declare @WordInText nvarchar(50)
set @WordInText = convert(nvarchar(5), '%') + @Word + convert(nvarchar(5), '%')
delete from Discs 
where Name like @WordInText
select @NumberDiscs_2 = count(Id) from Discs
set @NumberDeletedEntries = @NumberDiscs_1 - @NumberDiscs_2
print'���� ������� '+ convert(nvarchar(10), @NumberDeletedEntries) + ' ������, � ������� ������������ ����� ' + convert(nvarchar(10), @Word)
end;
go

--��������
declare @NumberDeleted int
exec sp_deleteDiscsOneWord @NumberDeleted output, @Word = 'on';
go

select * from Discs;
go