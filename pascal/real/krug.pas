// да се въведе радиус и да се пресметне лице и обиколка на кръг

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

  Writeln('Obikolkata e ', P:5:3);
  WriteLn('Liceto e ', S:5:3);
  ReadLn;
end.

