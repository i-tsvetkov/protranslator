unit Unit2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Buttons, ExtCtrls, SynEdit;

type

  { TCommandFrm }

  TCommandFrm = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Splitter1: TSplitter;
    StringGrid1: TStringGrid;
    SynEdit1: TSynEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
  private
    { private declarations }
  public
    { public declarations }
    sl: TStringList;
  end; 

var
  CommandFrm: TCommandFrm;

implementation

uses Unit1;

{$R *.lfm}

{ TCommandFrm }

procedure TCommandFrm.FormCreate(Sender: TObject);
begin
  sl:=TStringList.Create;
end;

procedure TCommandFrm.FormDestroy(Sender: TObject);
begin
  sl.Free;
end;

procedure TCommandFrm.FormShow(Sender: TObject);
var
  Params: TStringList;

  procedure ParseCommand(s: string);
  var
    i: integer;
    param: string;
  begin
    while Length(s) > 0 do begin
      i:= Pos('%', s);
      if i = 0 then Break;
      Delete(s, 1, i);
      i:= Pos('%', s);
      if i = 0 then Break;
      param:=Copy(s, 1, i-1);
      if Params.IndexOf(param)<0 then
        Params.Add(param);
      Delete(s, 1, i);
    end;
  end;
var i, j: Integer;
begin
  SynEdit1.Highlighter:=Form1.SynEdit1.Highlighter;
  SynEdit1.Text:= StringReplace(CommandFrm.sl.Text, '%', '', [rfReplaceAll]);
  Params:=TStringList.Create;
  ParseCommand(sl.Text);
  StringGrid1.RowCount:=Params.Count+1;
  for i:=1 to StringGrid1.RowCount-1 do
  begin
    StringGrid1.Cells[0,i]:=Params[i-1];
    StringGrid1.Cells[1,i]:=Params[i-1];
  end;
  Params.Free;
  {if ((s.Count-1) mod 2) = 0 then StringGrid1.RowCount:=((s.Count-1) div 2)+1
  else StringGrid1.RowCount:=(s.Count-1) div 2;}
  {i:=1;
  j:=1;
  while i < s.Count-1 do
  begin
    StringGrid1.Cells[0,j]:=s.Strings[i];
    i:=i+2;
    j:=j+1;
  end;}
end;

procedure TCommandFrm.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  i: Integer;
  s: String;
begin
  s:=sl.Text;
  for i:=0 to StringGrid1.RowCount-1 do
  s:=StringReplace(s, '%'+StringGrid1.Cells[0,i]+'%', StringGrid1.Cells[1,i], [rfReplaceAll]);
  SynEdit1.Text:=s;
end;

end.

