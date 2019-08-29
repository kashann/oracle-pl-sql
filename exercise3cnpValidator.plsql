declare
  s number:=0;
  s_odd number:=0;
  s_even number:=0;
begin
  for i in 120..237 loop
    s:=s+i;
    if i mod 2 = 0 then
      s_even:=s_even+i;
    else
      s_odd:=s_odd+i;
    end if;
  end loop;
  dbms_output.put_line('The sum is '||s);
  dbms_output.put_line('The sum of odd numbers is '||s_odd);
  dbms_output.put_line('The sum of even numbers is '||s_even);
end;


/**/


declare
  v_weights char(12):='279126358279'; /*try to change a number so the cnp will not be valid anymore*/
  v_cnp char(13):='1891011178460';
  s number:=0;
  cc number;
begin
  for i in 1..length(v_weights) loop
    s:=s+substr(v_weights,i,1)*substr(v_cnp,i,1);
  end loop;
  cc:=s mod 11;
  if cc=10 and substr(v_cnp,13,1)=1 then
    dbms_output.put_line('The CNP is valid!');
  elsif cc=substr(v_cnp,13,1) then
    dbms_output.put_line('The CNP is valid!');
  else
    dbms_output.put_line('The CNP is NOT valid!');
  end if;
end;

/* The same code but put in APEX, :=: is used for BIND VARIABLES (unique vars for ex used for text boxes)*/

declare
  v_weights char(12):='279126358279';
  v_cnp char(13):=:P3_CNP;
  s number:=0;
  cc number;
begin
  for i in 1..length(v_weights) loop
    s:=s+substr(v_weights,i,1)*substr(v_cnp,i,1);
  end loop;
  cc:=s mod 11;
  if cc=10 and substr(v_cnp,13,1)=1 then
    :P3_RESULT:='The CNP is valid!';
  elsif cc=substr(v_cnp,13,1) then
    :P3_RESULT:='The CNP is valid!';
  else
    :P3_RESULT:='The CNP is NOT valid!';
  end if;
end;