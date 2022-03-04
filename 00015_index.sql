/*
--INDEX--
--Index is a database object which is used to improve the performance, we can retrive the data very fast by using index column
-- index create 2 type
1)Automatically -- when create primary key or unique constraint automatic btree index created
2)Manually --synx--create index index_name on table_name(col1,col2);
-- whenever where clause and order by is there then only oracle server use index search mechanism on this column
--when ever where clause  have <>,null,not null server does't search for index

--Oracle having 2 type of index
1)btree index
2)bitmap index

--btree index--
--In oracle bydefault index is btree index, when we are creating btree index then oracle server automatically 
create tree structure in index column, In tree structure always leaf block store actual data along with rowid.
--when btree indexes are available then oracle server internally uses index scan on btree structure to 
retrive data very fastly frim the leaf block.
*/
create table test as select*from emp;
select*from test;
create index T1 on test(empno,ename);
select*from user_indexes where index_name='T1';
select*from user_ind_columns where index_name='T1';

--Calculating a query performance--
explain plan for select*from test order by sal desc;
select*from table(dbms_xplan.display());

explain plan for select*from test order by empno desc;
select*from table(dbms_xplan.display());

--Function Based Index-- (FBI)
--By default FBI is btree index
--synx--create index index_name on table_name (function name/expression (column name))
drop index t1;
create index t1 on test(upper(ename));
select*from user_indexes;

--Virtual Column-- introduce in 11g
create table t1(a number,b number,c number generated always as (a+b)virtual);
insert into t1(a,b)values(10,20);

--Oracle having 2 type of btree index
--1)Non unique btree index -- column have duplicate data
--2)Unique btree index -- column dont have duplicate record , if duplicate return error
--All automatic create index are unique btree index
create unique index t1 on test(empno);

/*
BITMAP INDEX (Oracle 7.3)
--synx--create bitmap index index_name on table name(column name)
-- bitmap created on low cardinility column
-- cardinality of column= number of distinct value/total number of record
--ex COC of emp_no= 14/14=1
--ex COC of job=5/14=0.36 -- low cardinality
--whenever we are creating bitmap indexes , internally oracle server automatically create bitmap table 
by using no of bit based on the indexed column value
--when we are requestng through logical operator or equality operator then oraccle  server directly operate
bit within bitmap table then resultant automatically converted to rowid by using internal bitmap function
*/
drop index t1;
create bitmap index t1 on test(deptno);