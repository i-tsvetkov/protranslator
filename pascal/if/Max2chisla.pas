// �� �� ������� ��� ����� � �� �� �������� ��-�������� �� ���

program Max2chisla;
var
  a, b, max: integer;
begin
  Write('Vavedete dve chisla:');
  Readln(a, b);
  if a > b then
    max:= a
  else max:= b;
  WriteLn('Po-goliamoto e ', max);
  ReadLn;
end.

