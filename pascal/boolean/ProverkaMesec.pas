// �� �� ������ ����� � �� �� �������� True ��� � ������� �����
 
program ProverkaMesec;
var
  chislo: integer;
  proverka: Boolean;
begin
  Write('Vavedete chislo:');
  ReadLn(chislo);
  proverka:= (chislo>=1) and (chislo<=12);
  WriteLn('Validen mesec:', proverka);
  ReadLn;
end.

