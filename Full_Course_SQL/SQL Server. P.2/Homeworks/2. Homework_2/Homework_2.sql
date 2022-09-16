--�������� �������

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

--�������� ������� �������

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
� ���� ������ ����������� ������� �� ������������� ������� � ����� ������ �������� ��������� ��������: 
1. ��� ���������� ������ ������ ������� ��������� ��� ������� �� ������, ���� ����� ����� ���� 
� ����� ������ � ������ ��������� � ��� ������������� �������, ������ ���������� ���������� 
���������� ���������� � ���������� ������ 
2. ��� ���������� ���������� ������� ��������� ���������� �� ��������� ���������� � ������� ������ ����������� 
3. ������� ��������� ��������� ������ ��������, ���� ���������� ������������ ��������� ������ 6. */



--1. ��� ���������� ������ ������ ������� ��������� ��� ������� �� ������, ���� ����� ����� ���� � ����� ������ � ������ ��������� 
--� ��� ������������� �������, ������ ���������� ���������� ���������� ���������� � ���������� ������ 

create trigger "�������� ��� ������� ���������. ���������� ����� ������ ��� ���������� ��������"
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

print'���������� ������� '+ @Name + ' �� ������ ����������� �� '+ convert(nvarchar(10), @StockNumberOld) + ' �� ' + convert(nvarchar(10), @StockNumberOld + @StockNumberNew) + ' ����'
end
else
begin
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId)
values (@Name, @TypeProductId, @StockNumberNew, @Price, @ManufacturerId)
print'�������� ����� ����� '+ @Name + ' � ���������� ' + convert(nvarchar(10), @StockNumberNew) + ' ����, �� ���� ' + convert(nvarchar(10), @Price) + ' ������ �� �����'
end
end;
go

--��������
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId)
values ('��������', 1, 32, 1670, 1)

select * from Products

-- �
insert into Products(Name, TypeProductId, StockNumber, Price, ManufacturerId)
values ('Spart', 7, 12, 530, 3)

select * from Products



--2. ��� ���������� ���������� ������� ��������� ���������� �� ��������� ���������� � ������� ������ ����������� 

--�������� ������� ArchiveEmployees, � ������� ������� ��� ������ �� ��������� ����������� + ���� ����������

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

--�������� �������

create trigger "��������� ���������� �� ��������� ����������� � ������ �����������"
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

--��������, ���� �� ����� ���������
if not exists (select * from Employees where Name = @Name and Surname = @Surname)
print'������ ��������� � ������ ���!'
else
begin
insert into ArchiveEmployees(Name, Surname, PositionId, RecruitmentDate, DismissalDate, GenderId, Salary)
values (@Name, @Surname, @PositionId, @RecruitmentDate, default, @GenderId, @Salary)
print'���������� �� ��������� ���������� ������� ��������� � ������� ArchiveEmployees'
print'@Name = '+@Name+' @Surname = '+@Surname+' @PositionId = '+ convert(nvarchar(10), @PositionId)+' @RecruitmentDate = '
+ convert(nvarchar(10), @RecruitmentDate)+' @GenderId = '+ convert(nvarchar(10), @GenderId) + ' @Salary = '+ convert(nvarchar(10), @Salary)

delete from Employees
where Name = @Name and Surname = @Surname
print'���������� �� ��������� ���������� ������� ������� �� ������� Employees'
end
end;
go

--��������

delete from Employees
where Name = '�����' and Surname = '������'
go

select * from Employees
go
select * from ArchiveEmployees
go


--3. ������� ��������� ��������� ������ ��������, ���� ���������� ������������ ��������� ������ 6.

create trigger "��������� �� ������ 6 ���������"
on Employees
instead of insert
as
begin
declare @Count int, @Name nvarchar(50), @Surname nvarchar(50), @PositionId int, @GenderId int , @Salary money
select @Count = (select count(Id) from Employees)
select @Name = Name, @Surname = Surname, @PositionId = PositionId, @GenderId = GenderId , @Salary = Salary
from inserted

if @Count > 6
print'�� �� ������ �������� ������ ��������. ����������� - ������������ ��������� ��� ������ 6'
else
begin
insert into Employees(Name, Surname, PositionId, RecruitmentDate, GenderId, Salary)
values(@Name, @Surname, @PositionId, getdate(), @GenderId, @Salary)
print'�� �������� ������ ��������'
end
end;
go

--��������

insert into Employees(Name, Surname, PositionId, GenderId, Salary)
values('�������', '���������', 1, 2, 1200)
go

select * from Employees
go

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--�������� �������

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

--�������� ������� �������

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
� ���� ������ ������������ ���������� �� ������������� ������� ������ ������� � ��������� � ��������������� � MS SQL Server� 
�������� ��������� ��������: 
1. ������� �� ����������� �������� ��� ������������ ���������� ������
2. ������� �� ����������� ������� ����� ������ ��������
3. ��� �������� ����� ������� ��������� ���������� �� ��������� ����� � ������� ������ 
4. ������� �� ����������� ��������� � ��������� ����� ������������ ����� �Dark Power Pop�. */


--1. ������� �� ����������� �������� ��� ������������ ���������� ������

create trigger "������ ��������� ������������ � ��������� ������"
on Discs
instead of insert
as
begin

declare @Name nvarchar(50), @ReleaseDate date, @DurationDisc time, @NumberSongs int, @StylesId int, @ArtistsId int, @PublishersId int

select @Name = Name, @ReleaseDate = ReleaseDate, @DurationDisc = DurationDisc, @NumberSongs = NumberSongs, @StylesId = StylesId, 
@ArtistsId = ArtistsId, @PublishersId = PublishersId
from inserted

if @Name in (select Name from Discs)
print'������� ���������! ����� ������ ��� ���������� � ���������'
else
begin
insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values (@Name, @ReleaseDate, @DurationDisc, @NumberSongs, @StylesId, @ArtistsId, @PublishersId)
print'������� ������� ������������!'
end
end;
go

--��������

insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values ('��� ���', '2016-05-19', '00:51:25', 11, 5, 3, 3)
go

insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values ('Dont Happyend', '2014-09-19', '00:43:20', 15, 7, 3, 3)
go

select * from Discs
go

--2. ������� �� ����������� ������� ����� ������ ��������

create trigger "������ ������� ����� ������ ��������"
on Discs
instead of delete
as
begin

declare @ArtistId int
select @ArtistId = ArtistsId
from deleted

if @ArtistId = (select Id from Artists where Name = '�����' and Surname = '�������')
print'�������� ���������! ����� ������ �������� ������� ������!'
else
begin
delete from Discs
where ArtistsId = @ArtistId 
print'�������� ������� �����������!'
end

end;
go

--��������

delete from Discs
where ArtistsId = 1; 
go

select * from Discs
go

--3. ��� �������� ����� ������� ��������� ���������� �� ��������� ����� � ������� ������ 

--�������� ������� "����� ������"
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

--������ ������� "������ ������� ����� ������ ��������"

drop trigger "������ ������� ����� ������ ��������"
on database;
go

--�������� ��� �������

create trigger "���������� ���������� �� ��������� ������ � ������ ������"
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
print'���������� �� ��������� ������� ��������� � ������� ArchivDiscs'
delete from Discs
where Name = @Name; 
print'������ ������� ������'
end
else
print'������� �������� ������� �� ��������'
end;
go


--��������

delete from Discs
where Name = 'Dangerous'; 
go

select * from Discs;
go

select * from ArchivDiscs;
go


--4. ������� �� ����������� ��������� � ��������� ����� ������������ ����� �Dark Power Pop�. 

--������ ������� "������ ��������� ������������ � ��������� ������"
drop trigger "������ ��������� ������������ � ��������� ������"
on database;
go

--�������� ����� �������

create trigger "������ ��������� � ��������� ������� ������������ ����� Dark Power Pop"
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
print'������� ���������! ����� � ����������� ������ Dark Power Pop ��������� ���������  � ���������'
else
begin
insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values (@Name, @ReleaseDate, @DurationDisc, @NumberSongs, @StylesId, @ArtistsId, @PublishersId)
print'������� ������� ������������!'
end
end;
go

--��������

insert into Discs(Name, ReleaseDate, DurationDisc, NumberSongs, StylesId, ArtistsId, PublishersId)
values ('Dont Happyend', '2014-09-19', '00:43:20', 15, 7, 3, 3)
go

select * from Discs
go

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--�������� ���� ������ Sales_HW_2 � �������

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

--�������� �� �������

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
					( 5, 5, '���������', 8000, '2019-02-07');
go



/*������� 3. 
� ���� ������ �������� �� ������������� ������� ������ ������� � ��������� � ��������������� � MS SQL Server� 
�������� ��������� ��������: 
1. ��� ���������� ������ ���������� ������� ��������� ������� ����������� � ����� �� ��������. ��� ���������� ���������� 
������� ���������� �� ���� ���������� � ����������� ������� 
2. ��� �������� ���������� � ���������� ������� ��������� ��� ������� ������� � ������� �������� ������� 
3. ��� ���������� �������� ������� ��������� ���� �� �� � ������� ���������, ���� ������ ���������� ���������� ������ �������� ���������� 
4. ��� ���������� ���������� ������� ��������� ���� �� �� � ������� �����������, ���� ������ ���������� ���������� ������ ���������� ���������� 
5. ������� �� ��������� ��������� ���������� � ������� ����� �������: ������, �����, �����, �����.*/


--1. ��� ���������� ������ ���������� ������� ��������� ������� ����������� � ����� �� ��������. ��� ���������� ���������� 
--������� ���������� �� ���� ���������� � ����������� ������� 

--��������� ������� NamesakersBuyers

create table NamesakersBuyers
(
Id int identity(1,1) not null primary key,
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
Mail nvarchar(100) null,
Fone nvarchar(20) null,
);
go

--�������� ��� �������

create trigger "�������� ������ ���������� ��� �������"
on Buyers
instead of insert
as
begin

declare @Name nvarchar(50), @Surname nvarchar(50), @Mail nvarchar(100), @Fone nvarchar(20)
select @Name = Name, @Surname = Surname, @Mail = Mail, @Fone = Fone
from inserted

if @Surname in (select Surname from Buyers)
begin
print'��������� ���������� - �����������'
insert into NamesakersBuyers (Name, Surname, Mail, Fone)
values (@Name, @Surname, @Mail, @Fone)
print'����� ����������- ����������� ������� � ������� NamesakersBuyers'
insert into Buyers (Name, Surname, Mail, Fone)
values (@Name, @Surname, @Mail, @Fone)
return
end
else
begin
print'����� ���������� ����� ���������� �������'
insert into Buyers (Name, Surname, Mail, Fone)
values (@Name, @Surname, @Mail, @Fone)
end
end;
go

--��������

insert into Buyers(Name, Surname, Mail, Fone)
values ('�����', '��������', 'MariyaCro@gmail.com', '25-24-51');
go

select * from Buyers;
go

select * from NamesakersBuyers;
go

--������������ �������� ��������

disable trigger "�������� ������ ���������� ��� �������"
on Buyers;
go


--2. ��� �������� ���������� � ���������� ������� ��������� ��� ������� ������� � ������� �������� ������� 

--�������� �������� ������� HistoryOfSales

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

--��������� ��� �������

create trigger "���������� ������� ������� ��� �������� ����������"
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

print'@SellersId = ' + convert(nvarchar(50), @SellersId)									--��������
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

print '���������� �� ������� ������� ���������� ���������� ��������� � ������� HistoruOfSales'
delete from Buyers
where Name = @Name and Surname=@Surname
print '�������� ������ �������!'
end
else
begin
print '������� ����������! ������ ���������� � ������ ���'
end
end;
go


--��������

delete from Buyers
where Name = '�����' and Surname = '�������';
go

select * from Buyers;
go

select * from ProductSales;
go

select * from HistoryOfSales;
go


--3. ��� ���������� �������� ������� ��������� ���� �� �� � ������� ���������, ���� ������ ���������� ���������� ������ �������� ���������� 

create trigger "�������� ��������� �� ������������� ��� �������"
on Buyers
instead of insert
as
begin

declare @Name nvarchar(50), @Surname nvarchar(50)
select @Name = Name, @Surname = Surname
from inserted

if exists (select * from Buyers where Name = @Name and Surname = @Surname)
print'������� �� ��������! ����� �������� ��� ����������!'
else
begin
insert into Buyers (Name, Surname)
values (@Name, @Surname)
print '������� ������ ������� ������ �������!'
end
end;
go

--��������

insert into Buyers (Name, Surname)
values ('��������', '��������');
go

select * from Buyers;
go

--4. ��� ���������� ���������� ������� ��������� ���� �� �� � ������� �����������, ���� ������ ���������� ���������� ������ ���������� ���������� 

create trigger "�������� ����������� �� ������������� ��� �������"
on Sellers
instead of insert
as
begin

declare @Name nvarchar(50), @Surname nvarchar (50)
select @Name = Name, @Surname = Surname
from inserted
if exists (select * from Sellers where Name = @Name and Surname = @Surname)
print'������� �� ��������! ����� ���������� ��� ����������!'
else
begin
insert into Sellers(Name, Surname)
values (@Name, @Surname)
print '������� ������ ���������� ������ �������!'
end

end;
go

--��������

insert into Sellers(Name, Surname)
values ('������', '�������');
go

select * from Sellers;
go



--5. ������� �� ��������� ��������� ���������� � ������� ����� �������: ������, �����, �����, �����.

create trigger "������ �� ������� �����, ����, ����, �����"
on ProductSales
instead of insert
as
begin

declare @NameSales nvarchar(MAX), @SellersId int, @BuyersId int, @Price money, @DateSales date
select @NameSales = NameSales, @SellersId = SellersId, @BuyersId = BuyersId, @Price = Price, @DateSales = DateSales
from inserted
if @NameSales in ('������', '������', '�����', '�����', '�����', '�����', '�����')
print'��������� ��������� ����� ��������: ������, �����, �����, �����'
else
begin
insert into ProductSales (NameSales, SellersId, BuyersId, Price, DateSales)
values (@NameSales, @SellersId, @BuyersId, @Price, @DateSales);
print'������� ' + convert(nvarchar(50), @NameSales) + ' ������� �������� � ������� ProductSales!'
end

end;
go

--��������

insert into ProductSales (NameSales, SellersId, BuyersId, Price, DateSales)
values ('�����', 1, 2, 50, getdate());
go

select * from ProductSales;
go