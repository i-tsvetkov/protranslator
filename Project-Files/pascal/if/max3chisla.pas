// да се въведат 3 числа и да се отпечата най-голямото от тях
program max3chisla;
var
  a, max: integer;
begin
  Write('Vavedete 1-vo chislо:');
  Readln(a);
  max:= a;

  Write('Vavedete 2-ro chislо:');
  Readln(a);
  if a > max then
    max:= a;

  Write('Vavedete 3-to chislо:');
  Readln(a);
  if a > max then
    max:= a;

  WriteLn('Nai-goliamoto e ', max);
  ReadLn;
end.
