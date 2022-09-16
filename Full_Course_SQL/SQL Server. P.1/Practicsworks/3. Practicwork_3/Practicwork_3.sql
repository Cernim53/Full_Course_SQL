/*1. ������� ���������� ������� �����. */

select *
from Wards;

/*����� ��������������� �����*/

select Wards.Name as [�������� ������], Wards.Building as [������], Wards.Floor as [����]
from Wards
order by Wards.Name;

/*2. ������� ������� � �������� ���� ������. */

select Doctors.Name+' '+Doctors.Surname as [��� �������], Doctors.Phone as [�������]
from Doctors
order by Doctors.Surname, Doctors.Name;


/*3. ������� ��� ����� ��� ����������, �� ������� ������������� ������. */

select Wards.Floor as [�����, �� ������� ������������� ������]
from Wards
group by Wards.Floor;

/*4. ������� �������� ����������� ��� ������ ��������� ������� � ������� �� ������� ��� ������ �������� ������� ������������. */

select Diseases.Name as [�������� �������], Diseases.Severity as [������� ������� �����������]
from Diseases
order by Diseases.Name, Diseases.Severity;


/*5. ������������ ��������� FROM ��� ����� ���� ������ ���� ������, ��������� ��� ��� ����������. */

select Doctors.Name+' '+Doctors.Surname as [��� �������]
from Doctors;

select Departments.Name as [���������], Wards.Name as [������]
from Departments, Wards
where   (Departments.Name like '%card%' and Wards.Name like 'Card%') or
		(Departments.Name like '%ther%' and Wards.Name like 'Ther%') or
		(Departments.Name like '%trau%' and Wards.Name like 'Trau%') or
		(Departments.Name like '%neur%' and Wards.Name like 'neur%');
		

/*6. ������� �������� ���������, ������������� � ������� 4 � ������� ���� �������������� ����� 30000. */

select Departments.Name as [�������� ���������], Departments.Building as [������], 
Departments.Financing as [���� ��������������] 
from Departments
where Departments.Building=4 and Departments.Financing < 30000
order by Departments.Name;


/*7. ������� �������� ���������, ������������� � 3-� ������� � ������ �������������� � ��������� �� 12000 �� 15000. */

select Departments.Name as [�������� ���������], Departments.Building as [������], 
Departments.Financing as [���� ��������������] 
from Departments
where Departments.Building=3 and Departments.Financing between 12000 and 15000
order by Departments.Name;


/*8. ������� �������� �����, ������������� � �������� 4 �5 �� 1-� �����. */

select Wards.Name as [�������� ������], Wards.Building as [������], Wards.Floor as [����]
from Wards
where Wards.Building in (4, 5) and Wards.Floor=1
order by Wards.Name;



/*9. ������� ��������, ������� � ����� �������������� ���������, ������������� � �������� 3 ��� 5 
� ������� ���� �������������� ������ 11000 ��� ������ 25000. */

select Departments.Name as [�������� ������], Departments.Building as [������], Departments.Financing as [���� ��������������]
from Departments
where Departments.Building in(3, 5) and Departments.Financing < 11000 or Departments.Financing > 25000
order by Departments.Name;


/*10. ������� ������� ������, ��� �������� (����� ������ ���������) ��������� 11500. */

select Doctors.Name+' '+Doctors.Surname as [��� �����], Doctors.Salary+Doctors.Premium as [��������]
from Doctors
where Doctors.Salary+Doctors.Premium > 11500
order by Doctors.Surname, Doctors.Name;


/*11. ������� ������� ������, � ������� �������� �������� ��������� ����������� ��������. */

select Doctors.Name+' '+Doctors.Surname as [��� �����], Doctors.Salary*0.5 as [�������� ��������], Doctors.Premium*3 as [����������� ��������]
from Doctors
where Doctors.Salary*0.5 > Doctors.Premium*3
order by Doctors.Surname, Doctors.Name;


/*12. ������� �������� ������������ ��� ����������, ���������� � ������ ��� ��� ������ � 12:00 �� 15:00. */

/*������� �� ������ ���������: ���������� �������� ������������ ����������, �.�. Examinations.Name - ��������� (�� �������� �������) 
������ ������������ ����� ���������� �������� - ��������: CT scan, CT scan_2, CT scan_3 � �.�. 
���� �� �������� ������������ ���� �� ������������, ����� ���� �� ������������  "group by Examinations.Name"  */

select Examinations.Name as [�������� ������������], Examinations.DayOfWeek as [���� ������], 
Examinations.StartTime as [������], Examinations.EndTime as [�����]
from Examinations
where Examinations.DayOfWeek in (1, 2, 3) and Examinations.StartTime between '12:00' and '15:00' 
order by Examinations.DayOfWeek, Examinations.StartTime, Examinations.Name;



/*13. ������� �������� � ������ �������� ���������, ������������� � �������� 1, 3, 8 ��� 10. */

select Departments.Name as [�������� ���������], Departments.Building as [������], Departments.Floor as [����]
from Departments
where Departments.Building in (1, 3, 8, 10)
order by Departments.Building, Departments.Floor, Departments.Name;


/*14. ������� �������� ����������� ���� �������� �������, ����� 1-� � 2-�. */

select Diseases.Name as [�������� �����������], Diseases.Severity as [������� ������� �����������]
from Diseases
where Diseases.Severity not in (1, 2)
order by Diseases.Name, Diseases.Severity;

/*15. ������� �������� ���������, ������� �� ������������� � 1-� ��� 3-� �������. */

select Departments.Name as [�������� ���������], Departments.Building as [������], Departments.Floor as [����]
from Departments
where Departments.Building not in (1, 3)
order by Departments.Building, Departments.Floor, Departments.Name;


/*16. ������� �������� ���������, ������� ������������� �1-� ��� 3-� �������. */

select Departments.Name as [�������� ���������], Departments.Building as [������], Departments.Floor as [����]
from Departments
where Departments.Building in (1, 3)
order by Departments.Building, Departments.Floor, Departments.Name;


/*17. ������� ������� ������, ������������ �� ����� �N�. */

select Doctors.Name+' '+Doctors.Surname as [��� �����]
from Doctors
where Doctors.Surname like 'N%'
order by Doctors.Surname, Doctors.Name;