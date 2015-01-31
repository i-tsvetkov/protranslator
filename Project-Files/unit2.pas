{ ProTranslator - програма за превод на програмен код

  Copyright (C) 2015 ProTranslator Team

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Grids,
  StdCtrls, Buttons, ExtCtrls, SynEdit, LCLProc;

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

function stripTags(s : string) : string;
function removeComments(s : string) : string;

implementation

uses
  Unit1;


{$R *.lfm}

{ TCommandFrm }

function stripTags(s : string) : string;
begin
  s:=StringReplace(s,         '`'  ,   '\`', [rfReplaceAll]);
  s:=StringReplace(s,         '\\`', '\\``', [rfReplaceAll]);
  s:=StringReplace(s,         '\`' ,     '', [rfReplaceAll]);
  stripTags:=StringReplace(s, '\`' ,    '`', [rfReplaceAll]);
end;

function removeComments(s : string) : string;
var
  sl  : TStringList;
  i   : Integer;
begin
  sl:=TStringList.Create;
  sl.Text:=s;
  for i:=0 to sl.Count-1 do
    if sl[i][1] = '#' then
      sl[i]:=UTF8Copy(sl[i], 2, UTF8Length(sl[i]));
  removeComments:=sl.Text;
  sl.Free;
end;

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
    s:=StringReplace(s, '\`', '', [rfReplaceAll]);
    while Length(s) > 0 do begin
      i:= Pos('`', s);
      if i = 0 then Break;
      Delete(s, 1, i);
      i:= Pos('`', s);
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
  PreviewSynEdit.Text:=stripTags(CommandFrm.sl.Text);
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
  s:=StringReplace(s, '`'+StringGrid.Cells[0,i]+'`', StringGrid.Cells[1,i], [rfReplaceAll]);
  s:=StringReplace(s, '\`', '`', [rfReplaceAll]);
  PreviewSynEdit.Text:=s;
end;

end.

