/*DML
This commands are used to manipulate data with in a table.
INSERT
UPDATE
DELETE
MERGE
*/
--create table test(a number,b varchar2(50),c date);
select*from test;
insert into test values(11,'Jack',to_date('31-AUG-21'));
insert into test(a,b)values(22,'Jil');
drop table test purge;
create table test as select*from emp where 1=2;
insert into test select*from emp;
insert into test(ename,job,hiredate)select ename,job,hiredate from emp;
update test
set sal=5000
where ename='BLAKE' and sal is null;
delete from test where ename='BLAKE';
/* difference between delete and truncate
when we are using delete command it delete from table and stored in buffer, we can get it back by using rollback command.
when using truncate the data permanately deleted full table, we can't get it back because it is ddl command and all DDL command are
auto commited.
when we need to delete all record from table then use truncate , because it is more faster then delete command
*/

-- DRL data retrival language :- when we want to retrive data from database , we are using select statement
