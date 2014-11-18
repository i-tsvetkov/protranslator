// да се напише програма която решава линейно уравнение от вида ax+b=0
program lineino;
var
  a, b, x: real;
begin
  Write('a=');
  ReadLn(a);
  Write('b=');
  ReadLn(b);
  if a=0 then
    if b=0 then
      WriteLn('Vsiqko X e reshenie')
    else WriteLn('Niama reshenie')
  else begin
    x:= -b/a;
    WriteLn('x=',x:5:2);
  end;
  ReadLn;
end.

