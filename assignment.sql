#what is the time period used?
select min(date) startdate  ,max(date) enddate from assignment1.airbnb_calendar;


# delete duplicate rows from table

create table new_airbnb 
select distinct * 
from assignment1.airbnb_calendar
;
# here if u want u can drop original table


#For each property, find out the number of days the property was available and not
#available (create a table with listing_id, available days, unavailable days and available
#days as a fraction of total days) ?

create table availabledays
as
select listing_id,count(*) as unavailbledays , (365-count(*)) as availabledays, ((365-count(*))/365) *100 as fraction_of_days_avaialbe
from assignment1.airbnb_calendar
group by airbnb_calendar.listing_id,available
having available='f';



#How many properties were available on more than 50% of the days? How many properties were available on more than 75% of the days?

create view ava2 as
select count(*) as count
from assignment1.airbnb_calendar
group by airbnb_calendar.listing_id,available
having available='t' and count(*)> 0.75*(365);
select count(*) as number_of_locations_available_for_more_than_75per from ava2;


create view ava as
select count(*) as count
from assignment1.airbnb_calendar
group by airbnb_calendar.listing_id,available
having available='t' and count(*)>(365/2);
select count(*) as number_of_locations_available_for_more_than_50per from ava;



#Create a table with max, min and average price of each property

create table maxminavg
select listing_id,max(price),min(price),avg(price)
from assignment1.airbnb_calendar
where available='t' and price is not NULL
group by listing_id



#Extract properties with an average price of more than $500
create view avgextract as
select listing_id,max(price) maxprice, min(price) minprice,AVG(price) as avgprice
from assignment1.airbnb_calendar
where available = 't'
group by listing_id;

select * from avgextract where avgprice>500;
