/*1. Вывести количество палат, вместимость которых больше 10. */

select 'Количество палат, где больше 15 мест', count(Wards.Id) 
from Wards
where Wards.Places>15;


/*2. Вывести названия корпусов и количество палат в каждом из них. */

select Departments.Building as [Номер корпуса], count(Wards.Id) as [Количество палат]
from Departments, Wards
where Departments.Id=Wards.DepartmentId
group by Departments.Building;



/*3. Вывести названия отделений и количество палат в каждом из них. */

select Departments.Name as [Название отделений], count(Wards.Id) as [Количество палат]
from Departments, Wards
where Departments.Id=Wards.DepartmentId
group by Departments.Name;


/*4. Вывести названия отделений и суммарную надбавку врачей в каждом из них. */

select Departments.Name as [Название отделений], sum(distinct Doctors.Premium) as [Суммарная надбавка врачей]
from Departments, Wards, DoctorsExaminations, Doctors
where Departments.Id=Wards.DepartmentId and Wards.Id=DoctorsExaminations.WardId and Doctors.Id=DoctorsExaminations.DoctorId
group by Departments.Name;



/*5. Вывести названия отделений, в которых проводят обследования 5 и более врачей. */

select Departments.Name as [Название отделения], count(distinct Doctors.Id) as [Количество врачей]
from Departments, Wards, DoctorsExaminations, Doctors
where Departments.Id=Wards.DepartmentId and Wards.Id=DoctorsExaminations.WardId and Doctors.Id=DoctorsExaminations.DoctorId
group by Departments.Name
having count(distinct Doctors.Id) >= 5;


/*6. Вывести количество врачей и их суммарную зарплату (сумма ставки и надбавки). */

select 'Количество врачей', convert(nvarchar(10), count(Doctors.Id)) + '  чел'
from Doctors
union all
select 'Суммарная зарплата', convert(nvarchar(10), sum(Doctors.Salary+Doctors.Premium)) + '  грн'
from Doctors;


/*7. Вывести среднюю зарплату (сумма ставки и надбавки) врачей. */

select 'Средняя зарплата врачей', convert(nvarchar(10), avg(Doctors.Salary+Doctors.Premium)) + '  грн'
from Doctors;


/*8. Вывести названия палат с минимальной вместительностью. */

select Wards.Name as [Название палат], min(Wards.Places) as [Количество мест]
from Wards
group by Wards.Name, Wards.Places
having Wards.Places = (select min(Wards.Places) from Wards)
order by Wards.Name;


/*9. Вывести в каких из корпусов 1, 3, 4 и 5, суммарное количество мест в палатах превышает 40. 
При этом учитывать только палаты с количеством мест больше 15.*/

select Departments.Building as [Номер корпуса], sum(Wards.Places) as [Количество мест в палатах]
from Departments, Wards
where Departments.Id=Wards.DepartmentId and Wards.Places > 15 and Departments.Building in(1, 3, 4, 5)
group by Departments.Building
having sum(Wards.Places) > 40;