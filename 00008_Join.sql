 /*--JOIN--
 --When we are joining (n) number of table to join , then there must be (n-1)condition
 8i Join                              9i Join
 -----------------------------------------------------------
 1)equi join or inner join       1)inner join
 2)Non equi join                 2)left outer join
 3)self join                     3)right outer join
 4)outer join                    4)full outer join
                                 5)natural join
 --oracle by default join is cross join
  */
-- 8i--Equi Join-- joining condition column must have same datatype
select e.ename,d.dname from emp e, dept d
where e.deptno=d.deptno;

select*from emp;
select*from dept;
select*from salgrade;
select*from bonus;

select e.ename,e.job,e.deptno,d.loc from emp e,dept d
where e.deptno=d.deptno
and lower(d.loc) in (lower('chicago'),lower('dALLaS'));

select d.dname,sum(e.sal)
from emp e, dept d
where e.deptno=d.deptno
group by d.dname;

select d.dname,sum(e.sal)
from emp e, dept d
where e.deptno=d.deptno
group by d.dname
having sum(e.sal)>9000;

--Outer Join-- a.col1(+)=b.col1  -- match row from a and all row from b
select e.ename,d.dname,d.loc from emp e,dept d
where e.deptno(+)=d.deptno;

select e.ename,d.dname,d.loc from emp e,dept d
where e.deptno=d.deptno(+);

-- NON EQUI Join-- (<>,>,<)
create table t1(dn number, sl number);
create table t2(dn number, sl number);
alter table t1 modify(dn varchar2(10));
alter table t2 modify(dn varchar2(10));
insert into t1 values(:dn,:sl);
insert into t2 values(:dn,:sl);
SELECT*FROM T1;
select*from t2;

select a.dn,a.sl,b.dn,b.sl
from t1 a,t2 b
where a.sl>b.sl;

select a.dn,a.sl,b.dn,b.sl
from t1 a,t2 b
where a.sl<>b.sl;

--- Self Join-- join a table to it self is known as self join
select a.ename Manager, b.ename employee
from emp a, emp b
where a.empno=b.mgr;

select b.ename employee,b.hiredate
from emp a, emp b
where a.empno=b.mgr
and a.hiredate<b.hiredate;

--9i--are more faster than 8i-- Inner Join -- return matching rows only 

select e.ename,d.dname from emp e join dept d
on e.deptno = d.deptno;

select e.ename,d.dname from emp e inner join dept d
on e.deptno = d.deptno;

select e.ename,d.dname,t.dn
from emp e
inner join dept d on e.deptno=d.deptno
inner join t1 t on e.deptno=t.sl;

select e.ename,d.dname
from emp e inner join dept d
using (deptno);

select ename, dname,cname
from emp e
inner join dept d using(deptno)
inner join company using(cno)
order by ename asc,
cname desc;

--left outer join--
select a.dn,a.sl,b.dn,b.sl
from t1 a left outer join t2 b 
on a.sl=b.sl;

--left outer join--
select a.dn,a.sl,b.dn,b.sl
from t1 a right outer join t2 b
on a.sl=b.sl;

-- full outer join --
select a.dn,a.sl,b.dn,b.sl
from t1 a full outer join t2 b
on a.sl=b.sl;

--Natural join-- this also return matching rows but here joing condition is not require
select ename,dname 
from emp natural join dept;

---cross join--
select ename,dname
from emp cross join dept;

