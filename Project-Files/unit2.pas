unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Grids,
  StdCtrls, Buttons, ExtCtrls, SynEdit;

type

  { TCommandFrm }

  TCommandFrm = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Splitter1: TSplitter;
    StringGrid: TStringGrid;
    PreviewSynEdit: TSynEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
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

uses
  Unit1;


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
var i : Integer;
begin
  PreviewSynEdit.Color:=MainForm.MainSynEdit.Color;
  PreviewSynEdit.Gutter.Parts.Part[0].MarkupInfo.Foreground:=MainForm.MainSynEdit.Gutter.Parts.Part[0].MarkupInfo.Foreground;
  PreviewSynEdit.Gutter.Parts.Part[0].MarkupInfo.Background:=MainForm.MainSynEdit.Gutter.Parts.Part[0].MarkupInfo.Background;
  PreviewSynEdit.LineHighlightColor.Background:=MainForm.MainSynEdit.LineHighlightColor.Background;
  PreviewSynEdit.Font.Size:=MainForm.MainSynEdit.Font.Size;

  PreviewSynEdit.Highlighter:=MainForm.MainSynEdit.Highlighter;
  PreviewSynEdit.Text:= StringReplace(CommandFrm.sl.Text, '%', '', [rfReplaceAll]);
  Params:=TStringList.Create;
  ParseCommand(sl.Text);
  StringGrid.RowCount:=Params.Count+1;
  for i:=1 to StringGrid.RowCount-1 do
  begin
    StringGrid.Cells[0,i]:=Params[i-1];
    StringGrid.Cells[1,i]:=Params[i-1];
  end;
  Params.Free;
end;

procedure TCommandFrm.StringGridSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  i: Integer;
  s: String;
begin
  s:=sl.Text;
  for i:=0 to StringGrid.RowCount-1 do
  s:=StringReplace(s, '%'+StringGrid.Cells[0,i]+'%', StringGrid.Cells[1,i], [rfReplaceAll]);
  PreviewSynEdit.Text:=s;
end;

end.


