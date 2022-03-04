 /*
 SUBQUERY -> is 2 type
 1)Non co-related  -> in this child query executed first then only parent query executed.
 2)Co-related   -> here parent query executed first then only child query executed.
 
 Non co-related
 1. single row sub query
 2. multi row sub query
 3. multi column sub query
 4. inline view or sub query used in from clause.
 */
 select*from emp;
 select*from dept;
 select *from emp where sal>(select avg(sal)from emp);
 select*from emp where deptno=(select deptno from dept where dname=upper('sales')); -- working on sales
 select*from emp where hiredate=(select min(hiredate)from emp);  --- senior most emply
 select*from emp where deptno=(select deptno from emp where ename=upper('smith')) and ename!=upper('smith'); -- who are working same dept where smith working
 select *from emp where sal=(select max(sal)from emp where sal not in(select max(sal)from emp)); -- 2nd highst sal
 
 /*
 --TOP n Analysis--
 In oracle for top-n-analysis we are using 2 concept
 1)inline view
 2)rownum
 
 --inline view--
 --An inline view is not a real view but a subquery in the FROM clause of a SELECT statement. 
 In oracle we are not allowed to use order by in child query, to overcome this we are using inline view
 --select*from(select statement)
 --An inline view is not a real view but a subquery in the FROM clause of a SELECT statement. Consider the following SELECT statement:
 --In the FROM clause, you can specify a table from which you want to query data. Besides a table, you can use a subquery
 --The subquery specified in the FROM clause of a query is called an inline view. 
 Because an inline view can replace a table in a query, it is also called a derived table. 
 Sometimes, you may hear the term subselect, which is the same meaning as the inline view.
 */
 select*from(select ename,sal, sal*12 anl_sal from emp)where anl_sal>30000;
 
 --rownum--
 --rownum is a pseudo column ,it behave like a table column
 --when installing oracle server some column automatically created for all tables these are rownum,rowid
 --rownum is a pseudo column it's automatically assign to each row at the time of selection
 select rownum from dual;
 select rownum,ename,sal from emp order by ;
 select rownum,ename,sal from emp where sal>1500;
 --Generally rownum doesn't work with more then one positive intiger it works with less then(<,<=)
 select*from emp where rownum=1;
 select*from emp where rownum=2; -- here it is not work
 
 select*from emp where rownum<=2  --- 2nd row num
 minus
 select*from emp where rownum<=1;
 select*from emp where rownum between 1 and 5;
 
 select rownum,ename from emp 
 minus
select rownum,ename from emp where rownum<=(select max(rownum)-2 from emp) ;

---****when ever we are using rownum allies name in inline view then it work--
select*from(select rownum r,ename,sal,deptno,job from emp)where r=13;
select*from(select rownum r,ename,sal,deptno from emp) where r=1 --- first and last record
or r=(select max(rownum) from emp);
select*from(select rownum r,ename,sal,job from emp) where mod(r,2)=0;  -- display even rownum rec
select*from(select rownum r,ename,sal,job from emp)where r in(2,3,8,11);

/*--Analytical function used in inline views
1. row_number()
2.rank()
3.dense_rank()
syn:- analytical function ()over(partition by column name order by column name asc/desc
->row_ number assign different rank for same column value
->rank assign same rank for same column value and also skiped next rank
->dense_rank assign same rank for same value and not skiped next rank
*/
select empno,ename,deptno,sal,job,row_number()over(partition by deptno order by sal desc)from emp;
select ename,deptno,sal,job,row_number()over(order by sal desc)from emp;
select ename,deptno,sal,job,row_number()over(order by sal desc)from emp where deptno=20;

select empno,ename,sal,deptno,job,rank()over(partition by deptno order by sal desc) from emp;
select ename,sal,deptno,job,rank()over(order by sal desc)from emp where deptno=20;

select ename,deptno,sal,job,dense_rank() over(partition by deptno order by sal desc) from emp;
select ename,deptno,sal,job,dense_rank() over(order by sal desc)from emp;

select*from(select empno,ename,sal,deptno,job,dense_rank()over(partition by deptno order by sal desc)rnk from emp)
where rnk=2;  --2nd rank of each dept
select*from(select ename,sal,deptno,job,dense_rank()over(order by sal desc)rnk from emp)where rnk=5;  -- 5th highst sal from emp

/*
--ROWID--
--ROWID is a psedu column , if you want to return data very fast plz use rowid
-- when we are inserting a new record into table then oracle server automatically insert 
--a unique identification number with hexadecimal format, this is known as rowid
--generally rownum have temporary value where rowid have fixed value
*/

select rowid, ename from emp where deptno=30;
select max(rowid)from emp;
select min(rowid)from emp;
select*from(select empno,ename,deptno,sal,job,row_number() over(order by rowid desc)rwd from emp)where rwd=5;
select*from emp where rowid=(select min(rowid)from emp);-- 1st insert record from emp table
select*from emp where rowid=(select max(rowid)from emp); --last record insert from emp table

--Delete duplicate rows--
drop table t1 purge;
create table t1(a number not null);
insert into t1 values(:a);
select*from t1;
delete from t1 where rowid not in(select min(rowid) from t1 group by a);

--Multiple column sub-query--
select*from emp where (job,deptno)in(select job,deptno from emp where ename='SCOTT');
select*from emp where(job,sal)in(select job,max(sal) from emp group by job) order by deptno; ----max sal in each job
select*from emp where(deptno,hiredate)in(select deptno,min(hiredate)from emp group by deptno)order by deptno;  --seniore most in each deptno

/*
--CO-Related Sub-query--
--In co-related sub-query parent query executed first than child query executed
--Generally in non-corelated sub query child query executed once per parent query table where
in co-related sub query child query is executed for each row for patent query table
*/
create table t1 as select*from emp;
select*from t1;
alter table t1 add (dname varchar2(25));
update t1 e
set dname= (select dname from dept d where e.deptno=d.deptno);

select*from emp e where 1=(select count(*) from emp es where es.sal>=e.sal );  --- highest salry 
select*from emp e where 3=(select count(distinct(sal)) from emp es where es.sal>=e.sal);
select*from emp e where 2=(select count(distinct(sal)) from emp es where es.sal>=e.sal);

/*
--EXISTS--
--EXIST operator performance is very high compaire to in operator
-- we are not allow to use column name when we use exist operator
*/
select*from dept d where exists(select*from emp e where d.deptno=e.deptno);  --which dept have employee
select*from emp e where exists(select*from emp ee where e.sal=ee.sal and ename='SCOTT'); --- same salary as scott
select*from emp e where exists(select*from emp ee where ee.sal<e.sal and ename='SCOTT' ); -- more then scott sal

/*
--Not-exist--
*/
select*from dept d where not exists(select*from emp e where d.deptno=e.deptno);
--Generally not in dont work in null value there we can use co-related sub query with not exist
/*
--Special Operator-- 
--ALL, ANY--
in -> It return same value inthe list
<,> ALL ->it satisfies all value in the list
<,> ANY ->it satisfies any value in the list
in -> ANY

*/
select distinct(deptno)from emp where deptno> any(10,20);
select distinct(deptno)from emp where deptno> all(10,20);

--IN is same as =any
select*from emp where ename =any('SCOTT');

--NOT In is same as -- <>all
select*from dept where deptno <>all(20,30,10);
