--Default date format is DD-MON-YY
-- sysdate -> current date
select sysdate from dual; --10-SEP-21
--add_months() -> used to add or subtract number of month
select add_months(sysdate,2)from dual; ---10-NOV-21
select add_months(sysdate,-2)from dual;  --10-JUL-21
--last_day()
select last_day(sysdate)from dual;  ---30-SEP-21
select to_char(last_day(add_months(sysdate,12-to_number(to_char(sysdate,'MM')))),'Day')from dual;
--next_day(date,'day') it provides next occurance day..
select next_day(sysdate,'FRIDAY')from dual;  --17-SEP-21
--months_between(date1,date2)
select abs(trunc(months_between(sysdate, '2-jan-21')))||' <-> Months and '
||abs(to_number( to_number(to_char(sysdate,'dd'))  - to_number(to_char(to_date('2-jan-21'),'dd'))))||' <-> Days'||' '
||decode(substr(trunc(months_between(sysdate, '2-jan-21')),1,1),'-','NEXT','LEFT') x from dual; 

/*DATE Architecture
1. date+number
2.date-number
3.date-date
--- date+date (is wrong)
to_char() -- this function used to convert date to character
*/
select to_char(sysdate,'Day')from dual; --Sunday   
--to_date() used to conver character to date type
/*
Fill mode: whenever we are using to_char() month,dayformat then oracle server return space when it returm less byte
to avoid this we are using FM Mode or fill mode
*/
select to_char(sysdate,'dd/fmMonth/yy') from dual;

/*
-- round() and trunc() in date
when we are using round() function in date if time is =>12 noon then it's add one day
but in trunc() it's return same date only
*/
select round(sysdate,'Year')from dual;  ---01-JAN-22
select trunc(sysdate,'Year')from dual;  --01-JAN-21
select round(sysdate,'month')from dual; --01-SEP-21
select trunc(sysdate,'month')from dual; --01-SEP-21

--JULIAN DATE--
select to_char(sysdate,'J')from dual

select to_char(sysdate-2,'J')from dual;