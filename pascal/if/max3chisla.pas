// �� �� ������� 3 ����� � �� �� �������� ���-�������� �� ���

program max3chisla;
var
  a, max: integer;
begin
  Write('Vavedete 1-vo chisl�:');
  Readln(a);
  max:= a;

  Write('Vavedete 2-ro chisl�:');
  Readln(a);
  if a > max then
    max:= a;

  Write('Vavedete 3-to chisl�:');
  Readln(a);
  if a > max then
    max:= a;

  WriteLn('Nai-goliamoto e ', max);
  ReadLn;
end.
