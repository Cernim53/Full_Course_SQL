/*1. Вывести количество преподавателей кафедры “Software Development”. */

select Departments.Name as [Название кафедры], count (distinct Teachers.Name) as [Количество преподавателей]
from Departments, Groups, GroupsLectures, Lectures, Teachers
where Teachers.Id=Lectures.TeacherId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId
group by Departments.Name
having Departments.Name='Department_of_software_development';


/*2. Вывести количество лекций, которые читает преподаватель “Dave McQueen”. */

select Teachers.Name + ' ' + Teachers.Surname as [ФИО преподавателей], COUNT(*) as [Количество лекций]
from Teachers, Lectures
where Teachers.Id=Lectures.TeacherId
group by Teachers.Surname, Teachers.Name
having Teachers.Name='Dave' and Teachers.Surname='McQueen';


/*3. Вывести количество занятий, проводимых в аудитории “D201”. */

select Lectures.LectureRoom as [Аудитория], count(Lectures.Id) as [Количество занятий]
from Lectures
group by Lectures.LectureRoom
having Lectures.LectureRoom='d201';


/*4. Вывести названия аудиторий и количество лекций, проводимых в них. */

select Lectures.LectureRoom as [Аудитория], count(Lectures.Id) as [Количество занятий]
from Lectures
group by Lectures.LectureRoom;


/*5. Вывести количество студентов, посещающих лекции преподавателя “Jack Underhill”. */

select Teachers.Name + ' ' + Teachers.Surname as [ФИО преподавателя], SUM(Groups.Number_of_students)
from Teachers, Lectures, Groups, GroupsLectures
where Teachers.Id=Lectures.TeacherId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId
group by Teachers.Surname, Teachers.Name
having Teachers.Name='Jack' and Teachers.Surname='Underhill';

/*6. Вывести среднюю ставку преподавателей факультета “Computer Science”. */

select Faculties.Name as [Название факультета], AVG(distinct Teachers.Salary) as [Средняя зарплата преподавателей]
from Teachers, Lectures, GroupsLectures, Groups, Departments, Faculties
where Teachers.Id=Lectures.TeacherId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId and Faculties.Id=Departments.FacultyId
group by Faculties.Name
having Faculties.Name='Faculty_of_Computer_sciences';


/*7. Вывести минимальное и максимальное количество студентов среди всех групп. */

select Groups.Name as [Шифр группы], Groups.Number_of_students as [Максимальное / минимальное количество студентов] 
from Groups
group by Groups.Name, Groups.Number_of_students
having Groups.Number_of_students = (select MAX(Groups.Number_of_students) from Groups) 
or Groups.Number_of_students = (select MIN(Groups.Number_of_students) from Groups);

/*8. Вывести средний фонд финансирования кафедр. */

select avg(Departments.Financing) as [Среднее финанстрование кафедр]
from Departments;


/*9. Вывести полные имена преподавателей и количество читаемых ими дисциплин. */

select Teachers.Name + ' ' +  Teachers.Surname as [ФИО преподавателей], count(distinct Subjects.Id) as [Количество дисциплин]
from Teachers, Subjects, Lectures
where Teachers.Id=Lectures.TeacherId and Subjects.Id=Lectures.SubjectId
group by Teachers.Surname, Teachers.Name;


/*10. Вывести количество лекций в каждый день недели. */

select Lectures.DayOfWeek as [День недели], count(Lectures.Id) as [Количество лекций]
from Lectures
group by Lectures.DayOfWeek;


/*11. Вывести номера аудиторий и количество кафедр, чьи лекции в них читаются. */

select Lectures.LectureRoom as [Номер аудитории], count(distinct Departments.Id)
from Lectures, GroupsLectures, Groups, Departments
where Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId
group by Lectures.LectureRoom;

/*12. Вывести названия факультетов и количество дисциплин, которые на них читаются.*/

select Faculties.Name as [Название факультета], count(distinct Subjects.Id) as [Количество дисциплин]
from Subjects, Lectures, GroupsLectures, Groups, Departments, Faculties
where Subjects.Id=Lectures.SubjectId and Lectures.Id=GroupsLectures.LectureId and Groups.Id=GroupsLectures.GroupId 
and Departments.Id=Groups.DepartmentId and Faculties.Id=Departments.FacultyId
group by Faculties.Name;


/*13. Вывести количество лекций для каждой пары преподаватель-аудитория. */

select Teachers.Name + ' ' + Teachers.Surname as [ФИО преподавателей], Lectures.LectureRoom as [Номер аудитории], 
count(Lectures.Id) as [Количество лекций]
from Teachers, Lectures
where Teachers.Id=Lectures.TeacherId
group by Teachers.Surname, Teachers.Name, Lectures.LectureRoom;