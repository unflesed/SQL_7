create database MyFunkDB;

use MyFunkDB;

create table Salaries(
id int auto_increment not null,
salary int not null,
post varchar(30) not null,
primary key(id)
);

create table Info(
id int auto_increment not null,
family tinyint not null,
dateOfBirth date not null,
address varchar(30) not null,
primary key(id)
);

create table Employees(
id int auto_increment not null,
name varchar(30) not null,
phone varchar(30) not null,
Salaries_id int not null,
Info_id int not null,
foreign key (Salaries_id) references Salaries(id),
foreign key (Info_id) references Info(id),
primary key(id)
);

insert into Salaries (salary, post)
values (1000, 'worker'),
(1100, 'worker'),
(1200, 'worker'),
(1500, 'manager'),
(1600, 'manager'),
(2500, 'chief');

insert into Info (family, dateOfBirth, address)
values (1, 19800101, 'Lenina 12'),
(1, 19810101,'Pushkina 10'),
(1, 19820101,'Shevchenko 11'),
(0, 19830101,'Kolasa 5'),
(0, 19840101, 'Kupaly 3'),
(0, 19850101, 'Cetkin 5');

insert into Employees (name, phone, Salaries_id, Info_id)
values ('Pupkin', '+19800101', 1, 1),
('Utkin', '+19810101', 2, 2),
('Ivanov', '+19820101', 3, 3),
('Petrov', '+19830101', 4, 4),
('Sidorov', '+19840101',  5, 5),
('Antonov', '+19850101',  6, 6);

select * from Employees;
select * from Salaries;
select * from Info;

-- 1) Требуется узнать контактные данные сотрудников (номера телефонов, место жительства).
DELIMITER |

create procedure getContactData()
begin
	Select name, phone, address from Employees
    join Info on Employees.Info_id = Info.id;
end |

call getContactData(); |
 
-- 2) Требуется узнать информацию о дате рождения всех не женатых сотрудников и номера
-- телефонов этих сотрудников. 
drop procedure if exists getInfo; |

create procedure getInfo()
begin
	Select name, dateOfBirth, phone from Employees
    join Info on Employees.Info_id = Info.id
    where family = false;
end |

call getInfo(); |

-- 3) Требуется узнать информацию о дате рождения всех сотрудников с должностью менеджер и
-- номера телефонов этих сотрудников.
drop function if exists getManager; |

create function getManager()
returns varchar(30)
deterministic
begin
	return (select post from Salaries 
			where post = 'manager'
            group by post);
end |

Select getManager(); |

Select name, dateOfBirth, phone from Employees
    join Info on Employees.Info_id = Info.id
    join Salaries on Salaries.id = Employees.Salaries_id
    where post = getManager() ; |