 /*--Nested Table--
 --table with in another table is called nested table
 --s1-- Create an object type
 --s2-- Create a nested table type
 --s3-- Create a relational table
  */
  create or replace type ob1 as object(bookid number,bookname varchar2(50),price number);
create or replace type xy as table of ob1;
create table student(sid number,sname varchar2(20),col3 xy)nested table col3 store as ab1;

desc student;
insert into student values(100,'ABINASH',xy(ob1(1,'Electronics','870')));
insert into student values(101,'ABINASH',xy(ob1(8,'Electrical motor','267'),ob1(2,'Machine Lerning','2000'),ob1(6,'Artificial Inteligence','1980')));
select*from student;

select*from table(select col3 from student) where bookname='Electrical motor';
update table(select col3 from student)set price=554 where bookname='Electrical motor';

--Partition--
--table can logically decomposed into number of table is called partition
--Partition are used to improve the performance of the application , 3 type of partition
--1)Range Partition (RP)
--2)List Partition  (LP)
--3)Hash Partition  (HP)
--RP--creating partition based on range of the value
drop table test purge;
create table test(sid number,sname varchar2(100),sal number)
partition by range (sal)(partition p1 values less than(1000),partition p2 values less than (2000),partition other values less than (maxvalue) );

insert into test values(:n,:v,:SAL);
select*from test;
select*from test partition(p1);
select*from test partition(other);

--LP--Create partition based on character datatype column
--these partition is worked based on list of values.
create table test(sno number,sname varchar2(100))
partition by list(sname)(partition p1 values('INDIA','SRILANKA','PAKISTAN'),partition p2 values('US','UK'));

insert into test values(:a,:nm);
--If inserted other then list---RA-14400: inserted partition key does not map to any partition
select*from test;
select*from test partition(p1);

--HASH--
--Whenever we are specifying no of partition then oracle server only internally automatically create partition based on HASH algorithim
create table test(sno number,sal number)
partition by hash (sal)partitions 5;

--partition info store in user_tab_partitions
select*from user_tab_partitions;

--Table Space--(TS)
--TS is a logical storage unit which contains collection of datafile physically ,one datafile belong to one datafile only.
--If you want to run Oracle minimum 2 table space required
--1.system table space
--2.sysaux table space
--synx-- create tablespace tablespace_name path of the data file 
create tablespace tb1 'C:\oracle\product\10.2.0\oradata\orcl\SYSTEM01.DBF';

--segment--
--Whenever we are creating a db object then automatically some storage space is also called segment
--ex:- when we are creating a table then automatically some storage space is allocated this is called segment

--rowid identification--
select rowid,ename from emp;
--AAAMgzAAEAAAAAgAAA
--AAAMgz -> data object number
--AAE ->tablespace (relative datafile number)
--AAAAAg -> datablock number
--AAA -> rownumber with a block
