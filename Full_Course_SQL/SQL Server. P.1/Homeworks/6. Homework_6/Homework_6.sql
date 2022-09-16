/*1. ������� ������ ��������, ���� ��������� ���� �������������� ������������� � ��� ������ ��������� 100000. */

select Departments.Building as [����� �������], sum(Departments.Financing)
as [��������� ���� �������������� ������]
from Departments
group by Departments.Building
having sum(Departments.Financing) in (select sum(Departments.Financing) 
									from Departments 
									group by Departments.Building 
									having sum(Departments.Financing) > 100000);


/*2. ������� �������� ����� 5-�� ����� ������� �Software Development�, ������� ����� ����� 8 ��� � ������ ������. */

select groups.Name as [���� ������], Departments.Name as [�������� �������], count(GroupsLecture.GroupId) as [���������� ���]
from Groups, Departments, Lectures, GroupsLecture
where Groups.Id=GroupsLecture.GroupId and Lectures.Id=GroupsLecture.LectureId and Departments.Id=Groups.DepartmentId
group by Groups.Name, Departments.Name, Groups.Year
having 8 < any (select count(GroupsLecture.GroupId) 
				from GroupsLecture 
				where Departments.Name='Department_of_Software_development' and Groups.Year=5);


/*3. ������� �������� �����, ������� ������� (������� ������� ���� ��������� ������) ������, ��� ������� ������ �Art_5�. */

select Groups.Name as [���� ������], avg(Students.Rating) as [������� ������]
from Groups, Students, GroupsStudents
where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId
group by Groups.Name
having avg(Students.Rating) > any (select avg(Students.Rating) 
									from Students, Groups, GroupsStudents
									where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId and Groups.Name='Art_5');


/*4. ������� ������� � ����� ��������������, ������ ������� ���� ������� ������ �����������. */

select Teachers.Name+' '+Teachers.Surname as [��� ��������������], Teachers.Salary as [������ ��������������], 
(select avg(Teachers.Salary) from Teachers group by Teachers.IsProfessor having Teachers.IsProfessor=1) as [������� ������ ����������]
from Teachers
group by Teachers.Name, Teachers.Surname, Teachers.Salary
having Teachers.Salary > (select avg(Teachers.Salary) from Teachers where Teachers.IsProfessor=1);


/*5. ������� �������� �����, � ������� ������ ������ ��������. */

select Groups.Name as [���� ������], count(GroupsCurators.GroupId) as [���������� ���������]
from Groups, GroupsCurators
where Groups.Id=GroupsCurators.GroupId
group by Groups.Name
having count(GroupsCurators.GroupId) in(select count(GroupsCurators.GroupId) 
										from Groups, GroupsCurators 
										where Groups.Id=GroupsCurators.GroupId
										group by Groups.Name
										having count(GroupsCurators.GroupId) > 1);


/*6. ������� �������� �����, ������� ������� (������� ������� ���� ��������� ������) ������, ��� ����������� ������� ����� 5-�� �����. */

select Groups.Name as [���� ������], avg(Students.Rating) as [������� ������]
from Groups, Students, GroupsStudents
where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId
group by Groups.Name
having avg(Students.Rating) < any (select avg(Students.Rating) 
									from Students, Groups, GroupsStudents 
									where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId and Groups.Year=5);


/*7. ������� �������� �����������, ��������� ���� �������������� ������ ������� ������ 
���������� ����� �������������� ������ ���������� �Computer Science�. */

select Faculties.Name as [�������� ����������], sum(Departments.Financing) as [��������� ���� �������������� ������]
from Faculties, Departments
where Faculties.Id=Departments.FacultyId
group by Faculties.Name
having sum(Departments.Financing) > (select sum(Departments.Financing) 
									from Faculties, Departments 
									where Faculties.Id=Departments.FacultyId
									group by Faculties.Name
									having Faculties.Name='Faculty_of_Computer_sciences');

/*8. ������� �������� ��������� � ������ ����� ��������������, �������� ���������� ���������� ������ �� ���. */

select Subjects.Name as [������� ����������], Teachers.Name+' '+Teachers.Surname as [��� ��������������],
count(Lectures.Id) as [���������� ������]
from Subjects, Lectures, Teachers
where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId
group by Subjects.Name, Teachers.Surname, Teachers.Name
having count(Lectures.Id) >= all(select count(Lectures.Id)
						from Lectures, Subjects, Teachers 
						where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId 
						group by Subjects.Name);


/*9. ������� �������� ����������, �� �������� �������� ������ ����� ������. */

select Subjects.Name as [������� ����������], Teachers.Name+' '+Teachers.Surname as [��� ��������������],
count(Lectures.Id) as [���������� ������]
from Subjects, Lectures, Teachers
where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId
group by Subjects.Name, Teachers.Surname, Teachers.Name
having count(Lectures.Id) <= all(select count(Lectures.Id)
						from Lectures, Subjects, Teachers 
						where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId 
						group by Subjects.Name);



/*10. ������� ���������� ��������� � �������� ��������� �� ������� �Software Development�.*/

select Departments.Name as [�������� �������], count(distinct Students.Id) as [���������� ���������], 
count(distinct Subjects.Id) as [���������� ������� ��������]
from Departments, Groups, GroupsStudents, Students, GroupsLecture, Lectures, Subjects
where Departments.Id=Groups.DepartmentId and Groups.Id=GroupsLecture.GroupId and Lectures.Id=GroupsLecture.LectureId and Subjects.Id=Lectures.SubjectId
and Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId
group by Departments.Name
having Departments.Name in (select Departments.Name from Departments where Departments.Name ='Department_of_Software_development');