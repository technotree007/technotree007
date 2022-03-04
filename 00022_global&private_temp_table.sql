/* Oracle Global Temporary Table
A temporary table is a table that holds data only for the duration of a session or transaction.
each session can only access its own data in the global temporary table.

synx:-
CREATE GLOBAL TEMPORARY TABLE table_name (
    column_definition,
    ...,
    table_constraints
) ON COMMIT [DELETE ROWS | PRESERVE ROWS];

---The ON COMMIT DELETE ROWS clause specifies that the global temporary table is transaction-specific. 
It means that Oracle truncates the table (remove all rows) after each commit.
---The ON COMMIT PRESERVE ROWS clause specifies that the global temporary table is session-specific,
meaning that Oracle truncates the table when you terminate the session, not when you commit a transaction.
--Oracle uses the ON COMMIT DELETE ROWS option by default

*/

CREATE GLOBAL TEMPORARY TABLE temp1(
    id INT,
    description VARCHAR2(100)
) ON COMMIT DELETE ROWS;

INSERT INTO temp1(id,description)
VALUES(1,'Transaction specific global temp table');

SELECT * FROM temp1;

commit;  ---Truncate the table

CREATE GLOBAL TEMPORARY TABLE temp2(
    id INT,
    description VARCHAR2(100)
) ON COMMIT PRESERVE ROWS;

INSERT INTO temp2(id,description)
VALUES(1,'Session specific global temp table');

COMMIT;  -- Not truncate the temp2 table

SELECT * FROM temp2;

--For truncate disconnect the current session
---Oracle allows you to create indexes on global temporary tables.
--By default, Oracle stores the data of the global temporary table in the default temporary tablespace of the table’s owner.
--rollback not possible

/*
Oracle Private Temporary Table
--Oracle 18c introduced private temporary tables whose both table definition and data are temporary and are dropped at the end of a transaction or session.
--On top of that, Oracle stores private temporary tables in memory and each temporary table is only visible to the session which created it.

--All private temporary tables have a prefix defined by the PRIVATE_TEMP_TABLE_PREFIX initialization parameter, which defaults to to ORA$PTT_.

synx:-
CREATE PRIVATE TEMPORARY TABLE table_name(
    column_definition,
    ...
) ON COMMIT [DROP DEFINITION | PRESERVE DEFINITION];


--The ON COMMIT DROP DEFINITION option creates a private temporary table that is transaction-specific. 
At the end of the transaction, Oracle drops both table definition and data.
--The ON COMMIT PRESERVE DEFINITION option creates a private temporary table that is session-specific. 
Oracle removes all data and drops the table at the end of the session.
--By default, Oracle uses ON COMMIT DROP DEFINITION
*/
--- support 18c
CREATE PRIVATE TEMPORARY TABLE ora$ppt_temp1(
    id INT,
    description VARCHAR2(100)
) ON COMMIT DROP DEFINITION;

INSERT INTO ora$ppt_temp1(id,description)
VALUES(1,'Transaction-specific private temp table');

SELECT id, description FROM ora$ppt_temp1;
COMMIT;

SELECT id, description FROM ora$ppt_temp1;
--ORA-00942: table or view does not exist

CREATE PRIVATE TEMPORARY TABLE ora$ppt_temp2(
    id INT,
    description VARCHAR2(100)
) ON COMMIT PRESERVE DEFINITION;

INSERT INTO ora$ppt_temp2(id,description)
VALUES(1,'Session-specific private temp table');

SELECT id, description FROM ora$ppt_temp2;

COMMIT;

SELECT id, description FROM ora$ppt_temp2;
--- you need to disconnect the session to drop

--Permanent database objects cannot directly reference private temporary tables.
--Indexes and materialized views cannot be created on private temporary tables.
--Columns of the private temporary table cannot have default values.
--Private temporary tables cannot be accessed via database links.