/*1. ������� ���������� �����, ����������� ������� ������ 10. */

select '���������� �����, ��� ������ 15 ����', count(Wards.Id) 
from Wards
where Wards.Places>15;


/*2. ������� �������� �������� � ���������� ����� � ������ �� ���. */

select Departments.Building as [����� �������], count(Wards.Id) as [���������� �����]
from Departments, Wards
where Departments.Id=Wards.DepartmentId
group by Departments.Building;



/*3. ������� �������� ��������� � ���������� ����� � ������ �� ���. */

select Departments.Name as [�������� ���������], count(Wards.Id) as [���������� �����]
from Departments, Wards
where Departments.Id=Wards.DepartmentId
group by Departments.Name;


/*4. ������� �������� ��������� � ��������� �������� ������ � ������ �� ���. */

select Departments.Name as [�������� ���������], sum(distinct Doctors.Premium) as [��������� �������� ������]
from Departments, Wards, DoctorsExaminations, Doctors
where Departments.Id=Wards.DepartmentId and Wards.Id=DoctorsExaminations.WardId and Doctors.Id=DoctorsExaminations.DoctorId
group by Departments.Name;



/*5. ������� �������� ���������, � ������� �������� ������������ 5 � ����� ������. */

select Departments.Name as [�������� ���������], count(distinct Doctors.Id) as [���������� ������]
from Departments, Wards, DoctorsExaminations, Doctors
where Departments.Id=Wards.DepartmentId and Wards.Id=DoctorsExaminations.WardId and Doctors.Id=DoctorsExaminations.DoctorId
group by Departments.Name
having count(distinct Doctors.Id) >= 5;


/*6. ������� ���������� ������ � �� ��������� �������� (����� ������ � ��������). */

select '���������� ������', convert(nvarchar(10), count(Doctors.Id)) + '  ���'
from Doctors
union all
select '��������� ��������', convert(nvarchar(10), sum(Doctors.Salary+Doctors.Premium)) + '  ���'
from Doctors;


/*7. ������� ������� �������� (����� ������ � ��������) ������. */

select '������� �������� ������', convert(nvarchar(10), avg(Doctors.Salary+Doctors.Premium)) + '  ���'
from Doctors;


/*8. ������� �������� ����� � ����������� ����������������. */

select Wards.Name as [�������� �����], min(Wards.Places) as [���������� ����]
from Wards
group by Wards.Name, Wards.Places
having Wards.Places = (select min(Wards.Places) from Wards)
order by Wards.Name;


/*9. ������� � ����� �� �������� 1, 3, 4 � 5, ��������� ���������� ���� � ������� ��������� 40. 
��� ���� ��������� ������ ������ � ����������� ���� ������ 15.*/

select Departments.Building as [����� �������], sum(Wards.Places) as [���������� ���� � �������]
from Departments, Wards
where Departments.Id=Wards.DepartmentId and Wards.Places > 15 and Departments.Building in(1, 3, 4, 5)
group by Departments.Building
having sum(Wards.Places) > 40;