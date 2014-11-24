// да се въведе радиус на кръга и да се пресметне лицето и обиколката му
program krug;
const
  Pi = 3.14;
var
  R, S, P: Real;
begin
  Write('Vavedete radiusa:');
  ReadLn(R);

  S:= Pi*R*R;
  P:= 2*Pi*R;

  Writeln('Obikolkata na krugut e ', P:5:3);
  WriteLn('Liceto na krugut e ', S:5:3);
  ReadLn;
end.

