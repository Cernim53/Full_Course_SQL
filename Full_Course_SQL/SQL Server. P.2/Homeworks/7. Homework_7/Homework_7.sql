create database MusicCollection_HW_7;
go

use MusicCollection_HW_7;
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
								   ('��� ���', '2019-11-28', '00:43:17', 7, 6, 2, 4),
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
								   ('ѳ��� ���� ���� - �����', '00:05:12', 7, 6, 2),
								   ('�����', '00:03:44', 8, 4, 3),
								   ('Rolling in the Deep', '00:03:46', 9, 6, 4),
								   ('Kontra bas', '00:03:41', 9, 6, 4);
go


/*������� 1. 
��� ���� ������ ������������ ���������� ��������� ��������� �������. ����������� �������� PIVOT: 

1. ���������� ���������� �� ������������ � ������ ��� ����������� ��������. 
��������� ������ ���� ����������� ������ ���������: 
�����������, �������� ������ (���������� �������� ������� �� ���������� ������). 
 ������� ����������� ������ ���� �������� ������������. 
� �������� ������ � �������� �������� ������ ���� ���������� �������� ����������� � ��� ��� ���� �����, ���� ������� � ����� ����� ��� � ������� ����� NULL-�������� */

select
(select Name+' '+Surname from Artists where Id= PivotTable.ArtistsId) 
as '�����������', 
[R&B], 
[����-�-����], 
[��� �����],
[���� ���], 
[��� ���], 
[����], 
[Dark Power Pop]
from
(select ArtistsId, StylesId, Styles.Name from Discs join Styles on Styles.Id=Discs.StylesId) as p

pivot (count(StylesId) for Name in ([R&B], [����-�-����], [��� �����], [���� ���], [��� ���], [����], [Dark Power Pop])) as PivotTable


/*2. ���������� ���������� �� ��������� � ������ �������� ����������� ��������. 
��������� ������ ���� ����������� ������ ���������: �����, �������� ��������� (���������� �������� ������� �� ���������� ���������). 
� ������� ����� ������ ���� �������� ������. 
� �������� ��������� � �������� �������� ������ ���� ���������� �������� �������� � ��� ��� ���� �����, ���� ������� � ����� ����� ��� � �������� 
� ������� ����� NULL-��������.*/

select
(select Name from Styles where Id = PivotTable.StylesId ) as '�����', 
[Epic Records],
[������ ����������� ������������],
[Lavina Music],
[Susy Records],
[Columbia]
from
(select PublishersId, StylesId, Publishers.Name  from Discs join Publishers on Publishers.Id=Discs.PublishersId) as p

pivot(count(PublishersId) for Name in ([Epic Records], [������ ����������� ������������], [Lavina Music], [Susy Records], [Columbia])) as PivotTable



/*������� 2. 
��� ���� ������ ������������ ���������� ��������� ��������� �������. ����������� �������� UNPIVOT �� ��������� � �����������, ���������� � ������ �������: 
1. ���������� ���������� �� ������������ � ������ ��� ����������� ��������. 
��������� ������ ���� ����������� ������ ���������: �����������, �����, ���������� ��������. � ������� ����������� ������ ���� �������� ������������. 
� ������� ����� �������� ������. 
� ������� ���������� �������� ���������� �������� ����������� � ���������� ����� */

--������� ������

select Artists.Name + ' ' + Artists.Surname as [�����������], Styles.Name as [�����], count(StylesId) as [���������� ������]
from Artists join Discs on Artists.Id=Discs.ArtistsId
			 join Styles on Styles.Id=Discs.StylesId
group by Artists.Surname, Artists.Name, Styles.Name

--�������� ������� �  ������ � ������ ������� � �������

select
(select Name+' '+Surname from Artists where Id= PivotTable.ArtistsId) 
as '�����������', 
[R&B], 
[����-�-����], 
[��� �����],
[���� ���], 
[��� ���], 
[����], 
[Dark Power Pop]
from
(select ArtistsId, StylesId, Styles.Name from Discs join Styles on Styles.Id=Discs.StylesId) as p

pivot (count(StylesId) for Name in ([R&B], [����-�-����], [��� �����], [���� ���], [��� ���], [����], [Dark Power Pop])) as PivotTable

--unpivot (StylesId for Name in ([R&B], [����-�-����], [��� �����], [���� ���], [��� ���], [����], [Dark Power Pop])) as UnpivotTable

--��������� unpivot �� ������ ���������� ��������; �� ����, ������ �������� ��������� ������ ���� � unpivot, �� �� ��������




/*2. ���������� ���������� �� ��������� � ������ ��� ����������� ��������. 
��������� ������ ���� ����������� ������ ���������: ��������, �����, ���������� ��������. 
� ������� �������� ������ ���� �������� ���������. 
� ������� ����� �������� ������. � ������� ���������� �������� ���������� �������� �������� � ���������� �����. */

select
(select Name from Styles where Id = PivotTable.StylesId ) as '�����', 
[Epic Records],
[������ ����������� ������������],
[Lavina Music],
[Susy Records],
[Columbia]
from
(select PublishersId, StylesId, Publishers.Name  from Discs join Publishers on Publishers.Id=Discs.PublishersId) as p

pivot(count(PublishersId) for Name in ([Epic Records], [������ ����������� ������������], [Lavina Music], [Susy Records], [Columbia])) as PivotTable

--unpivot(PublishersIs for Name in ([Epic Records], [������ ����������� ������������], [Lavina Music], [Susy Records], [Columbia])) as UnpivotTable

--��������� unpivot �� ������ ���������� ��������; �� ����, ������ �������� ��������� ������ ���� � unpivot, �� �� ��������




create database SportShop_HW_7;
go

use SportShop_HW_7;
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
insert into Clients(Name, Surname, GenderId, Discount, MailingList, BirthDate) values
								('�����', '��������', 1, 12.5, 0, '1980-07-13'),
								('�����', '���������', 2, 7.5, 0, '1972-11-09'),
								('����', '�����������', 1, 15, 1, '2000-04-03'),
								('�������', '����������', 1, 7, 1, '1975-09-28'),
								('����', '�����������', 2, 10.5, 0, '1997-08-27'),
								('�����', '���������', 2, 5, 0, '2003-12-29'),
								('��������', '������', 1, 10, 0, '1986-01-10'),
								('�������', '���������', 1, 15, 1, '1995-03-19'),
								('������', '�����', 1, 5, 0, '1974-12-29'),
								('����', '���������', 2, 10, 0, '1975-01-19');
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

/*������� 3. 
��� ���� ������ ����������� ������� ��������� ��������� �������. 
����������� �������� PIVOT: 
1. ���������� ���������� � �������������� � ����� �������. 
��������� ������ ���� ����������� ����� ���������: �������������, ��� ������� (���������� �������� ������� �� ���������� ����� �������). 
� ������� ������������� ������ ���� �������� ��������������. 
 �������� ��� ������� � �������� �������� ������ ���� ���������� ����� ������� � ������� ����� ����������� �������������, ���� ���� ������ ��� � ������� 
� ������� ����� NULL-��������*/

select
(select Name from Manufacturer where Id = PivotTable.ManufacturerId) as '�������������',
[1]  as '���������',
[2]  as '����',
[3]  as '��������',
[4]  as '�����',
[5]  as '������',
[6]  as '���������� �������',
[7]  as '����',
[8]  as '����',
[9]  as '��������� �������',
[10]  as '������',
[11]  as '������� �������',
[12]  as '���������'
from 
(select TypeProductId, ManufacturerId, StockNumber  from Products) as Prod

pivot(sum(StockNumber) for TypeproductId in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) as PivotTable



/*2. ���������� ���������� � �������������� � ����� �������. 
��������� ������ ���� ����������� ����� ���������: ��� ������, ������������� (���������� �������� ������� �� ���������� ��������������). 
� ������� ��� ������ ������ ���� �������� �������. 
� �������� �������������� � �������� �������� ������ ���� ���������� ������ ������ � ������� ����� ����������� �������������, ���� ���� ������ 
� ������������� ��� � ������� � ������� ����� NULL-��������.*/

select
(select Name from Products where Id = PivotTable.Id) as '��� �������',
[1] as '����������',
[2] as '�����������',
[3] as '��������������',
[4] as '������������'
from 
(select ManufacturerId, Name, StockNumber, Id from Products) as Manu

pivot (sum(StockNumber) for ManufacturerId in ([1], [2], [3], [4])) as PivotTable




