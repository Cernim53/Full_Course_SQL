/*������� 1. �������� ���� ������ ����������� ����������. ��� ���� ������ ������ ��������� ���� ������� �����. 
� ������� ����� �������: ��� ��������, ���� ��������, ���, �������, ����� ����������, ������ ����������, �������� �����. 
��� �������� ���� ������ ����������� ������ CREATE DATABASE. ��� �������� ������� ����������� ������ CREATE TABLE. */


-- �������� ���� ������ Phonebook_PZ_1

create database Phonebook_PZ_1
go

-- �������� ������� People �� ��������� Id, Name, Surname, BirthDate, Gender, Fone, City, Country � Adress

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

--�������� ���������� ����� ��� ������� Id

alter table People 
add constraint pkTable_1 primary key (Id)
go

create table People
--����� ���� ����� ������� ��������� ����, ��� �������� ������� People.
-- ����� ������ ������ ������ ���� �� ���� �����:
-- Id int identity(1,1) not null primary key,


/*������� 2. �������� ���� ������ ��������. ���� ������ ������ ��������� ���������� � ���������, �����������, ��������. 
���������� ������� ��������� ����������: 
1. � ���������: ���, email, ���������� ������� 
2. � �����������: ���, email, ���������� ������� 
3. � ��������: ����������, ��������, �������� ������, ���� �������, ���� ������. 
��� �������� ���� ������ ����������� ������ CREATE DATABASE. 
��� �������� ������� ����������� ������ CREATE TABLE. ����������� ��� �������� ������ �������� ����� ����� ����.*/

--�������� ���� ������ Sales_PZ_1

create database Sales_PZ_1;
go

--�������� ������ Sellers, Buyers, Product_sales � ���������������� ��������� � ����������, �������, � ����� 
--� ��������������� ����������� ����� ���������

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

--��������: ������� ������ �� ������

select Sellers.Name+' '+Sellers.Surname as [��������], Buyers.Name+' '+Buyers.Surname as [����������], 
ProductSales.Name as [�����], ProductSales.Price as [���� �������], ProductSales.DataSales as [���� �������]
from Sellers join ProductSales on Sellers.Id=ProductSales.SellersId
			 join Buyers on Buyers.Id=ProductSales.BuyersId
order by ProductSales.DataSales;




/*������� 3. �������� ���� ������ ������������ ����������. ���� ������ ������ ��������� ���������� ������������ ������, ������������, ������. 
���������� ������� ��������� ����������: 
1. � ����������� �����: �������� �����, �����������, ���� �������, �����, �������� 
2. � ������: �������� ������ 
3. �� ������������: �������� 
4. �� ���������: ��������, ������ 
5. � ������: �������� �����, �������� �����, ������������ �����, ����������� ����� �����, �����������. 
���������� ���������� ��������� ���� ������. ��� �������� ���� ������ ����������� ������ CREATE DATABASE. 
��� �������� ������� ����������� ������ CREATE TABLE. ����������� ��� �������� ������ �������� ����� ����� ����. */

--�������� ���� ������ MusicCollection_PZ_1

create database MusicCollection_PZ_1
go

--�������� ������ Discs, Styles, Artists, Publishers, Countries, Songs � ���������������� ��������� � ����������, �������, � ����� 
--� ��������������� ����������� ����� ���������

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


/*������� 4. ��� ������� ���������� ��������� �� ��������� � ���� ������ �� �������� �������: 
1. �������� � ��� ������������ ������� � ����������� ������������ ����� ������� � ������� ��������� �� ���� 
2. �������� � ��� ������������ ������� � ����������� �� �������� ������� � ����������� ������� �������� ����� 
3. �������� � ��� ������������ ������� � ����������� ������� ������ ����, �������� �������� ����� 
4. ������� �� ��� ������������ ������� � ����������� �� �������� ������� � ����������� ������� �������� �����
5. ������� ����� ����� ��������� ������������ ������ � ������������� 
6. �������� ����� ����� ��������� ������������ ������ � �������������. */

--1
Alter table Discs
add Review nvarchar(MAX) null;
go

--2
Alter table Publishers
add LegalAddress nvarchar(MAX) null;
go

--3
--�.�. � ���� Name ����������� ����������� (Name<>''), ������� ��������� ��������� ���� Name, 
--���������� ������� ����� �����������, � ����� �������� ���� ����

Alter table Songs
drop CK__Songs__Name__74794A92;
go

--������ ������ �������� ���� Name nvarchar(MAX) �� Name nvarchar(100)
Alter table Songs 
alter column Name nvarchar(100) not null;
go

--� ���������� ����������� ����������� (Name<>'')
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

--��������: ������� ������ �� ������
use MusicCollection_PZ_1
go

insert into Countries(Name) values ('���'), 
								   ('�������');
go
insert into Publishers(Name, CountriesId) values 
								   ('Epic Records', 1), 
								   ('������ ����������� ������������', 2), 
								   ('����� 211', 2);
go
insert into Styles (Name) values   ('R&B'),
								   ('����-�-����'),
								   ('��� �����'),
								   ('���� ���'),
								   ('��� ���');
go
insert into Artists (Name, Surname) values 
								   ('�����', '�������'),
								   ('�������', '�������'),
								   ('���������', '��������');
go
insert into Discs (Name, ReleaseDate, StylesId, ArtistsId, PublishersId) values
								   ('Invincible', '2001-10-30', 1, 1, 1),
								   ('Dangerous', '1991-11-26', 2, 1, 1),
								   ('Love it ����', '2019-05-17', 3, 2, 2),
								   ('������', '2016-05-25', 4, 2, 2),
								   ('��� ����', '2016-05-19', 5, 3, 3);
go
insert into Songs (Name, Duration, DisksId, StylesId, ArtistsId) values
								   ('Unbreakable', '06:26', 1, 1, 1),
								   ('Remember the time', '04:00', 2, 2, 1),
								   ('�������...', '04:12', 3, 3, 2),
								   ('������', '03:18', 4, 4, 2),
								   ('³���� ��� ���� �����', '04:04', 5, 5, 3);
go

--������ �� ��������� �������
select Artists.Name+' '+Artists.Surname as [�����������], Songs.Name as [�����], Discs.Name as [������], Songs.Duration as [�����������������],
Styles.Name as [����� ����������], Publishers.Name as [��������], Countries.Name as [������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Songs on Discs.Id=Songs.DisksId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId
		   join Countries on Countries.Id=Publishers.CountriesId
go

/*������� 5. �������� ��������� �������������. � �������� ���� ������ ����������� ���� ������ �� �������� �������: 
1. ������������� ���������� �������� ���� ������ 
2. ������������� ���������� �������� ���� ��������� 
3. ������������� ���������� ������ ���������� � �����: �������� �����, �����������, ���� �������, �����, ��������.*/

--1
create view StylesName as 
select Styles.Name as [�������� ������]
from Styles;
go

select * 
from StylesName;
go

--2
create view "�������� ���� ���������" as
select Publishers.Name as [�������� ���������]
from Publishers;
go

select *
from "�������� ���� ���������";
go

--3
create view "������ ���������� � �����" as
select Discs.Name as [�������� ����� / �������], Artists.Name+' '+Artists.Surname as [�����������], Discs.ReleaseDate as [���� �������],
Styles.Name as [����� ����������], Publishers.Name as [��������]
from Discs join Artists on Artists.Id=Discs.ArtistsId
		   join Styles on Styles.Id=Discs.StylesId
		   join Publishers on Publishers.Id=Discs.PublishersId;
go

select *
from "������ ���������� � �����";
go