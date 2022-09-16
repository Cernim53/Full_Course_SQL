/*1. ������� �������� ���������, � ������� ������ ������ ������������� "����� �������".*/

select Teachers.Name+' '+Teachers.Surname as [��� �������������], LectureRooms.Name as [���������]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId 
			  join Schedules on Lectures.Id=Schedules.LectureId 
			  join LectureRooms on LectureRooms.Id=Schedules.LectureRoomId
where Teachers.Name='�����' and Teachers.Surname = '�������'
group by Teachers.Surname, Teachers.Name, LectureRooms.Name;


/*2. ������� ������� �����������, �������� ������ � ������ "Comp_5".*/

select Teachers.Name+' '+Teachers.Surname as [��� �������������], Groups.Name as [������], Subjects.Name as [��������, ������� ��������]
from Teachers join Assistants on Teachers.Id=Assistants.TeacherId
			  join Lectures on Teachers.Id=Lectures.TeacherId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Subjects on Subjects.Id=Lectures.SubjectId
where Groups.Name='Comp_5'
group by Subjects.Name, Teachers.Name, Teachers.Surname, Groups.Name;


/*3. ������� ����������, ������� ������ ������������� "����� �������" ��� ����� 5-�� �����.*/

select Teachers.Name+' '+Teachers.Surname as [��� �������������], Groups.Name as [������], Groups.Year as [����], Subjects.Name as [��������, ������� ��������]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Subjects on Subjects.Id=Lectures.SubjectId
where Teachers.Name='�����' and Teachers.Surname='�������' and Groups.Year=5
group by Subjects.Name, Teachers.Name, Teachers.Surname, Groups.Name, Groups.Year;



/*4. ������� ������� ��������������, ������� �� ������ ������ �� �������������.*/

select Teachers.Name+' '+Teachers.Surname as [��� �������������]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId
			  join Schedules on Lectures.Id=Schedules.LectureId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Subjects on Subjects.Id=Lectures.SubjectId
where  Teachers.Surname not in (select Teachers.Surname 
								from Teachers join Lectures on Teachers.Id=Lectures.TeacherId
											  join Schedules on Lectures.Id=Schedules.LectureId
								where Schedules.DayOfWeek = 1)
group by Teachers.Name, Teachers.Surname;



/*5. ������� �������� ���������, � ��������� �� ��������, � ������� ��� ������ � ����� ������ ������ �� ������� ����.*/

select LectureRooms.Name as [���������], LectureRooms.Building as [������]
from LectureRooms join Schedules on LectureRooms.Id=Schedules.LectureRoomId
where LectureRooms.id not in (select LectureRooms.Id
						  from LectureRooms join Schedules on LectureRooms.Id=Schedules.LectureRoomId
						  where Schedules.Week=1 and Schedules.DayOfWeek=3 and Schedules.Class=3)
group by LectureRooms.Name, LectureRooms.Building;



/*6. ������� ������ ����� �������������� ���������� "��������� ������������ ����", ������� �� �������� ������ ������� "������� WEB ����������".*/

select Teachers.Name+' '+Teachers.Surname as [��� ��������������], Faculties.Name as [���������]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Departments on Departments.Id=Groups.DepartmentId
			  join Faculties on Faculties.Id=Departments.FacultyId
where Faculties.Name='��������� ������������ ����' and Teachers.Id not in (select Teachers.Id 
																		   from Teachers join Curators on Teachers.Id=Curators.TeacherId
																						 join GroupsCurators on Curators.Id=GroupsCurators.CuratorId
																						 join Groups on Groups.Id=GroupsCurators.GroupId
																						 join Departments on Departments.Id=Groups.DepartmentId
																		   where Departments.Name='������� WEB ����������')
group by Teachers.Surname, Teachers.Name, Faculties.Name
order by Teachers.Surname;


/*7. ������� ������ ������� ���� ��������, ������� ������� � �������� �����������, ������ � ���������.*/

select '������� �����������', Faculties.Building
from Faculties
union
select '������� ������', Departments.Building
from Departments
union
select '������� ���������', LectureRooms.Building
from LectureRooms;

/*8. ������� ������ ����� �������������� � ��������� �������: ������ �����������, ���������� ���������, �������������, ��������, ����������.*/

select '����� ����������', Teachers.Name+' '+Teachers.Surname
from Teachers join Deans on Teachers.Id=Deans.TeacherId
union all
select '���������� �������', Teachers.Name+' '+Teachers.Surname
from Teachers join Heads on Teachers.Id=Heads.TeacherId
union all
select '�������������', Teachers.Name+' '+Teachers.Surname
from Teachers 
where Teachers.Id not in (select Teachers.Id 
						  from Teachers join Deans on Teachers.Id=Deans.TeacherId)
and Teachers.Id not in	 (select Teachers.Id 
						  from Teachers join Heads on Teachers.Id=Heads.TeacherId)
and Teachers.Id not in	 (select Teachers.Id 
						  from Teachers join Curators on Teachers.id=Curators.TeacherId)
and Teachers.Id not in	 (select Teachers.Id 
						  from Teachers join Assistants on Teachers.Id=Assistants.TeacherId)
union all
select '�������', Teachers.Name+' '+Teachers.Surname
from Teachers join Curators on Teachers.Id=Curators.TeacherId
union all
select '���������', Teachers.Name+' '+Teachers.Surname
from Teachers join Assistants on Teachers.Id=Assistants.TeacherId


/*9. ������� ��� ������ (��� ����������), � ������� ������� ������� � ���������� "A311" � "A104" ������� 1.*/

select Schedules.DayOfWeek as [���� ������], LectureRooms.Building as [������] --, LectureRooms.Name as [���������]
from Schedules join LectureRooms on LectureRooms.Id=Schedules.LectureRoomId
where LectureRooms.Name = 'A311' 
union
select Schedules.DayOfWeek as [���� ������], LectureRooms.Building as [������] --, LectureRooms.Name as [���������]
from Schedules join LectureRooms on LectureRooms.Id=Schedules.LectureRoomId
where LectureRooms.Name ='A104';

