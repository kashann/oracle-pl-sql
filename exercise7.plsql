update orders o set o.order_date=sysdate where o.order_id between 2354 and 2400;
/** commit; **/

declare
  cursor c is
    select t.category_id, sum(oi.unit_price*oi.quantity) val from product_information t 
    join order_items oi on t.product_id=oi.product_id join orders o on o.order_id=oi.order_id
    where extract(year from o.order_date)=extract(year from sysdate)-14 /**-14 because i was unable to run update on apex**/
    group by t.category_id having sum(oi.unit_price*oi.quantity)>50000 order by val desc;
  r c%rowtype;
begin
  if not c%isopen then
    open c;
  end if;

  /**loop
    fetch c into r;
    exit when c%notfound;
    dbms_output.put_line('i='||c%rowcount);
    dbms_output.put_line(r.category_id||' '||r.val);
  end loop;**/

  fetch c into r;
  while c%found loop
    dbms_output.put_line('i='||c%rowcount);
    dbms_output.put_line(r.category_id||' '||r.val);
    fetch c into r;
  end loop;
  close c;
end;

begin /**added open/close cursor+exceptions**/
  --open c;
  for r in c loop /**second varianta**/
    /**exit when c%rowcount=4;**/
    /**dbms_output.put_line('i='||c%rowcount);**/
    dbms_output.put_line(r.category_id||' '||r.val);
  end loop;
  --close c;
  exception
    when cursor_already_open then
      dbms_output.put_line('Cursor already opened');
    when invalid_cursor then
      dbms_output.put_line('Cursor already closed');
    when others then
      dbms_output.put_line('Another exception occured:'||SQLCODE);
end;


begin /**inline cursor**/
  for r in (select t.category_id, sum(oi.unit_price*oi.quantity) val from product_information t 
    join order_items oi on t.product_id=oi.product_id join orders o on o.order_id=oi.order_id
    where extract(year from o.order_date)=extract(year from sysdate)-14 /**-14 because i was unable to run update on apex**/
    group by t.category_id having sum(oi.unit_price*oi.quantity)>50000 order by val desc) loop
    dbms_output.put_line(r.category_id||' '||r.val);
  end loop;
end;