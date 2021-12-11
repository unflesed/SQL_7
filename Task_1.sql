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