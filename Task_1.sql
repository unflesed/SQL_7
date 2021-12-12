use Publishing;

-- 1 Создать хранимую процедуру, которая возвращает максимальное из двух чисел.
DELIMITER |
drop procedure getMax;|
create procedure getMax(In value1 int, in value2 int, out max int)
begin
	if (value1 > value2)
		then 
		select value1 as max;
        else
        select value2 as max;
	end if;
End |

call getMax(5, 3, @max); |

-- 2. Написать хранимую процедуру, которое будет отображать информацию
-- обо всех авторах из определенной страны, название которой передается в процедуру при вызове.

DELIMITER |
drop procedure getAuthor;|
create procedure getAuthor(In countryN varchar(30))
begin
	select * from author 
    join country on country.id = author.country_id
    where NameCountry = countryN;
End |

call getAuthor('Ukraine'); |

-- 3. Написать процедуру, позволяющую просмотреть все книги определенного
-- автора, при этом его имя передается при вызове.
drop procedure getBook;|
create procedure getBook(In authorN varchar(30))
begin
	select * from book 
    join author on author.id = book.author_id
    where FirstName = authorN;
End |

call getBook('Sam'); |

-- 4. Функцию, которая возвращает самую дорогую книгу указанной тематики.
create function expensiveBook(themeB varchar(30))
returns varchar(30)
Deterministic
Begin
	RETURN (Select max(PriceOfBook) from book 
			join themes on book.theme_id = themes.id
            where NameTheme = themeB);
end |

select NameBook, expensiveBook('Computer science') as MaxPrice from book
where PriceOfBook = expensiveBook('Computer science'); |
drop function if exists expensiveBook; |

-- 5.Написать функцию, которая выводит информацию о количестве авторов,
-- живущих в разных странах (название страны передается в качестве параметра).
create function getAuthorQuantity(counthryL varchar(30))
returns varchar(30)
Deterministic
Begin
	RETURN (Select count(FirstName) from author 
			join country on author.country_id = country.id
            where NameCountry = counthryL);
end |

select getAuthorQuantity('Ukraine') as Quantity; | |
drop function if exists getAuthorQuantity; |

-- 6 Функцию, которая возвращает количество магазинов, которые не продали ни одной книги издательства.
Create function withoutSales()
returns int 
deterministic
begin
	RETURN ( select count(*) from shop
			 left join sales on sales.shop_id = shop.id
             where sales.shop_id is NULL);
end |

select withoutSales(); |
drop  function if exists withoutSales; |