// да се въведат две числа и да се отпечата частното им
program chastno2chisla;
var
  a, b: integer;
  chastno: real;
begin
  Write('Vavedete dve chisla:');
  Readln(a, b);
  if b <> 0 then
  begin
    chastno:= a / b;
    WriteLn('Chastnoto e ', chastno:5:2);
  end
  else WriteLn('Nevazmozno e delenie na nula!');
  ReadLn;
end.

