/*1. Вывести названия аудиторий, в которых читает лекции преподаватель "Артур Ковалев".*/

select Teachers.Name+' '+Teachers.Surname as [ФИО преподавателя], LectureRooms.Name as [Аудитория]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId 
			  join Schedules on Lectures.Id=Schedules.LectureId 
			  join LectureRooms on LectureRooms.Id=Schedules.LectureRoomId
where Teachers.Name='Артур' and Teachers.Surname = 'Ковалев'
group by Teachers.Surname, Teachers.Name, LectureRooms.Name;


/*2. Вывести фамилии ассистентов, читающих лекции в группе "Comp_5".*/

select Teachers.Name+' '+Teachers.Surname as [ФИО преподавателя], Groups.Name as [Группа], Subjects.Name as [Предметы, которые читаются]
from Teachers join Assistants on Teachers.Id=Assistants.TeacherId
			  join Lectures on Teachers.Id=Lectures.TeacherId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Subjects on Subjects.Id=Lectures.SubjectId
where Groups.Name='Comp_5'
group by Subjects.Name, Teachers.Name, Teachers.Surname, Groups.Name;


/*3. Вывести дисциплины, которые читает преподаватель "Ирина Шапкина" для групп 5-го курса.*/

select Teachers.Name+' '+Teachers.Surname as [ФИО преподавателя], Groups.Name as [Группа], Groups.Year as [Курс], Subjects.Name as [Предметы, которые читаются]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Subjects on Subjects.Id=Lectures.SubjectId
where Teachers.Name='Ирина' and Teachers.Surname='Шапкина' and Groups.Year=5
group by Subjects.Name, Teachers.Name, Teachers.Surname, Groups.Name, Groups.Year;



/*4. Вывести фамилии преподавателей, которые не читают лекции по понедельникам.*/

select Teachers.Name+' '+Teachers.Surname as [ФИО преподавателя]
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



/*5. Вывести названия аудиторий, с указанием их корпусов, в которых нет лекций в среду первой недели на третьей паре.*/

select LectureRooms.Name as [Аудитория], LectureRooms.Building as [Корпус]
from LectureRooms join Schedules on LectureRooms.Id=Schedules.LectureRoomId
where LectureRooms.id not in (select LectureRooms.Id
						  from LectureRooms join Schedules on LectureRooms.Id=Schedules.LectureRoomId
						  where Schedules.Week=1 and Schedules.DayOfWeek=3 and Schedules.Class=3)
group by LectureRooms.Name, LectureRooms.Building;



/*6. Вывести полные имена преподавателей факультета "Факультет компьютерных наук", которые не курируют группы кафедры "Кафедра WEB технологий".*/

select Teachers.Name+' '+Teachers.Surname as [ФИО преподавателей], Faculties.Name as [Факультет]
from Teachers join Lectures on Teachers.Id=Lectures.TeacherId
			  join GroupsLectures on Lectures.Id=GroupsLectures.LectureId
			  join Groups on Groups.Id=GroupsLectures.GroupId
			  join Departments on Departments.Id=Groups.DepartmentId
			  join Faculties on Faculties.Id=Departments.FacultyId
where Faculties.Name='Факультет компьютерных наук' and Teachers.Id not in (select Teachers.Id 
																		   from Teachers join Curators on Teachers.Id=Curators.TeacherId
																						 join GroupsCurators on Curators.Id=GroupsCurators.CuratorId
																						 join Groups on Groups.Id=GroupsCurators.GroupId
																						 join Departments on Departments.Id=Groups.DepartmentId
																		   where Departments.Name='Кафедра WEB технологий')
group by Teachers.Surname, Teachers.Name, Faculties.Name
order by Teachers.Surname;


/*7. Вывести список номеров всех корпусов, которые имеются в таблицах факультетов, кафедр и аудиторий.*/

select 'Корпуса факультетов', Faculties.Building
from Faculties
union
select 'Корпуса кафедр', Departments.Building
from Departments
union
select 'Корпуса аудиторий', LectureRooms.Building
from LectureRooms;

/*8. Вывести полные имена преподавателей в следующем порядке: деканы факультетов, заведующие кафедрами, преподаватели, кураторы, ассистенты.*/

select 'Декан факультета', Teachers.Name+' '+Teachers.Surname
from Teachers join Deans on Teachers.Id=Deans.TeacherId
union all
select 'Заведующий кафедры', Teachers.Name+' '+Teachers.Surname
from Teachers join Heads on Teachers.Id=Heads.TeacherId
union all
select 'преподаватель', Teachers.Name+' '+Teachers.Surname
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
select 'куратор', Teachers.Name+' '+Teachers.Surname
from Teachers join Curators on Teachers.Id=Curators.TeacherId
union all
select 'ассистент', Teachers.Name+' '+Teachers.Surname
from Teachers join Assistants on Teachers.Id=Assistants.TeacherId


/*9. Вывести дни недели (без повторений), в которые имеются занятия в аудиториях "A311" и "A104" корпуса 1.*/

select Schedules.DayOfWeek as [День недели], LectureRooms.Building as [Корпус] --, LectureRooms.Name as [Аудитория]
from Schedules join LectureRooms on LectureRooms.Id=Schedules.LectureRoomId
where LectureRooms.Name = 'A311' 
union
select Schedules.DayOfWeek as [День недели], LectureRooms.Building as [Корпус] --, LectureRooms.Name as [Аудитория]
from Schedules join LectureRooms on LectureRooms.Id=Schedules.LectureRoomId
where LectureRooms.Name ='A104';

