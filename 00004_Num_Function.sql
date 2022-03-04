/* SQL FUNCTION
1)user defined function
2)pre defined function
->Number functio
->Character function
->Date function
->Group function or Aggrigate function
--In oracle user defined function only create in PL/SQL
Dual:- dual is a predefined virtual table,which contain one row and one column.
Bydefault dual column data type is VARCHAR2 data type.
*/
select*from dual;
select abs(-123)from dual; --123
--mod(m,n) it will gives reminder after divide by n
select mod(38,7) from dual; --3
--round(m,n) It round even floated value number m based on n
select round(1.8)from dual; --2
select round(1.3)from dual;--1
select round(12.35478,3) from dual; --12.355
select round(12.35428,3) from dual; --12.354
select round(12345,-2)from dual; --12300
select round(12894,-2)from dual; --12900
--trunc(m,n) it provide flated value on m based on n
select trunc(1987,-2)from dual; --1900
select trunc(1.9)from dual;--1
--ceil() provide nearest greatest integer
select ceil(1.2)from dual;  --2
--floor() provide nearest lowest integer
select floor(1.9)from dual; --1
---greatest(exp1,exp2,exp3...) to find out the greatest value
select greatest(78,98,65,02,19)from dual;  --98
--least(exp1,exp2,exp3...) to find out the small value
select least(34,12,879,03,87) from dual; --3

