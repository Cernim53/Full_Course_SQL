--��������������� ������
--�������� ���� ������ MusicCollection_HW_1 � ��������� Styles, Artists, Countries, Publishers, Discs, Songs, 

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

--�������� ���� ������ ����������

use MusicCollection_HW_1
go

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
								   ('����');
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
								   ('21', '2011-01-24', '00:48:12', 11, 6, 4, 5);
go
insert into Songs (Name, Duration, DisksId, StylesId, ArtistsId) values
								   ('Unbreakable', '00:06:26', 1, 1, 1),
								   ('Remember the time', '00:04:00', 2, 2, 1),
								   ('Billie Jean', '00:10:37', 3, 2, 1),
								   ('�������...', '00:04:12', 4, 3, 2),
								   ('������', '00:03:18', 5, 4, 2),
								   ('³���� ��� ���� �����', '00:04:04', 6, 5, 3),
								   ('�����', '00:03:44', 7, 4, 3),
								   ('Rolling in the Deep', '00:03:46', 8, 6, 4);
go


/*������� 1. ��� ������� ���������� ��������� �� ��������� � ���� ������ ������������ ����������, ��������� 
������������� ������� ��� ����� ������. �������� ��������� �������������: 
1. ������������� ���������� �������� ���� ������������ 
2. ������������� ���������� ������ ���������� � ���� ������: �������� �����, �������� �����, 
������������ �����, ����������� ����� �����, ����������� 
3. ������������� ���������� ���������� � ����������� ������ ���������� ������. ��������, The Beatles 
4. ������������� ���������� �������� ������ ����������� � ��������� �����������. ������������ ������������ �� ���������� ������ � ��������� 
5. ������������� ���������� ���-3 ����� ���������� ���������� ������������. ������������ ������������ �� ���������� ������ � ��������� 
6. ������������� ���������� ����� ������ �� ������������ ����������� ������.*/

--1
create view "�������� ���� ������������" as
select Artists.Name+' '+Artists.Surname as [�����������]
from Artists;
go

select * from "�������� ���� ������������";
go

--2
create view "���������� � ���� ������" as
select Songs.Name as [�������� �����], Discs.Name as [�������� �������/�����], Songs.Duration as [������������ �����], 
Styles.Name as [����������� �����], Artists.Name+' '+Artists.Surname as [�����������]
from Songs  join Discs on Discs.Id=Songs.DisksId
			join Styles on Styles.Id=Discs.StylesId and Styles.Id=Songs.StylesId
			join Artists on Artists.Id=Discs.ArtistsId and Artists.Id=Songs.ArtistsId;
go

select * from "���������� � ���� ������";
go

--3
create view "���������� � ������ �.��������" as
select Artists.Name+' '+Artists.Surname as [�����������], Discs.Name as [�����/�������], Discs.ReleaseDate as [���� �������], Publishers.Name as [��������]
from Discs  join Publishers on Publishers.Id=Discs.PublishersId
			join Artists on Artists.Id=Discs.ArtistsId
where Artists.Name = '�����' and Artists.Surname = '�������';
go

select * from "���������� � ������ �.��������";
go

--4
create view "����� ���������� ����������� � ���������" as
select Artists.Name+' '+Artists.Surname as [�����������], count(Discs.ArtistsId) as [���������� ������]
from Artists join Discs on Artists.Id=Discs.ArtistsId
group by Artists.Surname, Artists.Name, Discs.ArtistsId
having count(Discs.ArtistsId) >= all (select count(Discs.ArtistsId) 
									  from Artists join Discs on Artists.Id=Discs.ArtistsId
									  group by Artists.Surname, Artists.Name, Discs.ArtistsId);
go

select * from "����� ���������� ����������� � ���������";
go

--5
create view "TOP-3 ����� ���������� ������������" as
select Top(3) Artists.Name+' '+Artists.Surname as [�����������], count(Discs.ArtistsId) as [���������� ������]
from Artists join Discs on Artists.Id=Discs.ArtistsId
group by Artists.Surname, Artists.Name, Discs.ArtistsId;
go

select * from "TOP-3 ����� ���������� ������������";
go

--6
create view "����� ������� ����" as
select Artists.Name+' '+Artists.Surname as [�����������], Discs.Name as [�������� �������/�����], Discs.DurationDisc as [����������������� �������/�����]
from Artists join Discs on Artists.Id=Discs.ArtistsId
where Discs.DurationDisc >= all(select Discs.DurationDisc from Discs);
go

select * from "����� ������� ����";
go


/*������� 2. ��� ������� ���������� ��������� �� ��������� � ���� ������ ������������ ����������, ��������� 
� ������������ ������� ��� ����� ������: 
1. �������� ����������� �������������, ������� �������� ��������� ����� ����� 
2. �������� ����������� �������������, ������� �������� ��������� ����� ����� 
3. �������� ����������� �������������, ������� �������� ��������� ���������� �� �������� 
4. �������� ����������� �������������, ������� �������� ������� ������������ 
5. �������� ����������� �������������, ������� �������� ��������� ���������� � ���������� �����������. 
��������, Muse. */

--1
create view "���������� ����� ������" as
select Styles.Name
from Styles;
go

insert into "���������� ����� ������"(Name)
values ('�������������� ���');
go

--2
create view "���������� ����� �����" as
select Songs.Name, Songs.Duration, Songs.DisksId, Songs.StylesId, Songs.ArtistsId
from Songs
go

insert into "���������� ����� �����"(Name, Duration, DisksId, StylesId, ArtistsId)
values ('�� ���', '00:03:41', 7, 5, 3);
go

--3
-- ������� � �������� �������� ����� "Records", ���� � �������� �������� ������������ ����� "music" � �� ������������ ����� "records"
create view "���������� ���������� �� ��������" as
select Publishers.Name
from Publishers;
go

update "���������� ���������� �� ��������"
set Name += ' Records' where Name like '%music%' and Name not like '%records%';
go

--4
create view "�������� ������������" as
select Artists.Name, Artists.Surname
from Artists;
go

delete from "�������� ������������"
where Name='�����' and Surname='�������';
go

--�������� �� ���������, ������ ���:
--��� ������������� ����� ��������, ���� ��� ����������� �� �������� ����� �� ������ �� ������ �������
--���� ����� ����������� ����, �� ��� ������� ����� �������, ����� ������� ������ ������(������), ����� ����� 
--������������ ����������� �� �������� �����
--������ ��� ����������� �� �������� ����� ��� ������ � ������� Artists, �.�. �� ArtistsId

Alter table Songs
drop FK__Songs__ArtistsId__02C769E9;
go
Alter table Discs
drop FK__Discs__ArtistsId__7B264821;
go

--������ �������� ������ �������
delete from "�������� ������������"
where Name='�����' and Surname='�������';
go

--����������� ������
select *
from Artists;
go

--����������� ����������� �� ������� ������ ArtistsId ��� ������ Songs � Discs � �������� Artists(Id)
alter table Songs
add foreign key (ArtistsId) references Artists(Id);
go
alter table Discs
add foreign key (ArtistsId) references Artists(Id);
go


--5
--������� ������/��������� ��� ����������� ������� �������
--��� ����� ������� � ������� Artists ������� Status

Alter table Artists
add Status nvarchar(MAX) default('unknown');
go

--������ ������� ������ � ������� ������� ��������
create view "���������� ���������� �� �����������" as
select Artists.Name, Artists.Surname, Artists.Status
from Artists;
go

update "���������� ���������� �� �����������"
set Status = '������� ������� ���������� ���������, ��������� �� ����� ������. ������� ��������� �������� � ������ 15 ����� � �����'
where Name='�������' and Surname='�������';
go


/*������� 3. ��� ������� ���������� ��������� �� ��������� � ���� ������ ��������, ��������� � ������������ ������� ��� ����� ������: 
1. �������� ����������� �������������, ������� ���������� ���������� � ���� ��������� 
2. �������� ����������� �������������, ������� ���������� ���������� � ���� ����������� 
3. �������� ����������� �������������, ������� ���������� ���������� � ���� �������� ����������� ������. ��������, ����������� � ����� 
4. �������� �������������, ������������ ��� �������������� ������
5. �������� �������������, ������������ ���������� ������ �������� ��������. ���������� ������ ��������� �������� 
�� ������������ ����� ����� ������ 
6. �������� �������������, ������������ ���������� � ����� �������� ����������. ���������� ������ ��������� ���������� 
�� ������������ ����� ����� �������. 
����������� ����� CHECK OPTION, SCHEMABINDING, ENCRYPTION ���, ��� ��� ���������� ��� �������.*/

use Sales_PZ_1
go

--1
create view "���������� � ���� ���������"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [��� ���������], Buyers.Fone as [�������], Buyers.Mail as [EMAIL]
from Buyers;
go

select * from "���������� � ���� ���������";
go

--2
create view "���������� � ���� �����������"
with encryption as
select Sellers.Name+' '+Sellers.Surname as [��� �����������], Sellers.Fone as [�������], Sellers.Mail as [EMAIL]
from Sellers;
go

select * from "���������� � ���� �����������";
go

--3
create view "���������� � �������� ����������� � �����"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [��� ���������], Sellers.Name+' '+Sellers.Surname as [��� �����������], 
ProductSales.Name as [��������� �����], ProductSales.Price as [����], ProductSales.DataSales as [���� �������]
from Buyers join ProductSales on Buyers.Id=ProductSales.BuyersId
			join Sellers on Sellers.Id=ProductSales.SellersId
where ProductSales.Name like '%����������%' or ProductSales.Name like '%���%';
go

select * from "���������� � �������� ����������� � �����";
go

--4
create view "���������� � ���� �������"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [��� ���������], Sellers.Name+' '+Sellers.Surname as [��� �����������], 
ProductSales.Name as [��������� �����], ProductSales.Price as [����], ProductSales.DataSales as [���� �������]
from Buyers join ProductSales on Buyers.Id=ProductSales.BuyersId
			join Sellers on Sellers.Id=ProductSales.SellersId;
go

select * from "���������� � ���� �������";
go

--5
create view "���������� � ����� �������� ��������"
with encryption as
select Buyers.Name+' '+Buyers.Surname as [��� ���������], sum(ProductSales.Price) as [����� ������]
from Buyers join ProductSales on Buyers.Id=ProductSales.BuyersId
group by Buyers.Surname, Buyers.Name
having sum(ProductSales.Price) >= all(select sum(ProductSales.Price) 
									  from ProductSales, Buyers 
									  where Buyers.Id=ProductSales.BuyersId
									  group by Buyers.Surname, Buyers.Name)
with check option;
go

select * from "���������� � ����� �������� ��������";
go

--6
create view "���������� � ����� �������� ����������"
with encryption as
select Sellers.Name+' '+Sellers.Surname as [��� �����������], sum(ProductSales.Price) as [����� �������]
from Sellers join ProductSales on Sellers.Id=ProductSales.SellersId
group by Sellers.Surname, Sellers.Name
having sum(ProductSales.Price) >= all(select sum(ProductSales.Price) 
									  from ProductSales, Sellers 
									  where Sellers.Id=ProductSales.SellersId
									  group by Sellers.Surname, Sellers.Name)
with check option;
go

select * from "���������� � ����� �������� ����������";
go