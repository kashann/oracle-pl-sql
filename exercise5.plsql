BEGIN
    UPDATE NEW_CLIENTS SET
    NAME=:P5_NAME,
    CNP=:P5_CNP,
    ENR_DATE=:P5_ENR_DATE
    WHERE CLIENT_ID=:P5_CLIENT_ID;
END;

///////////////////

//1

declare
  e employees%rowtype;
begin
  select * into e from employees where employee_id=120;
  dbms_output.put_line('First Name = '||e.first_name||', Last Name = '||e.last_name||', Salary = '||e.salary);
end;


//2

declare
  type er is record(
    first_name varchar2(20),
    last_name employees.last_name%type,
    salary number);
  e er;
begin
  select first_name, last_name, salary into e from employees where employee_id=120;
  dbms_output.put_line('First Name = '||e.first_name||', Last Name = '||e.last_name||', Salary = '||e.salary);
end;


//3

declare
  type er is record(
    first_name varchar2(20),
    last_name employees.last_name%type,
    salary number);
  type ibt is table of er index by pls_integer;
  e ibt;
begin
  select first_name, last_name, salary bulk collect into e from employees where employee_id>=120 order by salary desc;
    /** desc fetch first 4 rows only;
             fetch first 4 rows with ties; //works only on PL-SQL, not APEX **/
  dbms_output.put_line('NO employees: '||e.count);
  for i in e.first..e.last loop
    dbms_output.put_line('First Name = '||e(i).first_name||', Last Name = '||e(i).last_name||', Salary = '||e(i).salary);
  end loop;
end;