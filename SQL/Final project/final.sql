-- Запрос 1. Найти номер букирования с максимальной стоимость, и вывести по нему информацию вида:
-- номер билета, номер рейса, запанированную дату вылета, город вылета, город прилета, статус, ID рейса, ID пассажира, имя пассажира, класс билета, стоимость перелета(как segment_cost)
-- отсортировать по запанированной дате вылета

with max_amount
as (
	select *
	from bookings
	group by book_ref
	order by total_amount DESC
	limit 1
)
select
	tickets.ticket_no,
	flight_no,
	to_char(scheduled_departure, 'DD.MM.YYYY') AS departure_date,
	departure_city,
	arrival_city,
	status,
	ticket_flights.flight_id,
	passenger_id,
	passenger_name,
	fare_conditions,
	amount as segment_cost
from tickets INNER join ticket_flights on tickets.ticket_no=ticket_flights.ticket_no
	inner join flights_v on ticket_flights.flight_id = flights_v.flight_id
	where book_ref in (select book_ref from max_amount)
	order by scheduled_departure
;

-- Запрос 2. Вывести тип самолета, который совершил суммарно больше всего полетов

-- Запрос 3. Найти тип самолета, у которого суммано самая большая дистанция

-- Запрос 4. Найти топ-5 направлений с отменеными рейсами

-- Запрос 5. Вывести список аэропортов, которые находся севернее х-долготы

-- Запрос 6. Сколько рейсов в неделю летают из Москвы в Саранск
