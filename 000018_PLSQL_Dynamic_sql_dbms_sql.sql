 /*
 --DYNAMIC SQL--
 --What is Dynamic SQL?--
 --Dynamic SQL is a programming methodology for generating and running statements at run-time. 
 It is mainly used to write the general-purpose and flexible programs where the SQL statements will be created and executed at run-time based on the requirement.
 
-- Ways to write dynamic SQL
PL/SQL provides two ways to write dynamic SQL

1.NDS – Native Dynamic SQL
2.DBMS_SQL
 */
 
 --NDS (Native Dynamic SQL) – Execute Immediate
 --Native Dynamic SQL is the easier way to write dynamic SQL. It uses the 'EXECUTE IMMEDIATE' command to create and execute the SQL at run-time. 
 
 DECLARE
lv_sql VARCHAR2(500);
lv_emp_name VARCHAR2(50):
ln_emp_no NUMBER;
ln_salary NUMBER;
ln_manager NUMBER;
BEGIN
ly_sql:='SELECT emp_name,emp_no,salary,manager FROM emp WHERE
emp_no=:empmo:';
EXECUTE IMMEDIATE lv_sql INTO lv_emp_name,ln_emp_no,ln_salary,ln_manager
USING 1001;
Dbms_output.put_line('Employee Name:'||lv_emp_name);
Dbms_output.put_line('Employee Number:'||ln_emp_no);
Dbms_output.put_line('Salary:'||ln_salaiy);
Dbms_output.put_line('Manager ID:'||ln_manager);
END;
/

/*
--DBMS_SQL for Dynamic SQL--
PL/SQL provide the DBMS_SQL package that allows you to work with dynamic SQL. The process of creating and executing the dynamic SQL contains the following process.

OPEN CURSOR:- The dynamic SQL will execute in the same way as a cursor. So in order to execute the SQL statement, we must open the cursor.
PARSE SQL:- The next step is to parse the dynamic SQL. This process will just check the syntax and keep the query ready to execute.
BIND VARIABLE Values:- The next step is to assign the values for bind variables if any.
DEFINE COLUMN:- The next step is to define the column using their relative positions in the select statement.
EXECUTE:- The next step is to execute the parsed query.
FETCH VALUES:- The next step is to fetch the executed values.
CLOSE CURSOR:- Once the results are fetched, the cursor should be closed.
*/


DECLARE
lv_sql VARCHAR2(500);
lv_emp_name VARCHAR2(50);
ln_emp_no NUMBER;
ln_salary NUMBER;
ln_manager NUMBER;
ln_cursor_id NUMBER;
ln_rows_processed NUMBER;;
BEGIN
lv_sql:='SELECT emp_name,emp_no,salary,manager FROM emp WHERE
emp_no=:empmo';
in_cursor_id:=DBMS_SQL.OPEN_CURSOR;

DBMS_SQL.PARSE(ln_cursor_id,lv_sql,DBMS_SQL.NATIVE);

DBMS_SQL.BIXD_VARLABLE(ln_cursor_id:'empno',1001);

DBMS_SQL.DEFINE_COLUMN(ln_cursor_ici,1,ln_emp_name);
DBMS_SQL.DEFINE_COLUMN(ln_cursor_id,2,ln_emp_no);
DBMS_SQL .DEFINE_COLUMN(ln_cursor_id,3,ln_salary);
DBMS_SQL .DEFINE_COLUMN(ln_cursor_id,4,ln_manager);

ln_rows__processed:=DBMS_SQL.EXECUTE(ln_cursor_id);
LOOP
IF DBMS_SQL.FETCH_ROWS(ln_cursor_id)=0
THEN
EXIT;
ELSE
DBMS_SQL.COLUMN_VALUE(ln_cursor_id,1,lv_emp_name); 
DBMS_SQL.COLUMN_VALUE(ln_cursor_id,2,ln_emp_no);
DBMS_SQL.COLUMN_VALUE(ln_cursor_id,3,In_salary);
DBMS_SQL.COLUMN_VALUE(ln_cursor_id,4,In_manager);
Dbms_output.put_line('Employee Name:'||lv_emp_name); 
Dbms_output.put_line('Employee Number:l'||ln_emp_no); 
Dbms_output.put_line('Salary:'||ln_salary); 
Dbms_output.put_line('Manager ID :'| ln_manager);
END IF;
END LOOP;

DBMS_SQL.CLOSE_CURSOR(ln_cursor_id);

END:
/