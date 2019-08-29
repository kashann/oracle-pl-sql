create or replace function LATEST_DATE(dep_id in employees.department_id%type)
return employees.hire_date%type
is
result_date employees.hire_date%type;
begin
select max(hire_date) into result_date from employees where department_id=dep_id;
return result_date;
end;
/

declare
result_date employees.hire_date%type;
begin
result_date:=latest_date(20);
dbms_output.put_line('The latest date is: ' || result_date);
end;
/

select department_id, department_name, latest_date(department_id) l_date from departments where extract(year from latest_date(department_id))>=1998;


create or replace function LATEST_DATE(dep_id in employees.department_id%type)
return employees.hire_date%type
is
result_date employees.hire_date%type;
begin
select max(hire_date) into result_date from employees where department_id=dep_id;
return result_date;
end;


create or replace PACKAGE group_1051 is
function latest_date(dep_id in employees.department_id%type) return employees.hire_date%type;
function avg_sal_dep(dep_id in employees.department_id%type) return number;
end;

select department_id, department_name, group_1052.avg_sal_dep(department)id) avgSal, group1051.latest_date(department_id) l_date
from departments where group_1051.avg_sal_dep(department_id)>5000;