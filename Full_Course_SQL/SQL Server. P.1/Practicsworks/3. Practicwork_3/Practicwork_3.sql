/*1. Вывести содержимое таблицы палат. */

select *
from Wards;

/*более презентабельный вывод*/

select Wards.Name as [Название палаты], Wards.Building as [Корпус], Wards.Floor as [Этаж]
from Wards
order by Wards.Name;

/*2. Вывести фамилии и телефоны всех врачей. */

select Doctors.Name+' '+Doctors.Surname as [ФИО доктора], Doctors.Phone as [Телефон]
from Doctors
order by Doctors.Surname, Doctors.Name;


/*3. Вывести все этажи без повторений, на которых располагаются палаты. */

select Wards.Floor as [Этажи, на которых располагаются палаты]
from Wards
group by Wards.Floor;

/*4. Вывести названия заболеваний под именем “Название болезни” и степень их тяжести под именем “Степень тяжести заболевания”. */

select Diseases.Name as [Название болезни], Diseases.Severity as [Степень тяжести заболевания]
from Diseases
order by Diseases.Name, Diseases.Severity;


/*5. Использовать выражение FROM для любых трех таблиц базы данных, используя для них псевдонимы. */

select Doctors.Name+' '+Doctors.Surname as [ФИО доктора]
from Doctors;

select Departments.Name as [Отделения], Wards.Name as [Палаты]
from Departments, Wards
where   (Departments.Name like '%card%' and Wards.Name like 'Card%') or
		(Departments.Name like '%ther%' and Wards.Name like 'Ther%') or
		(Departments.Name like '%trau%' and Wards.Name like 'Trau%') or
		(Departments.Name like '%neur%' and Wards.Name like 'neur%');
		

/*6. Вывести названия отделений, расположенных в корпусе 4 и имеющих фонд финансирования менее 30000. */

select Departments.Name as [Названия отделений], Departments.Building as [Корпус], 
Departments.Financing as [Фонд финансирования] 
from Departments
where Departments.Building=4 and Departments.Financing < 30000
order by Departments.Name;


/*7. Вывести названия отделений, расположенных в 3-м корпусе с фондом финансирования в диапазоне от 12000 до 15000. */

select Departments.Name as [Название отделения], Departments.Building as [Корпус], 
Departments.Financing as [Фонд финансирования] 
from Departments
where Departments.Building=3 and Departments.Financing between 12000 and 15000
order by Departments.Name;


/*8. Вывести названия палат, расположенных в корпусах 4 и 5 на 1-м этаже. */

select Wards.Name as [Название палаты], Wards.Building as [Корпус], Wards.Floor as [Этаж]
from Wards
where Wards.Building in (4, 5) and Wards.Floor=1
order by Wards.Name;



/*9. Вывести названия, корпуса и фонды финансирования отделений, расположенных в корпусах 3 или 5 
и имеющих фонд финансирования меньше 11000 или больше 25000. */

select Departments.Name as [Название отдела], Departments.Building as [Корпус], Departments.Financing as [Фонд финансирования]
from Departments
where Departments.Building in(3, 5) and Departments.Financing < 11000 or Departments.Financing > 25000
order by Departments.Name;


/*10. Вывести фамилии врачей, чья зарплата (сумма ставки и надбавки) превышает 11500. */

select Doctors.Name+' '+Doctors.Surname as [ФИО врача], Doctors.Salary+Doctors.Premium as [Зарплата]
from Doctors
where Doctors.Salary+Doctors.Premium > 11500
order by Doctors.Surname, Doctors.Name;


/*11. Вывести фамилии врачей, у которых половина зарплаты превышает троекратную надбавку. */

select Doctors.Name+' '+Doctors.Surname as [ФИО врача], Doctors.Salary*0.5 as [Половина зарплаты], Doctors.Premium*3 as [Троекратная надбавка]
from Doctors
where Doctors.Salary*0.5 > Doctors.Premium*3
order by Doctors.Surname, Doctors.Name;


/*12. Вывести названия обследований без повторений, проводимых в первые три дня недели с 12:00 до 15:00. */

/*Условие не совсем корректно: повторение названия обследования невозможно, т.к. Examinations.Name - уникально (по условиям задания) 
Каждое обследование имеет уникальное название - например: CT scan, CT scan_2, CT scan_3 и т.д. 
Если бы название обследования было бы неуникальным, можно было бы использовать  "group by Examinations.Name"  */

select Examinations.Name as [Названия обследований], Examinations.DayOfWeek as [День недели], 
Examinations.StartTime as [Начало], Examinations.EndTime as [Конец]
from Examinations
where Examinations.DayOfWeek in (1, 2, 3) and Examinations.StartTime between '12:00' and '15:00' 
order by Examinations.DayOfWeek, Examinations.StartTime, Examinations.Name;



/*13. Вывести названия и номера корпусов отделений, расположенных в корпусах 1, 3, 8 или 10. */

select Departments.Name as [Название отделения], Departments.Building as [Корпус], Departments.Floor as [Этаж]
from Departments
where Departments.Building in (1, 3, 8, 10)
order by Departments.Building, Departments.Floor, Departments.Name;


/*14. Вывести названия заболеваний всех степеней тяжести, кроме 1-й и 2-й. */

select Diseases.Name as [Названия заболеваний], Diseases.Severity as [Степень тяжести заболевания]
from Diseases
where Diseases.Severity not in (1, 2)
order by Diseases.Name, Diseases.Severity;

/*15. Вывести названия отделений, которые не располагаются в 1-м или 3-м корпусе. */

select Departments.Name as [Название отделения], Departments.Building as [Корпус], Departments.Floor as [Этаж]
from Departments
where Departments.Building not in (1, 3)
order by Departments.Building, Departments.Floor, Departments.Name;


/*16. Вывести названия отделений, которые располагаются в 1-м или 3-м корпусе. */

select Departments.Name as [Название отделения], Departments.Building as [Корпус], Departments.Floor as [Этаж]
from Departments
where Departments.Building in (1, 3)
order by Departments.Building, Departments.Floor, Departments.Name;


/*17. Вывести фамилии врачей, начинающиеся на букву “N”. */

select Doctors.Name+' '+Doctors.Surname as [ФИО врача]
from Doctors
where Doctors.Surname like 'N%'
order by Doctors.Surname, Doctors.Name;