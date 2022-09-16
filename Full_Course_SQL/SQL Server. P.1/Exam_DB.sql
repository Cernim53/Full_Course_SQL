/*Необходимо написать следующие запросы к базе данных «Книжный магазин»: */

/*1. Показать все книги, количество страниц в которых больше 500, но меньше 650. */

select Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Название книги данного автора], Books.Pages as [Количество страниц]
from Authors, Books
where Authors.Id=Books.AuthorId and Books.Pages between 500 and 650
order by Authors.Surname, Authors.Name, Books.Name;


/*2. Показать все книги, в которых первая буква названия либо «А», либо «З». */

select Authors.Name+' '+Authors.Surname as [Автор книги], Books.Name as [Название книги данного автора]
from Authors, Books
where Authors.Id=Books.AuthorId and Books.Name = any(select Books.Name from Books where Books.Name like '[АЗ]%')
order by Books.Name, Authors.Surname, Authors.Name;


/*3. Показать все книги жанра «Детектив», количество проданных книг более 130000 экземпляров. */

select Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Название книги данного автора], Themes.Name as [Тематика (жанр) книги], 
Sales.Quantity as [Количество проданных книг]
from Authors, Books, Themes, Sales
where Authors.Id=Books.AuthorId and Themes.Id=Books.ThemeId and Books.Id=Sales.BookId and
Themes.Name='детектив' and Sales.Quantity > 130000
order by Authors.Surname, Authors.Name, Books.Name;



/*4. Показать все книги, в названии которых есть слово «Word», но нет слова «Microsoft». */

select Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Название книги данного автора]
from Authors, Books
where Authors.Id=Books.AuthorId and Books.Name = any(select Books.Name 
													 from Books 
													 where Books.Name like '%Word%' and Books.Name not like '%Microsoft%')
order by Authors.Surname, Authors.Name, Books.Name;


/*5. Показать все книги (название, тематика, полное имя автора в одной ячейке), цена одной страницы которых меньше 65 копеек. */

select Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Название книги данного автора], Themes.Name as [Тематика (жанр) книги], 
Books.Price/Books.Pages as [Цена одной страницы]
from Authors, Books, Themes
where Authors.Id=Books.AuthorId and Themes.Id=Books.ThemeId and Books.Price/Books.Pages < 0.65
order by Books.Price/Books.Pages, Authors.Surname;


/*6. Показать все книги, название которых состоит из 4 слов. */

select Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Название книги данного автора]
from Authors, Books
where Authors.Id=Books.AuthorId and Books.Name = any(select Books.Name 
													 from Books 
													 where Books.Name like '% % % %' and Books.Name not like '% % % % %')
order by Authors.Surname, Authors.Name, Books.Name;


/*7. Показать информацию о продажах в следующем виде: 
▷Название книги, но, чтобы оно не содержало букву «А». 
▷Тематика, но, чтобы не «Программирование». 
▷Автор, но, чтобы не «Герберт Шилдт». 
▷Цена, но, чтобы в диапазоне от 100 до 180 гривен. 
▷Количество продаж, но не менее 100000 книг. 
▷Название магазина, который продал книгу, но он не должен быть в Украине или России.*/

select Books.Name as [Название книги], Themes.Name as [Тематика (жанр) книги], Authors.Name+' '+Authors.Surname as [Автор книги],
Books.Price as [Цена книги], Sales.Quantity as [Количество продаж], Shops.Name as [Название магазина]
from Books join Themes on Themes.Id=Books.ThemeId
		   join Authors on Authors.Id=Books.AuthorId
		   join Sales on Books.Id=Sales.BookId
		   join Shops on Shops.Id=Sales.ShopId 
		   join Countries on Countries.Id=Shops.CountryId and Countries.Id=Authors.CountryId
where Books.Name not like 'А%' and Themes.Name not in('программирование') and Authors.Name <> 'Герберт' and Authors.Surname <>'Шилдт' 
and Books.Price between 100 and 180 and Sales.Quantity >= 100000 and Countries.Name not in('Украина', 'Россия')
order by Authors.Surname, Books.Name;



/*8. Показать следующую информацию в два столбца (числа в правом столбце приведены в качестве примера): 
▷Количество авторов: 14 
▷Количество книг: 47 
▷Средняя цена продажи: 85.43 грн. 
▷Среднее количество страниц: 650.6. */

select 'Количество авторов:', convert(nvarchar(10), count(Authors.id))
from Authors
union all
select 'Количество книг:', convert(nvarchar(10), count(Books.Id)) + '  шт.'
from Books
union all
select 'Средняя цена продажи:', convert(nvarchar(10), convert(dec(12,2), sum(Books.Price * Sales.Quantity*1.0) / sum(Sales.Quantity))) + '  грн'
from Books, Sales
where Books.Id=Sales.BookId
union all
select 'Среднее количество страниц', convert(nvarchar(10), convert(dec(12,1), sum(Books.Pages * Sales.Quantity*1.0) / sum(Sales.Quantity))) +'  стр.'
from Books, Sales
where Books.Id = Sales.BookId;


/*9. Показать тематики книг и сумму страниц всех книг по каждой из них. */

select Themes.Name as [Тематика (жанр) книг], sum(Books.Pages * Sales.Quantity) as [Сумма страниц]
from Themes, Books, Sales
where Themes.Id=Books.ThemeId and Books.Id=Sales.BookId
group by Themes.Name;


/*10. Показать количество всех книг и сумму страниц этих книг по каждому из авторов. */

select Authors.Name+' '+Authors.Surname as [Авторы книг], count(Books.Id) as [Количество книг], sum(Books.Pages) as [Количество страниц]
from Authors, Books
where Authors.Id=Books.AuthorId
group by Authors.Name, Authors.Surname;



/*11. Показать книгу тематики «Программирование» с наибольшим количеством страниц. */

select Themes.Name as [Тематика (жанр) книг], Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Название книги], 
Books.Pages as [Количество страниц]
from Authors, Books, Themes
where Authors.Id=Books.AuthorId and Themes.Id=Books.ThemeId 
and Books.Pages = (select max(Books.Pages) 
				   from Authors, Books, Themes
				   where Authors.Id=Books.AuthorId and Themes.Id=Books.ThemeId and Themes.Name='программирование'); 


/*12. Показать среднее количество страниц по каждой тематике, которое не превышает 400. */

select Themes.Name as [Тематика (жанр) книг], avg(Books.Pages) as [Среднее количество страниц]
from Themes, Books, Sales
where Themes.Id=Books.ThemeId and Books.Id=Sales.BookId
group by Themes.Name
having avg(Books.Pages) <= 400
order by Themes.Name;


/*13. Показать сумму страниц по каждой тематике, учитывая только книги с количеством страниц более 200, 
и чтобы тематики были «Программирование», «Администрирование» и «Дизайн». */

select Themes.Name as [Тематика (жанр) книги], sum(Books.Pages) as [Количество страниц]
from Themes, Books
where Themes.Id=Books.ThemeId and Books.Pages>200 and Themes.Name in ('администирование', 'программирование', 'дизайн')
group by Themes.Name;
						 


/*14. Показать информацию о работе магазинов: что, где, кем, когда и в каком количестве было продано. */

select Shops.Name as [Название магазина], Authors.Name+' '+Authors.Surname as [Авторы книг], Books.Name as [Проданные книги], Sales.SaleDate as [Дата продажи], Sales.Quantity as [Количество продаж]
from Shops, Books, Sales, Authors
where Books.Id=Sales.BookId and Shops.Id=Sales.ShopId and Authors.Id=Books.AuthorId
order by Shops.Name, Authors.Surname, Authors.Name, Books.Name;


/*15. Показать самый прибыльный магазин.*/

select Shops.Name as [Название магазина], sum(Sales.Quantity) as [Количество продаж], sum(Books.Pages*Sales.Quantity*1.0) as [Общая выручка]
from Shops, Books, Sales
where Books.Id=Sales.BookId and Shops.Id=Sales.ShopId
group by Shops.Name
having sum(Books.Price*Sales.Quantity*1.0) >= all(select sum(Books.Price*Sales.Quantity*1.0) 
												  from Books, Sales, Shops 
												  where Books.Id=Sales.BookId and Shops.Id=Sales.ShopId
												  group by Shops.Name)
order by Shops.Name;