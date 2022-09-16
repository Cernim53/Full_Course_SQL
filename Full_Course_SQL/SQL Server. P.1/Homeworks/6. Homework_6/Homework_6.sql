/*1. Вывести номера корпусов, если суммарный фонд финансирования расположенных в них кафедр превышает 100000. */

select Departments.Building as [Номер корпуса], sum(Departments.Financing)
as [Суммарный фонд финансирования кафедр]
from Departments
group by Departments.Building
having sum(Departments.Financing) in (select sum(Departments.Financing) 
									from Departments 
									group by Departments.Building 
									having sum(Departments.Financing) > 100000);


/*2. Вывести названия групп 5-го курса кафедры “Software Development”, которые имеют более 8 пар в первую неделю. */

select groups.Name as [Шифр группы], Departments.Name as [Название кафедры], count(GroupsLecture.GroupId) as [Количество пар]
from Groups, Departments, Lectures, GroupsLecture
where Groups.Id=GroupsLecture.GroupId and Lectures.Id=GroupsLecture.LectureId and Departments.Id=Groups.DepartmentId
group by Groups.Name, Departments.Name, Groups.Year
having 8 < any (select count(GroupsLecture.GroupId) 
				from GroupsLecture 
				where Departments.Name='Department_of_Software_development' and Groups.Year=5);


/*3. Вывести названия групп, имеющих рейтинг (средний рейтинг всех студентов группы) больше, чем рейтинг группы “Art_5”. */

select Groups.Name as [Шифр группы], avg(Students.Rating) as [Рейтинг группы]
from Groups, Students, GroupsStudents
where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId
group by Groups.Name
having avg(Students.Rating) > any (select avg(Students.Rating) 
									from Students, Groups, GroupsStudents
									where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId and Groups.Name='Art_5');


/*4. Вывести фамилии и имена преподавателей, ставка которых выше средней ставки профессоров. */

select Teachers.Name+' '+Teachers.Surname as [ФИО преподавателей], Teachers.Salary as [Ставки прнподавателей], 
(select avg(Teachers.Salary) from Teachers group by Teachers.IsProfessor having Teachers.IsProfessor=1) as [Средняя ставка профессора]
from Teachers
group by Teachers.Name, Teachers.Surname, Teachers.Salary
having Teachers.Salary > (select avg(Teachers.Salary) from Teachers where Teachers.IsProfessor=1);


/*5. Вывести названия групп, у которых больше одного куратора. */

select Groups.Name as [Шифр группы], count(GroupsCurators.GroupId) as [Количество кураторов]
from Groups, GroupsCurators
where Groups.Id=GroupsCurators.GroupId
group by Groups.Name
having count(GroupsCurators.GroupId) in(select count(GroupsCurators.GroupId) 
										from Groups, GroupsCurators 
										where Groups.Id=GroupsCurators.GroupId
										group by Groups.Name
										having count(GroupsCurators.GroupId) > 1);


/*6. Вывести названия групп, имеющих рейтинг (средний рейтинг всех студентов группы) меньше, чем минимальный рейтинг групп 5-го курса. */

select Groups.Name as [Шифр группы], avg(Students.Rating) as [Рейтинг группы]
from Groups, Students, GroupsStudents
where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId
group by Groups.Name
having avg(Students.Rating) < any (select avg(Students.Rating) 
									from Students, Groups, GroupsStudents 
									where Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId and Groups.Year=5);


/*7. Вывести названия факультетов, суммарный фонд финансирования кафедр которых больше 
суммарного фонда финансирования кафедр факультета “Computer Science”. */

select Faculties.Name as [Название факультета], sum(Departments.Financing) as [Суммарный фонж финансирования кафедр]
from Faculties, Departments
where Faculties.Id=Departments.FacultyId
group by Faculties.Name
having sum(Departments.Financing) > (select sum(Departments.Financing) 
									from Faculties, Departments 
									where Faculties.Id=Departments.FacultyId
									group by Faculties.Name
									having Faculties.Name='Faculty_of_Computer_sciences');

/*8. Вывести названия дисциплин и полные имена преподавателей, читающих наибольшее количество лекций по ним. */

select Subjects.Name as [Учебные дисциплины], Teachers.Name+' '+Teachers.Surname as [ФИО преподавателей],
count(Lectures.Id) as [Количество лекций]
from Subjects, Lectures, Teachers
where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId
group by Subjects.Name, Teachers.Surname, Teachers.Name
having count(Lectures.Id) >= all(select count(Lectures.Id)
						from Lectures, Subjects, Teachers 
						where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId 
						group by Subjects.Name);


/*9. Вывести название дисциплины, по которому читается меньше всего лекций. */

select Subjects.Name as [Учебные дисциплины], Teachers.Name+' '+Teachers.Surname as [ФИО преподавателей],
count(Lectures.Id) as [Количество лекций]
from Subjects, Lectures, Teachers
where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId
group by Subjects.Name, Teachers.Surname, Teachers.Name
having count(Lectures.Id) <= all(select count(Lectures.Id)
						from Lectures, Subjects, Teachers 
						where Subjects.Id=Lectures.SubjectId and Teachers.Id=Lectures.TeacherId 
						group by Subjects.Name);



/*10. Вывести количество студентов и читаемых дисциплин на кафедре “Software Development”.*/

select Departments.Name as [Название кафедры], count(distinct Students.Id) as [Количество студентов], 
count(distinct Subjects.Id) as [Количество учебных дисиплин]
from Departments, Groups, GroupsStudents, Students, GroupsLecture, Lectures, Subjects
where Departments.Id=Groups.DepartmentId and Groups.Id=GroupsLecture.GroupId and Lectures.Id=GroupsLecture.LectureId and Subjects.Id=Lectures.SubjectId
and Groups.Id=GroupsStudents.GroupId and Students.Id=GroupsStudents.StudentId
group by Departments.Name
having Departments.Name in (select Departments.Name from Departments where Departments.Name ='Department_of_Software_development');