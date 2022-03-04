/*--CONSTRAINT--
Constraint are defind in 2 ways
1)column level(CL) -- In this we are define constraint on individual column
ex:-create table test(col1 datatype(size)constraint type,col2 datatype(size)constraint type,col3 datatype(size)constraint type);
2)table level(TL)   --In this we are define constraint in a group of column
ex:- create table test(col1 datatype(size),col2 datatype(size),col3 datatype(size),constraint type(col1,col2,col3))
*/
--Not null- not supported in table level
drop table test purge;
create table test(a number(3) not null,b varchar2(5)not null);
insert into test(b)values('B');
---unique--- when we are creating unique constraint ,unique automatically create a btree index of those columns
--CL--
create table test(a number unique,b varchar2(3)not null);
insert into test values(:a,:b);
--TL--
create table test(a number(3),b varchar2(20), unique(a,b));

---Primary key--
--cl--
create table test (a number primary key, b varchar2(400));
--tl--
--One primary key define in a table

--foreign key--
--one table foreign key must belong to another table primary key and both column belong to same data type
--always foreign key value based on primary key values, primary key accept unique record but foreign key accept duplicate value also
--cl--
drop table t1 purge;
drop table t2 purge;
drop table t3 purge;
create table t1(a number primary key,b varchar2(10)primary key); --- table can have only one primary key
create table t1(a number primary key,b varchar2(10),unique(b));
create table t2(c number references t1(a));
--TL--
create table t1(a number primary key);
create table t2(b varchar2(2)not null unique,c number(10),foreign key(c)references t1);
create table t3(c number unique,foreign key(c)references t1);
insert into t3 values(20);
select*from t1;
select*from t3;
delete from t1 where a=20;
/*--Delete in master table--
when we try to delete master table data present in child table get error, we can handle it
--ON DELETE CASCADE--
It will delete from both master and child record
*/
create table t1(a number primary key);
create table t2 (b number references t1 on delete cascade);
insert into t1 values(30);
insert into t2 values(10);
select*from t1;
select*from t2;
delete from t1 where a=30;
--ON DELETE SET NULL-- If we delete record in master table then it will update null to child table
create table t1(a number primary key);
create table t2(b number,foreign key(b)references t1(a)on delete set null);
insert into t1 values(30);
insert into t2 values(30);
select*from t1;
select*from t2;
delete from t1 where a=10;
--CHECK-- in oracle we are not allowed to define check constraint on sysdate
--CL--
create table t1(a number check(a>10));
insert into t1 values(1);
create table t2(b varchar2(10) check(b=upper(b)));
insert into t2 values('abi');
insert into t2 values('ABI');
drop table t1;
drop table t2;

--TP--
create table t1(a number,b varchar2(10),check (a>100 and b=upper(b)));

--Assign user defined name to constraint
--orace serve generate a unique identification number we can make it user defined
create table t1(a number constraint abi_pri1 primary key);
insert into t1 values(10);
create table t2(a number not null,b varchar2(10)not null,c number not null,constraint abi_144 unique(a,b,c));
insert into t2 values(3,'B',5);
/*
DATA DICTIONARIES
In oracle all object information stored in read only table known as data dictionaries.
these are automatically created when we install oracle
*/
desc user_constraints;
select*from user_constraints where table_name='T1';
desc USER_OBJECTS; 
select*from user_objects;
desc user_tables;
select*from user_tables;
select*from all_tables;
select * from USER_COL_COMMENTS; 
select * from ALL_CATALOG ;
select*from USER_IND_COLUMNS;
select*from USER_INDEXES;
select*from USER_SOURCE;

-- DEFAULT CLAUSE--
CREATE TABLE T1(A VARCHAR2(10),B NUMBER DEFAULT 1000);
INSERT INTO T1(A)VALUES('abinash');
select*from t1;

--adding or droping constraint from a existing table-- we are using alter command for it
drop table t1 purge;
drop table t2 purge;
create table t1(a number,b number,c number);
alter table t1 add primary key(a);
alter table t1 add unique(b);
-- when we add not null we use modify
alter table t1 modify c not null;
alter table t1 add unique(c);

create table t2(d number,e number,f number);
alter table t2 add foreign key(d)references t1;

create table t2(d number constraint ab_1 references t1);
alter table t1 drop primary key cascade;
alter table t1 drop unique(b,c);
select*from user_constraints where table_name='T2'; 
alter table t2 drop constraint ab_1 ;