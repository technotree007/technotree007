-- character function--
--upper()
select upper('abi') from dual;--ABI
select upper(ename)from emp;
--lower()
select lower('INDIA') from dual;  --india
--initcap()
select initcap('abiNash')from dual; --Abinash
--length()
select length('abinash ssahoo')from dual; --14
select*from emp where length(ename)=5;
--substr() 
select substr('abcdefg',3)from dual;--cdefg
select substr('abcdefg',-3)from dual;--efg
select substr('abcdefg',3,2)from dual;--cd
select substr('abcdefg',3,-2)from dual;  --null
select substr('abcdefg',-3,-2)from dual;--null
select substr('abcdefg',-3,2)from dual;  --ef
select * from emp where lower(substr(ename,2,2))='la';
--- instr() --
select instr('abcd','z') from dual;  ---0
select instr('abcd','c')from dual;   --3
select instr('abcdefghcdjklcdw','cd',4)from dual;  -- 9
select instr('abcdefghcdjklcdw','cd',1,2)from dual;  --9
select instr('abcdercd','cd',-1) from dual; --7
---lpad(), rpad()--
select lpad('ABI',5,'#')from dual; --##ABI
select lpad('BAPUN',4,'$')FROM DUAL; --BAPU
select rpad('RAT',5,'$')from dual; --RAT$$
-- ltrim(),rtrim(),trim() --
select ltrim('AAindiaAA','A')from dual;  --indiaAA
select rtrim('AAindiaAA','A')from dual; --AAindia
select ename,ltrim(ename,'SAC') from emp; --SMITH->MITH ,ALLEN->LLEN,CLARK->LARK
select trim('A' from 'AAindiaAA')from dual;  --india
select trim(leading 'A'from 'ABA')from dual; --BA
select trim(trailing 'A' from 'ABA')from dual;  --AB
---translate(),replace() ---
select translate('india','in','xy')from dual; ---xydxa
select replace('india','in','xy')from dual;  --xydia
select replace('XAXBIXXNAXSHX','X')from dual; --ABINASH
--concat()--
select concat(ename,empno)from emp;
select concat('ABINASH',' SAHOO')from dual;  --ABINASH SAHOO
