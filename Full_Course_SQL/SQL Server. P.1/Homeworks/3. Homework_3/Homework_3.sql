/*1) Вывести таблицу кафедр, но расположить ее поля в обратном порядке

SELECT Name_Departments, Financing_Departments, Id_Departments			
FROM Departments;*/

/*6) Вывести названия кафедр, фонд финансирования которых меньше 11000 или больше 25000

SELECT Id_Departments, Name_Departments, Financing_Departments			
FROM Departments
WHERE Financing_Departments < 11000 OR Financing_Departments > 25000*/

/*12) . Вывести названия кафедр, которые в алфавитном порядке располагаются 
до кафедры “Department of International Lawt”. Выводимое поле должно иметь название 
“Name of Department”. 

SELECT Id_Departments, Name_Departments AS [Name of Department], Financing_Departments		
FROM Departments															
WHERE NOT Name_Departments = 'Department of International Law' 
ORDER BY Name_Departments ASC;*/

/*4) Вывести таблицу факультетов в виде одного поля в следующем формате: 
“The dean of faculty [faculty] is [dean]”

SELECT 'The dean of ' + Name_Faculties + ' is ' + Dean_Faculties		
FROM Faculties;*/															
 
/*7) Вывести названия факультетов кроме факультета “Computer Science”
 
 SELECT Name_Faculties													
 FROM Faculties
 WHERE NOT Name_Faculties = 'Faculty of Computer Science'
 ORDER BY Name_Faculties ASC;*/

/*3) Вывести для преподавателей их фамилию, процент ставки по отношению 
к надбавке и процент ставки по отношению к зарплате (сумма ставки и надбавки)
 
 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName,				
 Salary_Teachers / Premium_Teachers AS [Salary / Premium],
 Salary_Teachers / (Premium_Teachers + Salary_Teachers) AS [Salary / Payment]
 FROM Teachers;*/
																		
/*5) Вывести фамилии преподавателей, которые являются профессорами и ставка которых превышает 1050
 
 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Salary_Teachers, Premium_Teachers
 FROM Teachers
 WHERE Salary_Teachers > 1050 AND IsProfessor_Teachers = 1;*/

 /*8) Вывести фамилии и должности преподавателей, которые не являются профессорами

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers
 FROM Teachers
 WHERE NOT IsProfessor_Teachers = 1;*/

 /*9) Вывести фамилии, должности, ставки и надбавки ассистентов, у которых надбавка в диапазоне от 160 до 550

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, Salary_Teachers AS Salary, 
 Premium_Teachers AS Premium
 FROM Teachers
 WHERE Premium_Teachers >= 160 AND Premium_Teachers <=550 AND IsAssistant_Teachers = 1;*/

 /*10) Вывести фамилии и ставки ассистентов

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, Salary_Teachers AS Salary 
 FROM Teachers
 WHERE IsAssistant_Teachers = 1;*/

 /*11) Вывести фамилии и должности преподавателей, которые были приняты на работу до 01.01.2000

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, EmploymentDate_Teachers 
 FROM Teachers
 WHERE EmploymentDate_Teachers < '2000-01-01';*/

 /*13)  Вывести фамилии ассистентов, имеющих зарплату (сумма ставки и надбавки) не более 1200

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, Premium_Teachers + Salary_Teachers AS [Payment] 
 FROM Teachers
 WHERE Premium_Teachers + Salary_Teachers <= 1200;*/

 /*15) Вывести фамилии ассистентов со ставкой меньше 550 или надбавкой меньше 200

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, 
 Salary_Teachers AS Salary, Premium_Teachers AS Premium
 FROM Teachers
 WHERE Premium_Teachers < 200 OR Salary_Teachers < 550;*/

 /*2) Вывести названия групп и их рейтинги с уточнением имен полей именем таблицы

 SELECT Name_Groups, Rating_Groups
 FROM Groups;*/
 
 /*14)  Вывести названия групп 5-го курса, имеющих рейтинг в диапазоне от 2 до 4

 SELECT Name_Groups, Rating_Groups
 FROM Groups
 WHERE Year_Groups = 5 AND (Rating_Groups >=2 AND Rating_Groups <=4);*/


