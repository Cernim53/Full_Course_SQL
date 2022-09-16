/*1) ������� ������� ������, �� ����������� �� ���� ��������� �������

SELECT Name_Departments, Financing_Departments, Id_Departments			
FROM Departments;*/

/*6) ������� �������� ������, ���� �������������� ������� ������ 11000 ��� ������ 25000

SELECT Id_Departments, Name_Departments, Financing_Departments			
FROM Departments
WHERE Financing_Departments < 11000 OR Financing_Departments > 25000*/

/*12) . ������� �������� ������, ������� � ���������� ������� ������������� 
�� ������� �Department of International Lawt�. ��������� ���� ������ ����� �������� 
�Name of Department�. 

SELECT Id_Departments, Name_Departments AS [Name of Department], Financing_Departments		
FROM Departments															
WHERE NOT Name_Departments = 'Department of International Law' 
ORDER BY Name_Departments ASC;*/

/*4) ������� ������� ����������� � ���� ������ ���� ���������� �������: 
�The dean of faculty [faculty] is [dean]�

SELECT 'The dean of ' + Name_Faculties + ' is ' + Dean_Faculties		
FROM Faculties;*/															
 
/*7) ������� �������� ����������� ����� ���������� �Computer Science�
 
 SELECT Name_Faculties													
 FROM Faculties
 WHERE NOT Name_Faculties = 'Faculty of Computer Science'
 ORDER BY Name_Faculties ASC;*/

/*3) ������� ��� �������������� �� �������, ������� ������ �� ��������� 
� �������� � ������� ������ �� ��������� � �������� (����� ������ � ��������)
 
 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName,				
 Salary_Teachers / Premium_Teachers AS [Salary / Premium],
 Salary_Teachers / (Premium_Teachers + Salary_Teachers) AS [Salary / Payment]
 FROM Teachers;*/
																		
/*5) ������� ������� ��������������, ������� �������� ������������ � ������ ������� ��������� 1050
 
 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Salary_Teachers, Premium_Teachers
 FROM Teachers
 WHERE Salary_Teachers > 1050 AND IsProfessor_Teachers = 1;*/

 /*8) ������� ������� � ��������� ��������������, ������� �� �������� ������������

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers
 FROM Teachers
 WHERE NOT IsProfessor_Teachers = 1;*/

 /*9) ������� �������, ���������, ������ � �������� �����������, � ������� �������� � ��������� �� 160 �� 550

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, Salary_Teachers AS Salary, 
 Premium_Teachers AS Premium
 FROM Teachers
 WHERE Premium_Teachers >= 160 AND Premium_Teachers <=550 AND IsAssistant_Teachers = 1;*/

 /*10) ������� ������� � ������ �����������

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, Salary_Teachers AS Salary 
 FROM Teachers
 WHERE IsAssistant_Teachers = 1;*/

 /*11) ������� ������� � ��������� ��������������, ������� ���� ������� �� ������ �� 01.01.2000

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, EmploymentDate_Teachers 
 FROM Teachers
 WHERE EmploymentDate_Teachers < '2000-01-01';*/

 /*13)  ������� ������� �����������, ������� �������� (����� ������ � ��������) �� ����� 1200

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, Premium_Teachers + Salary_Teachers AS [Payment] 
 FROM Teachers
 WHERE Premium_Teachers + Salary_Teachers <= 1200;*/

 /*15) ������� ������� ����������� �� ������� ������ 550 ��� ��������� ������ 200

 SELECT Name_Teachers + ' ' + Surname_Teachers AS FullName, Position_Teachers, 
 Salary_Teachers AS Salary, Premium_Teachers AS Premium
 FROM Teachers
 WHERE Premium_Teachers < 200 OR Salary_Teachers < 550;*/

 /*2) ������� �������� ����� � �� �������� � ���������� ���� ����� ������ �������

 SELECT Name_Groups, Rating_Groups
 FROM Groups;*/
 
 /*14)  ������� �������� ����� 5-�� �����, ������� ������� ���������� �� 2 �� 4

 SELECT Name_Groups, Rating_Groups
 FROM Groups
 WHERE Year_Groups = 5 AND (Rating_Groups >=2 AND Rating_Groups <=4);*/


