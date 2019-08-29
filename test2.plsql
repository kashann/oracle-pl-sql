begin
  --TEST
--1)show the first 5 clients that have a min total order value of (input). Throw exception if no such client exists
set serveroutput on;
accept x_val prompt "Min. total order value: ";
declare
cursor tot is select order_total from orders
       when order_total > &x_val order by order_total asc;
a integer;
nume varchar2(30);
prenume varchar2(30);
client_does_not_exist exception;
pragma
exception_init(client_does_not_exist, -20000);
begin
  select cust_first_name, cust_last_name, customer_id into nume, prenume, a from customers;
  for i in tot loop
    if(i.customer_id = a)
      exit when tot%rowcount=5;
      dbms_output.put_line(nume || ' ' || prenume);
    end if;
  end loop;
  exception
    when client_does_not_exist
      dbms_output.put_line('No such client exists!' || SQLCODE);
end;
/

--select * from customers c, orders o where c.customer_id = o.customer_id and o.order_total > 200000;

--2)Citire de la tastatura numar si afisare suma cifrelor impare
set serveroutput on;
accept nr prompt "NR=";
declare
n integer;
odd integer:=0;
d integer;

begin
  n:=&nr;
  while n!=0 loop
    d:=mod(n,10);
    if mod(d,2)=1 then
      odd:=odd+d;
    end if;
    n:=trunc(n/10);
  end loop;
  dbms_output.put_line('Sum of odd digits: ' || odd);
end;
/  