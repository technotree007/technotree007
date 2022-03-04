/*operator
1)Arithmatic Operator (/,*,-,+)
2)Relational Operator (=,<,>,=<,=>,<>,!=)
3)Logical Operator (AND,OR)
4)Special Operator(IN,NOT IN,BETWEEN,NOT BETWEEN,IS NULL, IS NOT NULL,LIKE,NOT LIKE)
*/

select*from emp;
select*from emp where deptno in(10,30);
select*from emp where deptno not in(10,30);
--NOT IN operator not work in null values.---
select*from emp where comm is null;
select*from emp where comm is not null;
/* NVL() and NVL2()
NVL(exp1,exp2) if exp1 is null return exp2 otherwise return exp1
NVL(NULL,20) -> 20
NVL(30,20)-> 30
NVL2(exp1,exp2,exp3)if exp1 is null return exp3 otherwise return exp2
NVL2(NULL,30,20) -> 20
NVL2(10,30,20)-> 30
*/

select ename, sal+nvl(comm,1)from emp;
select ename,comm, sal+nvl2(comm,2,1)from emp;
select*from emp where sal between 2000 and 5000;
select*from emp where sal not between 2000 and 5000;

/*
In like operator we are using %,_ (underscore), which is known as wild card character
*/
select*from emp where ename like 'M%'; -- letter start with M at first
select*from emp where ename like '%N';  -- letter end with N at last
select*from emp where ename like '%A%';  --- anywhere it is present 
select*from emp where ename like '_L%';  --- second letter L
select*from emp where ename like '__A%';  ---third letter A
--if any wild card character present --
select*from emp where ename like 'S?_%'escape'?';
-- we are using escape function to escape special meaning of wild card character;
--CONCATENATE Operator--
select 'My name is '||ename from emp;
select ename||' '||sal txt from emp;
