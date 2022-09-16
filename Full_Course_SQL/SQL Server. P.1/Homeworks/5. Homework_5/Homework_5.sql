/*1. ������� ���������� �������������� ������� �Software Development�. */

select Departments.Name as [�������� �������], count (distinct Teachers.Name) as [���������� ��������������]
from Departments, Groups, GroupsLectures, Lectures, Teachers
where Teachers.Id=Lectures.TeacherId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId
group by Departments.Name
having Departments.Name='Department_of_software_development';


/*2. ������� ���������� ������, ������� ������ ������������� �Dave McQueen�. */

select Teachers.Name + ' ' + Teachers.Surname as [��� ��������������], COUNT(*) as [���������� ������]
from Teachers, Lectures
where Teachers.Id=Lectures.TeacherId
group by Teachers.Surname, Teachers.Name
having Teachers.Name='Dave' and Teachers.Surname='McQueen';


/*3. ������� ���������� �������, ���������� � ��������� �D201�. */

select Lectures.LectureRoom as [���������], count(Lectures.Id) as [���������� �������]
from Lectures
group by Lectures.LectureRoom
having Lectures.LectureRoom='d201';


/*4. ������� �������� ��������� � ���������� ������, ���������� � ���. */

select Lectures.LectureRoom as [���������], count(Lectures.Id) as [���������� �������]
from Lectures
group by Lectures.LectureRoom;


/*5. ������� ���������� ���������, ���������� ������ ������������� �Jack Underhill�. */

select Teachers.Name + ' ' + Teachers.Surname as [��� �������������], SUM(Groups.Number_of_students)
from Teachers, Lectures, Groups, GroupsLectures
where Teachers.Id=Lectures.TeacherId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId
group by Teachers.Surname, Teachers.Name
having Teachers.Name='Jack' and Teachers.Surname='Underhill';

/*6. ������� ������� ������ �������������� ���������� �Computer Science�. */

select Faculties.Name as [�������� ����������], AVG(distinct Teachers.Salary) as [������� �������� ��������������]
from Teachers, Lectures, GroupsLectures, Groups, Departments, Faculties
where Teachers.Id=Lectures.TeacherId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId and Faculties.Id=Departments.FacultyId
group by Faculties.Name
having Faculties.Name='Faculty_of_Computer_sciences';


/*7. ������� ����������� � ������������ ���������� ��������� ����� ���� �����. */

select Groups.Name as [���� ������], Groups.Number_of_students as [������������ / ����������� ���������� ���������] 
from Groups
group by Groups.Name, Groups.Number_of_students
having Groups.Number_of_students = (select MAX(Groups.Number_of_students) from Groups) 
or Groups.Number_of_students = (select MIN(Groups.Number_of_students) from Groups);

/*8. ������� ������� ���� �������������� ������. */

select avg(Departments.Financing) as [������� �������������� ������]
from Departments;


/*9. ������� ������ ����� �������������� � ���������� �������� ��� ���������. */

select Teachers.Name + ' ' +  Teachers.Surname as [��� ��������������], count(distinct Subjects.Id) as [���������� ���������]
from Teachers, Subjects, Lectures
where Teachers.Id=Lectures.TeacherId and Subjects.Id=Lectures.SubjectId
group by Teachers.Surname, Teachers.Name;


/*10. ������� ���������� ������ � ������ ���� ������. */

select Lectures.DayOfWeek as [���� ������], count(Lectures.Id) as [���������� ������]
from Lectures
group by Lectures.DayOfWeek;


/*11. ������� ������ ��������� � ���������� ������, ��� ������ � ��� ��������. */

select Lectures.LectureRoom as [����� ���������], count(distinct Departments.Id)
from Lectures, GroupsLectures, Groups, Departments
where Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId
group by Lectures.LectureRoom;

/*12. ������� �������� ����������� � ���������� ���������, ������� �� ��� ��������.*/

select Faculties.Name as [�������� ����������], count(distinct Subjects.Id) as [���������� ���������]
from Subjects, Lectures, GroupsLectures, Groups, Departments, Faculties
where Subjects.Id=Lectures.SubjectId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId and Faculties.Id=Departments.FacultyId
group by Faculties.Name;


/*13. ������� ���������� ������ ��� ������ ���� �������������-���������. */

select Teachers.Name + ' ' + Teachers.Surname as [��� ��������������], Lectures.LectureRoom as [����� ���������], 
count(Lectures.Id) as [���������� ������]
from Teachers, Lectures
where Teachers.Id=Lectures.TeacherId
group by Teachers.Surname, Teachers.Name, Lectures.LectureRoom;