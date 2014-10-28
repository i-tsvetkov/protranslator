// да се въведат двата катета на правоъгълен триъгълник и да се пресметне хипотенузата му

program hipotenuza;
var
  a, b, c: real;
begin
  Write('vavedete katetite (a i b):');
  ReadLn(a, b);

  c:=sqrt(a*a + b*b);

  WriteLn('Hiputenuzata e ', c:5:2);

  ReadLn;
end.

