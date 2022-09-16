
/*������� 1. �������� ��������� ���������������� �������: 
1. ���������������� ������� ���������� ����������� � ����� �Hello, ���!� ��� ��� ��������� � �������� ���������. 
��������, ���� �������� Nick, �� ����� Hello, Nick! 
2. ���������������� ������� ���������� ���������� � ������� ���������� ����� 
3. ���������������� ������� ���������� ���������� � ������� ���� 
4. ���������������� ������� ���������� ���������� � ���: ������ ��� �������� ��� 
5. ���������������� ������� ��������� ����� � ���������� yes, ���� ����� ������� � no, ���� ����� �� �������.  
6. ���������������� ������� ��������� � �������� ���������� ���� �����. ���������� ����� ������������ � ������������� �������� 
�� ���������� ���� ����������
7. ���������������� ������� ���������� ��� ������ ��� �������� ����� � ���������� ���������. 
������� ��������� ��� ���������: ������ ���������, ����� ���������, ��� ��� ����� ����������. */

use Sales_PZ_4;
go


--1. ���������������� ������� ���������� ����������� � ����� �Hello, ���!� ��� ��� ��������� � �������� ���������. 
--��������, ���� �������� Nick, �� ����� Hello, Nick! 

create function HelloMan(@Name nvarchar(20))
returns table
as
return select 'Hello, ' + @Name + '!' as [�����������];
go

--��������
select * from HelloMan('������');
go


--2. ���������������� ������� ���������� ���������� � ������� ���������� ����� 

create function HowIsMinute()
returns table
as
return select datename(minute, getdate()) as [������� ������];
go

--��������
select * from HowIsMinute();
go


--3. ���������������� ������� ���������� ���������� � ������� ���� 

create function WhatYearIsIt()
returns table
as
return select year(getdate()) as [������� ���];
go

--��������

select * from WhatYearIsIt();
go


--4. ���������������� ������� ���������� ���������� � ���: ������ ��� �������� ��� 

create function IsYearEvenOreOdd()
returns nvarchar(20)
as
begin
declare @Answer nvarchar(20)
if year(getdate())%2 = 0
set @Answer = '������ ���'
else
set @Answer = '�������� ���'
return @Answer 
end;
go

--��������

select dbo.IsYearEvenOreOdd();
go


--5. ���������������� ������� ��������� ����� � ���������� yes, ���� ����� ������� � no, ���� ����� �� �������.  

create function isNumberPrime(@Number int)
returns nvarchar(5)
as
begin
declare @Answer nvarchar(5), @iterator int = 2
if @Number<2										--������� ����� - ��� ����� ������������� �����, ������ 1, ���. ������� ������ �� 1 � �� ���� ����
begin 
	set @Answer = '���'
	goto Answer
end
while @iterator < @Number							--���� - ������ �� ������ �� 2 �� ���������� ����� @Number
begin
	if @Number%@iterator = 0						--�������� �� ������� ��� ������� ����� � ��������� �� ����� @Number; ���� ���� ���� �� ���� ����� �����,  
	begin											--�� @Number �� �������� �������
	set @Answer = '���'
	goto Answer
end
set @iterator += 1
end													--����� �����

set @Answer = '��'
Answer:
return @Answer
end;
go

--��������

select dbo.isNumberPrime(7) as [�������� �� ����� ������� ?];
go


--6. ���������������� ������� ��������� � �������� ���������� ���� �����. ���������� ����� ������������ � ������������� �������� 
--�� ���������� ���� ����������

create function sumMinAndMax(@Number1 int, @Number2 int, @Number3 int, @Number4 int, @Number5 int)
returns int
as
begin
declare @Sum int, @Max int, @Min int
declare @NumberArray table (Number int)		--������� ��������� ���������� @NumberArray, ���� ������� ��� 5 �������� ���������� - �����

insert into @NumberArray(Number) values (@Number1) 
insert into @NumberArray(Number) values (@Number2) 
insert into @NumberArray(Number) values (@Number3) 
insert into @NumberArray(Number) values (@Number4) 
insert into @NumberArray(Number) values (@Number5) 

set @Max = (select Max(Number) from @NumberArray)
set @Min = (select Min(Number) from @NumberArray)
set @Sum = @Max + @Min
return @Sum
end;
go


--��������

select dbo.sumMinAndMax(143, 1, 999, 254, -33) as [����� min � max];
go

--7. ���������������� ������� ���������� ��� ������ ��� �������� ����� � ���������� ���������. 
--������� ��������� ��� ���������: ������ ���������, ����� ���������, ��� ��� ����� ����������

create function IsNumberEvenOreOdd(@BeginRange int, @EndRange int, @isEvenOreOdd bit)
returns @NumbersTable table (Numbers int) 
as
begin
declare @iterator int
set @iterator = @BeginRange

if @isEvenOreOdd = 0
begin
	while @iterator <= @EndRange
	begin
		if @iterator%2!=0
		insert into @NumbersTable(Numbers) values(@iterator)
		set @iterator+=1
	end
end
if @isEvenOreOdd = 1
begin
	while @iterator <= @EndRange
	begin
		if @iterator%2=0
		insert into @NumbersTable(Numbers) values(@iterator)
		set @iterator+=1
	end
end
return 
end;
go

--��������
--0 - �������� �����
--1 - ������ �����

select Numbers as [�������� ������/�������� ����� � �������� ���������]
from IsNumberEvenOreOdd(35, 124, 0);
go


--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

create database Sales_PZ_4

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


/*������� 2. 
��� ���� ������ �������� �� ������������� ������� ������ ������� � ��������� � ��������������� � MS SQL Server� �������� ��������� ���������������� �������: 
1. ���������������� ������� ���������� ����������� ������� ����������� ��������. ��� �������� ��������� ��������� ��������� ���������������� ������� 
2. ���������������� ������� ���������� ����������� ������� ����������� ����������. ��� ���������� ��������� � �������� ��������� ���������������� ������� 
3. ���������������� ������� ���������� ����� ����� ������ �� ���������� ����. ���� ������� ��������� � �������� ��������� 
4. ���������������� ������� ���������� ����, ����� ����� ����� ������ �� ���� ���� ������������ 
5. ���������������� ������� ���������� ���������� ����� �������� ��������� ������. �������� ������ ��������� � �������� ��������� 
6. ���������������� ������� ���������� ���������� ����� ��������� ������������� 
7. ���������������� ������� ���������� ���������� ����� ����������� ������������� 
8. ���������������� ������� ���������� ���������� ����� ����������� � ��������� �������������.*/


--1. ���������������� ������� ���������� ����������� ������� ����������� ��������. ��� �������� ��������� ��������� ��������� ���������������� ������� 

create function minSalesOneSellers(@Name nvarchar(50), @Surname nvarchar(50))
returns table
as
return (select Min(Price) as [����������� �������]
	    from ProductSales join Sellers on Sellers.Id=ProductSales.SellersId
		group by Name, Surname
		having Name = @Name and Surname = @Surname);
go


--��������

select * from minSalesOneSellers('�����', '�������');
go


--2. ���������������� ������� ���������� ����������� ������� ����������� ����������. ��� ���������� ��������� � �������� ��������� ���������������� ������� 

create function minSalesOneBuyers(@Name nvarchar(50), @Surname nvarchar(50))
returns table
as
return (select Min(Price) as [����������� �������]
	    from ProductSales join Buyers on Buyers.Id=ProductSales.SellersId
		group by Name, Surname
		having Name = @Name and Surname = @Surname);
go


--��������

select * from minSalesOneBuyers('����', '��������');
go


--3. ���������������� ������� ���������� ����� ����� ������ �� ���������� ����. ���� ������� ��������� � �������� ��������� 

create function totalSalesOnDate(@dateSales date)
returns table
as
return (select Sum(Price) as [����� ����� ������ � ������ ����]
	    from ProductSales 
		group by DateSales
		having DateSales = @dateSales);
go


--��������

select * from totalSalesOnDate('2020-08-01');
go


--4. ���������������� ������� ���������� ����, ����� ����� ����� ������ �� ���� ���� ������������ 

create function getDateMaxSales()
returns table
as
return (select DateSales as [����], sum(Price) as [����� ����� ������ �� ����] 
		from ProductSales
		group by DateSales
		having sum(Price) >= all(select sum(Price) from ProductSales group by DateSales));
go


--��������

select * from getDateMaxSales();
go


--5. ���������������� ������� ���������� ���������� ����� �������� ��������� ������. �������� ������ ��������� � �������� ��������� 
--������� �������

insert into ProductSales(SellersId, BuyersId, NameSales, Price, DateSales)
values (1, 5, '�����', 63000, getdate());
go
insert into ProductSales(SellersId, BuyersId, NameSales, Price, DateSales)
values (5, 2, '�����', 46000, getdate());
go

--

create function infoAboutAllSalesOneProduct(@NameProductSales nvarchar(max))
returns table
as
return (select NameSales as [������������ ������], Price as [����], Buyers.Name +' ' +Buyers.Surname as [����������], Sellers.Name+ ' '+ Sellers.Surname as [��������], 
DateSales as [���� �������]
		from ProductSales join Buyers on Buyers.Id=ProductSales.BuyersId 
						  join Sellers on Sellers.Id=ProductSales.SellersId
		where NameSales = @NameProductSales);
go


--��������

select * from infoAboutAllSalesOneProduct('�����');
go

--6. ���������������� ������� ���������� ���������� ����� ��������� ������������� 
--������� �������

insert into Sellers(Name, Surname)
values ('�����', '��������');
go
insert into Sellers(Name, Surname)
values ('�����', '�������');
go
--


create function infoAboutSellersNameSakes()
returns table
as
return (select top(100) Name+' '+Surname as [�������� ������������]		--top(100) �����������, ����� ����� ���� ��������� order by
		from Sellers
		where Surname in (select Surname
						  from Sellers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name);
go

--��������

select * from infoAboutSellersNameSakes();
go


--7. ���������������� ������� ���������� ���������� ����� ����������� ������������� 
--������� �������

insert into Buyers(Name, Surname)
values ('������', '�������');
go
insert into Buyers(Name, Surname)
values ('������', '��������');
go
--

create function infoAboutBuyersNameSakes()
returns table
as
return (select top(100) Name+' '+Surname as [���������� ������������]		
		from Buyers
		where Surname in (select Surname
						  from Buyers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name);
go

--��������

select * from infoAboutBuyersNameSakes();
go


--8. ���������������� ������� ���������� ���������� ����� ����������� � ��������� �������������.

create function infoAboutAllBuyersAndSellersNameSakes()
returns table
as
return (select top(100) '��������' as [�������� ��� ����������], Name+' '+Surname as [������������]		
		from Sellers
		where Surname in (select Surname
						  from Sellers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name
		union all
		select top(100) '����������' as [�������� ��� ����������], Name+' '+Surname as [������������]		
		from Buyers
		where Surname in (select Surname
						  from Buyers 
						  group by Surname
						  having count(Surname) > 1)
		order by Surname, Name);
go

--��������

select * from infoAboutAllBuyersAndSellersNameSakes();
go

