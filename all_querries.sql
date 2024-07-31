use mydb;
-- 1

select dtls.*, (select ordrs.customer_id 
				from mydb.orders as ordrs 
				where ordrs.id = dtls.order_id) as customer_id
from mydb.order_details as dtls;

-- 2

select * from order_details
where order_id in (select id
from orders
where shipper_id = 3);

-- 3 

select dtls.order_id, avg(dtls.quantity) as average
from (select order_id, quantity 
     from order_details 
     where quantity > 10) as dtls
group by dtls.order_id;

-- 4

with tmp as (
	select order_id, quantity 
	from order_details 
	where quantity > 10
	)
select tmp.order_id, avg(tmp.quantity) as average
from tmp
group by tmp.order_id;

-- 5

drop function if exists devideFloats;
DELIMITER //
create function devideFloats(number_1 float, number_2 float)
returns float
deterministic 
no sql
begin
    declare result float;
    set result = number_1 / number_2;
    return result;
end //
DELIMITER ;
select order_id, product_id, quantity,
devideFloats(quantity, 3.5) as quantity from order_details
