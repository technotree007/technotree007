 SET SERVEROUTPUT ON; 
 BEGIN
 DBMS_OUTPUT.PUT_LINE('WELCOME TO INDIA');
 END;
 /
--op--WELCOME TO INDIA

declare
a number(10);
b number(10):=5;
c number(10);

begin
a:=10;
c:=a*b;
DBMS_OUTPUT.PUT_LINE(c);
end;
/
--op--50

--Select..into clause--
--It is used to retrive data from table and store it into pl/sql variable.
--It always return single value or single record at a time
select*from emp;
select*from dept;

declare
vname varchar2(20);
vsal number(10);
begin
select ename,sal into vname,vsal from emp where empno=7788;
dbms_output.put_line(vname||'  '||vsal);
end;
/
--op------SCOTT  3000

declare
vnm varchar2(200) not null:='WE LOVE YOUR WORK';
vid  constant number(20):=11256;
begin
dbms_output.put_line(vnm);
dbms_output.put_line(vid);
end;
/

declare
vmx number(34);
vnm varchar2(20);
begin
select max(sal) into vmx from emp;
select ename into vnm from emp where sal=vmx;
dbms_output.put_line(vnm);
end;
/
--op--KING

declare
a number:=34;
b number:=76;
c number:=23;
d number;
begin
d:=greatest(a,b,c);
dbms_output.put_line(d);
end;
/
--op----76

--n pl/sql expression we are not allowed to use group function ,decode() conversion function
--But allowed to use number function character function,date function,date conversion function

declare
a varchar2(10):='ebanzy';
b varchar2(20);
begin
b:=upper(a);
DBMS_OUTPUT.put_line(b);
end;
/
--op---EBANZY