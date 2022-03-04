select*from emp;
--max()
select max(sal)from emp;  --5000
--min()
select min(sal)from emp;  --800
select max(sal),min(sal)from emp;
--avg()
select avg(sal)from emp;  --2073.214285714285714285714285714285714286
--sum()
select sum(sal) from emp;  --29025
--count(*)
select deptno,count(*) from emp group by deptno;
select count(ename)from emp; --14

select deptno,max(sal) xx from emp group by deptno order by xx desc;
select*from emp order by ename asc;
select deptno, count(deptno) from emp group by deptno having count(deptno)>3;
select deptno, sum(sal) from emp group by deptno having sum(sal)>10000;

--cube () --> total sal, per job,per dept, dept-job sal
select deptno,job,sum(sal) from emp group by cube(deptno,job);
--rollup() -> job-dept sal,dept sal,total sal
select job, deptno,sum(sal) from emp group by rollup(deptno,job);
