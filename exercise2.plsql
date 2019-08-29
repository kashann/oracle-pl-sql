set serveroutput on
declare
	v_val number;
begin
	select sum(unit_price*quantity) into v_val from order_items where product_id=2311;
	dbms_output.put_line('Value='||v_val);
end;
/

begin
	v_val:=v_val+150;
end;
/