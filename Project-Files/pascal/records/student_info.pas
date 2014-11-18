// да се въведе в запис информацията за ученик и да се отпечата в подходящ вид
program student_info;
type
  UchenikDanni = record
    Ime: string;
    Prezime: string;
    Familia: string;
    Clas: byte;
    Paralelka: char;
  end;

var
  Uchenik: UchenikDanni;
begin
  Write('Vavedete ime:');
  ReadLn(Uchenik.Ime);
  Write('Vavedete prezime:');
  ReadLn(Uchenik.Prezime);
  Write('Vavedete familia:');
  ReadLn(Uchenik.Familia);
  Write('Vavedete clas:');
  ReadLn(Uchenik.Clas);
  Write('Vavedete paralelka:');
  ReadLn(Uchenik.Paralelka);
  WriteLn;
  WriteLn('Vie vavedohte slednite danni:');
  with Uchenik do
    WriteLn(Ime, ' ', Prezime, ' ', Familia, ', ', Clas, Paralelka);
  readln;
end.

