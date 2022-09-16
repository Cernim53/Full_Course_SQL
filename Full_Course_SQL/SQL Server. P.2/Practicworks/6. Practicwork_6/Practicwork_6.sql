create database Sales_PZ_6;
go

--�������� �������

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

--�������� ���� �������

insert into Sellers (Name, Surname, Mail, Fone) values
					('����', '��������', 'OlegSt@gmail.com', '22-33-45'),
					('����', '��������', 'Martyn@gmail.com', '32-17-63'),
					('��������', '�������', 'Svetic@gmail.com', '34-23-07'),
					('�����', '�������', 'API@gmail.com', '42-86-99'),
					('����', '���������', 'WAch@gmail.com', '24-35-84');
go

insert into Buyers (Name, Surname, Mail, Fone) values
					('�����', '�������', 'IPOL@gmail.com', '22-15-03'),
					('�������', '����������', 'Sreda@gmail.com', '54-76-01'),
					('�����', '�������', 'Artchy@gmail.com', '32-90-74'),
					('����', '��������', 'Stepa@gmail.com', '36-80-21'),
					('�����', '����������', 'MariyaKo@gmail.com', '41-41-80');
go

insert into ProductSales (SellersId, BuyersId, NameSales, Price, DateSales) values
					( 1, 1, '���', 235000, '2020-05-16'),
					( 2, 2, '����', 125000, '2020-07-11'),
					( 3, 3, '�����', 50000, '2019-10-03'),
					( 4, 4, '����������', 180000, '2020-08-01'),
					( 5, 5, '���������', 8000, '2019-02-07'),
					( 4, 4, '������', 60000, '2020-08-01');
go


/*������� 1. 
��� ���� ������ �������� �� ������������� ������� ������ ������� � ��������� � ��������������� �MS SQL Server� ��������� ����� ��������: 
1. �������� ����� clustered (����������������) �������� ��� ��� ������, ��� ��� ���������� 
2. �������� ����� nonclustered (������������������) �������� ��� ��� ������, ��� ��� ���������� 
3. ������ ����� �� ��� composite (�����������) ������� � ������ ��������� ���� ������ � ��������. ���� ��, �������� ������� 
4. ������ ����� �� ��� indexes with included columns (������� � ����������� ���������). ���������� ��������� ���� ������ � ��������. 
���� ������������� ����, �������� ������� 
5. ������ ����� �� ��� filtered indexes (��������������� �������). ���������� ��������� ���� ������ � ��������. ���� ������������� ����, �������� ������� 
6. ��������� execution plans (����� ����������) ��� �������� ������ �������� � ����� ������ ������� �� �������������. 
���� ������� ������ ����� �� ������������������, ���������� ������ ��������� �������� � ������� �������� ����� ��������.*/


--1. �������� ����� clustered (����������������) �������� ��� ��� ������, ��� ��� ���������� 

--��� ��� ������� - dbo.Buyers, dbo.Sellers, dbo.ProductSales ����� ���������������� ������� � ���� ��������� ������. � ������� ����� ���� ������ ���� ���������������� ������,
--������� ������ ���������������� �������� �� �� �������



--2. �������� ����� nonclustered (������������������) �������� ��� ��� ������, ��� ��� ���������� 

--�� ����� ������� ������������������ ������� ��� ������ � ������� ����������� �������, ����� �������� ����� ������ �� ���� ��������. ��� ���� ������ �������� ���������
--������������������ �������, ���������� ������ ���� ������� - ����� � ������� ��������� � �����������

create nonclustered index IX_NonClusteredNameSurnameBuyers on Buyers (Name asc, Surname asc);
go

create nonclustered index IX_NonClusteredNameSurnameSellers on Sellers (Name asc, Surname asc);
go



--3. ������ ����� �� ��� composite (�����������) ������� � ������ ��������� ���� ������ � ��������. ���� ��, �������� ������� 

--� ������� 2 ��� ������ ��������� ������� ��� ������ dbo.Buyers � dbo.Sellers, ������� �������� ��� ������� - ��� � ������� ����������� � ���������.
--����� ������ ���� ��������� ������������������ ��� ������ ����������� ��� ��������� �� "������� ����� � �������"
--� ������� 2 ������� ������������������ ��������� �������
--���� �������� ������ ��������������� �������

create nonclustered index IX_NonClusteredBuyersAllColumns on Buyers 
(Name asc, Surname asc, Mail asc, Fone asc);
go



--4. ������ ����� �� ��� indexes with included columns (������� � ����������� ���������). ���������� ��������� ���� ������ � ��������. 
--���� ������������� ����, �������� ������� 

--������� � ����������� ��������� ��������� ��������� ������������������ ������. ��� ���� ������ ���� �������, � ������ ������ ������, ������� ��� ��������. 
--�� ���������� ������ ��� ���� ����� ��������
--���� ��������� ��������� �������� �������� � ����������� ���������, ������� ����� ���� ������� ��� ������������ ��������

create nonclustered index IX_NonClusteredNameSurnameBuyersAndFone on Buyers 
(Name asc, Surname asc)
include (Fone);
go

create nonclustered index IX_NonClusteredNameSurnameSellersAndMailFone on Sellers 
(Name asc, Surname asc)
include (Mail, Fone);
go



--5. ������ ����� �� ��� filtered indexes (��������������� �������). ���������� ��������� ���� ������ � ��������. ���� ������������� ����, �������� ������� 
--������������� ������� ����� ���� �������, ����� �����, ����� ����������� ��������� ������� ��� ������ � ������ ������
--���� �������� ������ ������������������ ��������� ��������������� �������� � ���������� �������� NameSales, ������� ���������� �.�. ����� ������ nvarchar(MAX)

create nonclustered index IX_NonClusteredNamePriceDateOfProductSales on ProductSales 
(Price asc, DateSales asc)
include (NameSales)
where Price is not null and DateSales > '2000-01-01';				--	���� ������ not null � ���� ������� - ����� 1 ������ 2000 ����
go


--6. ��������� execution plans (����� ����������) ��� �������� ������ �������� � ����� ������ ������� �� �������������. 
--���� ������� ������ ����� �� ������������������, ���������� ������ ��������� �������� � ������� �������� ����� ��������.

select NameSales as [�������� ������], Price as [��������� �������], Buyers.Name+' '+Buyers.Surname as [����������], Sellers.Name+' '+Sellers.Surname as [��������], 
DateSales as [���� �������]
from ProductSales join Buyers on Buyers.Id=ProductSales.BuyersId
				  join Sellers on Sellers.Id=ProductSales.SellersId
where DateSales > '2020-01-01';
go

--�� ������� ������ ����� ��������������������