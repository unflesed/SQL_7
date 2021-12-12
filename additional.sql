USE carsshop;

DELIMITER |

create Function getAge()
returns int
deterministic
begin
	return (select min(Age) from clients);
end |

select getAge(); |

Select * from cars
join orders on cars.id = orders.car_id
join clients on clients.id = orders.client_id
where age = getAge(); |
