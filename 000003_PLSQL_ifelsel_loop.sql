/* --CONDITION STATEMENT--
IF,IF-ELSE,ELSIF
synx if-- 
if condition then
statement ;
end if;

synx if-else--
if condition then
statement;
else
statement;
end if;

synx elsif-- to check more number of condition
if condition1 then
statement
elsif condition2 then
statement
elsif condition3 then
statement
else
statement;
end if;

*/
SELECT*FROM EMP;
SELECT*FROM DEPT;

DECLARE
VD DEPT.DEPTNO%TYPE;
BEGIN
SELECT DEPTNO INTO VD FROM DEPT WHERE LOC='BOSTON';
IF VD=10 THEN
DBMS_OUTPUT.PUT_LINE('TEN');
ELSIF VD=20 THEN
DBMS_OUTPUT.PUT_LINE('TWENTY');
ELSIF VD=30 THEN
DBMS_OUTPUT.PUT_LINE('THIRTY');
ELSE
DBMS_OUTPUT.PUT_LINE('FOURTY');
END IF;
END;
/

/*--CONTROL STATEMENT/LOOP---
1)SIMPLE LOOP (SL)
2)WHILE LOOP (WL)
3)FOR LOOP (FL)
*/
--SL  -- This loop is also called infinity loop.Body of the loop statement executed repeteadely
/*synx
loop
statement
end loop;
*/

declare
a number:=1;
begin
loop 
dbms_output.put_line(a);
a:=a+1;
exit when a>10;
end loop;
end;
/

declare
b number:=1;
begin
loop
dbms_output.put_line(b);
b:=b+1;
if b>10 then
exit;
end if;
end loop;
end;
/
--WL  -- here body of loop statement are executed repeateadly untill condition is false
/* synx:-
while(condition true)
loop
statement
end loop;
*/
declare
a number := 1;
begin
while (a<10)
loop
dbms_output.put_line(a);
a:=a+1;
end loop;
end;
/
/*
--FL  --In for loop index variable internally behaves like a integer variable that why when we are using for loop not require to declare index variable
synx--
for index variable name lower bound .. upper bound
loop
statement;
end loop;
*/
begin
for i in 1..10
loop
dbms_output.put_line(i);
end loop;
end;
/

begin
for i in reverse 1..10
loop
dbms_output.put_line(i);
end loop;
end;
/

/*
Anonymous block:- Not alloweed to store permanetely in DB and these block dont have name,
not allowed to call in client application. 
ex:-
declare
begin
end;

Named block:- Allowed to store permanetely in DB, ex:- procedure,pkg,function
*/