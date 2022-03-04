/*
--DDL--
CREATE
ALTER
DROP
TRUNCATE
RENAME
All DDL command defines structure of the table
*/
create table master1(a number,b varchar2(10),c date);
desc master1;
alter table master1 add(d number);
alter table master1 add(e number,f number);
alter table master1 modify(d varchar2(30),f date);
alter table master1 drop column d;
alter table master1 drop (e,f);
alter table master1  set unused (d); 
SELECT * FROM USER_UNUSED_COL_TABS WHERE TABLE_NAME='MASTER1';
alter table master1 drop unused columns;
alter table master1 rename column a to aa ;
truncate table master1; 
rename master1 to my_master1;
drop table my_master1;
select original_name from recyclebin;
flashback table my_master1  to before drop;
drop table my_master1 purge;
purge recyclebin;
/* RECYCLEBIN
Recyclebin is a predefined readonly table , generaly automatically created while instaling Oracle server
This type of table also called data dictionary
*/

create table test_emp as select*from emp;
select*from test_emp;
drop table test_emp;
create table test_emp as select*from emp where 1=2;


