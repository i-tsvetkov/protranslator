// �� �� ������� 3 ����� � �� �� �������� ���-�������� �� ���

program max3chisla2;
var
  a, b, c, max: integer;
begin
  Write('Vavedete tri chisla:');
  Readln(a, b, c);
  if (a>=b) and (a>=c) then
    max:= a;
  if (b>=a) and (b>=c) then
    max:= b;
  if (c>=a) and (c>=b) then
    max:= c;
  WriteLn('Nai-goliamoto e ', max);
  ReadLn;
end.
