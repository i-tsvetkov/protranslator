unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, StdCtrls, ActnList, StdActns, SynHighlighterCpp,
  SynHighlighterPas, SynEdit, SynHighlighterAny, INIFiles, Unit2, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    KeywordInfoAction: TAction;
    ApplicationProperties1: TApplicationProperties;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem3: TMenuItem;
    ExamplesMI: TMenuItem;
    EditKeyWordsAction: TMenuItem;
    MenuItem4: TMenuItem;
    ErrorsMI: TMenuItem;
    SaveAsMI: TMenuItem;
    SourceCodeMI: TMenuItem;
    MenuItem6: TMenuItem;
    ParallelTB: TToolButton;
    TranslateTextMI: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenInEditorAction: TAction;
    EditRedoAction: TAction;
    EditCopyAction: TEditCopy;
    EditCutAction: TEditCut;
    EditDeleteAction: TEditDelete;
    EditPasteAction: TEditPaste;
    EditSelectAllAction: TEditSelectAll;
    EditUndoAction: TEditUndo;
    MenuItem2: TMenuItem;
    ShowKeyWordMI: TMenuItem;
    ShowKeyWordAction: TAction;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    FileMI: TMenuItem;
    MenuItem1: TMenuItem;
    Separator4MI: TMenuItem;
    ParallelMI: TMenuItem;
    Separator3MI: TMenuItem;
    Separator2MI: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    DeleteMI: TMenuItem;
    SelectAllMI: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    TranslateNowTB: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    TranslateNowMI: TMenuItem;
    TranslateNowToCppMI: TMenuItem;
    TranslateNowToPasMI: TMenuItem;
    SyntaxMI: TMenuItem;
    OpenMI: TMenuItem;
    HelpMI: TMenuItem;
    SyntaxCppMI: TMenuItem;
    SyntaxPasMI: TMenuItem;
    InstructionsMI: TMenuItem;
    AboutMI: TMenuItem;
    SettingsMI: TMenuItem;
    InsertConstructionsMI: TMenuItem;
    InsertConstructionsDialogMI: TMenuItem;
    SaveMI: TMenuItem;
    Separator1MI: TMenuItem;
    ExitMI: TMenuItem;
    EditMI: TMenuItem;
    TranslateMI: TMenuItem;
    UndoMI: TMenuItem;
    RedoMI: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    StatusBar1: TStatusBar;
    SynCppSyn1: TSynCppSyn;
    SynEdit1: TSynEdit;
    SynEdit2: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    ToolBar1: TToolBar;
    procedure AboutMIClick(Sender: TObject);
    procedure ApplicationProperties1DropFiles(Sender: TObject;
      const FileNames: array of String);
    procedure EditKeyWordsActionClick(Sender: TObject);
    procedure ErrorsMIClick(Sender: TObject);
    procedure ExitMIClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure InsertConstructionsMIClick(Sender: TObject);
    procedure InstructionsMIClick(Sender: TObject);
    procedure KeywordInfoActionExecute(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure SaveAsMIClick(Sender: TObject);
    procedure OpenInEditorActionExecute(Sender: TObject);
    procedure OpenMIClick(Sender: TObject);
    procedure ParallelMIClick(Sender: TObject);
    procedure SaveMIClick(Sender: TObject);
    procedure ShowKeyWordActionExecute(Sender: TObject);
    procedure SynEdit1Change(Sender: TObject);
    procedure SynEdit1Click(Sender: TObject);
    procedure SynEdit1ClickLink(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SynEdit1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SynEdit1StatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SynEdit2Change(Sender: TObject);
    procedure SynEdit2StatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SyntaxCppMIClick(Sender: TObject);
    procedure SyntaxPasMIClick(Sender: TObject);
    procedure TranslateNowMIClick(Sender: TObject);
    procedure TranslateNowToCppMIClick(Sender: TObject);
    procedure TranslateNowToPasMIClick(Sender: TObject);
    procedure EditCopyActionExecute(Sender: TObject);
    procedure EditCopyActionUpdate(Sender: TObject);
    procedure EditCutActionExecute(Sender: TObject);
    procedure EditCutActionUpdate(Sender: TObject);
    procedure EditDeleteActionExecute(Sender: TObject);
    procedure EditDeleteActionUpdate(Sender: TObject);
    procedure EditPasteActionExecute(Sender: TObject);
    procedure EditPasteActionUpdate(Sender: TObject);
    procedure EditRedoActionExecute(Sender: TObject);
    procedure EditRedoActionUpdate(Sender: TObject);
    procedure EditSelectAllActionExecute(Sender: TObject);
    procedure EditSelectAllActionUpdate(Sender: TObject);
    procedure EditUndoActionExecute(Sender: TObject);
    procedure EditUndoActionUpdate(Sender: TObject);
  private
    Functions, Keywords: TStringList;
    HintWindow : THintWindow;
    function GetWordDesc(const AWord: string): string;
    procedure LoadExample(Sender: TObject);
    procedure LoadSyntax(const KeywordDesc, CommandsFile, FunctionsFile: string);
    procedure OpenFile(const AFileName: string);
    procedure Translate(const FromFile, ToFile: string);
  public
    { public declarations }
    IniExamples: TMemIniFile;
    CommandsIni: TMemIniFile;
    ExamplesFile: String;
  end; 

var
  Form1: TForm1; 

implementation

{$R *.lfm}

uses
   ShellApi, SynEditTypes;

procedure OpenFileInEditor(const AFileName: string);
begin
    ShellExecute(Form1.Handle, PChar ('open'), PChar (AFileName), PChar (''), PChar (''), 1);
end;

{ TForm1 }

procedure TForm1.SynEdit1StatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if SynEdit1.TopLine<>SynEdit2.TopLine then SynEdit2.TopLine:=SynEdit1.TopLine;
end;

procedure TForm1.SynEdit2Change(Sender: TObject);
begin

end;

procedure TForm1.SaveMIClick(Sender: TObject);
begin
  //if SaveDialog1.Execute then
    SynEdit1.Lines.SaveToFile(OpenDialog1.FileName);
end;

procedure TForm1.ShowKeyWordActionExecute(Sender: TObject);
var word: String;
begin
  if SynEdit2.Focused then
    word:=SynEdit2.GetWordAtRowCol(SynEdit1.CaretXY)
  else word:=SynEdit1.GetWordAtRowCol(SynEdit1.CaretXY);
    // маркира думата, върху която е курсора
    if ShowKeyWordAction.Checked then begin
       SynEdit1.SetHighlightSearch(word, [ssoWholeWord, ssoEntireScope]);
       SynEdit2.SetHighlightSearch(word, [ssoWholeWord, ssoEntireScope]);
    end
    else begin
     SynEdit1.SetHighlightSearch('', [ssoEntireScope]);
     SynEdit2.SetHighlightSearch('', [ssoEntireScope]);
    end;
end;

procedure TForm1.SynEdit1Change(Sender: TObject);
begin

end;

procedure TForm1.SynEdit1Click(Sender: TObject);
var word: String;
begin
    word:=SynEdit1.GetWordAtRowCol(SynEdit1.CaretXY);
   StatusBar1.SimpleText:= SysToUTF8(Keywords.Values[word]);
end;

function TForm1.GetWordDesc(const AWord: string): string;
var
  Section: TStringList;
begin
  Result:= Functions.Values[AWord];
  if Result <> '' then Exit;
  if CommandsIni.SectionExists(AWord) then begin
    Section:= TStringList.Create;
    CommandsIni.ReadSectionValues(AWord, Section);
    Result:= Section.Text;
    Section.Free;
  end
  else Result:= Keywords.Values[AWord];
end;

procedure TForm1.SynEdit1ClickLink(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeywordInfoAction.Execute;
end;

procedure TForm1.SynEdit1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  HideDistance = 50;
begin
  with HintWindow do
    if Visible and ((Abs(Left-Mouse.CursorPos.X)>HideDistance) or
                   ((Abs(Top-Mouse.CursorPos.Y)>HideDistance))) then
      Hide;
end;

procedure TForm1.OpenFile(const AFileName: string);
begin
  SynEdit1.Lines.LoadFromFile(AFileName);
  SynEdit1.Text:=SysToUTF8(SynEdit1.Text);
  if Pos(ExtractFileExt(AFileName),
         '.c .cc .cpp .cs .cxx .h .hpp .hxx') <> 0 then
    SyntaxCppMI.Click;
  if Pos(ExtractFileExt(AFileName), '.inc .p .pas .pp') <> 0 then
    SyntaxPasMI.Click;
  Caption:= 'ProTranslator - '+ SysToUTF8(AFileName);
  OpenDialog1.FileName:=AFileName;
  TranslateNowMI.Enabled:=true;
  TranslateNowToCppMI.Enabled:=true;
  TranslateNowToPasMI.Enabled:=true;
  TranslateNowTB.Enabled:=true;
end;

procedure TForm1.OpenMIClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
         OpenFile(OpenDialog1.FileName);
         SaveMI.Enabled := true;
         ToolButton3.Enabled:= true;
         SaveAsMI.Enabled := true;
    end;
end;

procedure TForm1.ExitMIClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ApplicationProperties1DropFiles(Sender: TObject;
  const FileNames: array of String);
begin
  if Length(FileNames) > 0 then
    OpenFile(FileNames[0]);
end;

procedure TForm1.AboutMIClick(Sender: TObject);
begin
  if FileExists('About.html') then OpenFileInEditor('About.html');
end;

procedure TForm1.EditKeyWordsActionClick(Sender: TObject);
begin
  if SyntaxPasMI.Checked and FileExists('KeyWordsPas.txt') then OpenFile('KeyWordsPas.txt');
  if SyntaxCppMI.Checked and FileExists('KeyWordsCpp.txt') then OpenFile('KeyWordsCpp.txt');
end;

procedure TForm1.ErrorsMIClick(Sender: TObject);
begin
  if FileExists('Errors.txt') then OpenFile('Errors.txt')
  else ShowMessage('Няма грешки');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ExamplesFile:='Examples.ini';
  HintWindow := THintWindow.Create(self);
  HintWindow.AutoHide:= True;
  HintWindow.HideInterval:= 5000;
  Functions:= TStringList.Create;
  Keywords:= TStringList.Create;
  CommandsIni:= TMemIniFile.Create('');
  SyntaxPasMI.Click;

  SaveMI.Enabled:= false;
  ToolButton3.Enabled:= false;
  SaveAsMI.Enabled:= false;

  if Application.ParamCount > 0 then
    if FileExists(Application.Params[1]) then
      OpenFile(Application.Params[1]);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  CommandsIni.Free;
  Functions.Free;
  Keywords.Free;
end;

procedure TForm1.InsertConstructionsMIClick(Sender: TObject);
begin
  Panel1.Visible:=not Panel1.Visible;
  Splitter1.Visible:=not Splitter1.Visible;
  if Splitter1.Visible then
    Splitter1.Left:= Panel1.Left-1;
end;

procedure TForm1.InstructionsMIClick(Sender: TObject);
begin
  if FileExists('Help.html') then OpenFileInEditor('Help.html');
end;

procedure TForm1.KeywordInfoActionExecute(Sender: TObject);
var
  Rect: TRect;
  word, desc: String;
  P: TPoint;
begin
   word:=SynEdit1.GetWordAtRowCol(SynEdit1.CaretXY);
   desc:= GetWordDesc(word);
   if desc =  '' then Exit;
   Rect := HintWindow.CalcHintRect(0, SysToUTF8(desc),nil);
   P:= SynEdit1.RowColumnToPixels(SynEdit1.CaretXY);
   P:= SynEdit1.ClientToScreen(P);
   OffsetRect(Rect, P.X, P.Y);
   Delete(desc, 1, Pos(',', desc));
   HintWindow.ActivateHint(Rect,SysToUTF8(desc));
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  if ListBox1.ItemIndex>=0 then
    CommandsIni.ReadSectionValues(ListBox1.Items[ListBox1.ItemIndex], Memo1.Lines);
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var
  Spaces: String;
  i: Integer;
begin
  if (ListBox1.Items.Count = 0) or (ListBox1.ItemIndex < 0) then Exit;
  CommandsIni.ReadSectionValues(ListBox1.Items[ListBox1.ItemIndex], CommandFrm.sl);
  if not InsertConstructionsDialogMI.Checked then
  begin
    for i:=0 to SynEdit1.CaretX-2 do
      Spaces:=Spaces+' ';
    for i:=1 to CommandFrm.sl.Count-1 do
      CommandFrm.sl.Strings[i]:=Spaces+CommandFrm.sl.Strings[i];
    CommandFrm.sl.Text:=StringReplace(CommandFrm.sl.Text, '%', '', [rfReplaceAll]);
    SynEdit1.SelText:=CommandFrm.sl.Text;
  end
  else
  begin
     if CommandFrm.ShowModal = mrOK then
        SynEdit1.SelText:=CommandFrm.SynEdit1.Text;
  end;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  OpenFileInEditor('http://www.protranslator.gymnasium-lom.com/');
end;

procedure TForm1.SaveAsMIClick(Sender: TObject);
var
  saveDialog : TSaveDialog;
begin
    saveDialog := TSaveDialog.Create(self);
    saveDialog.Title := 'Запиши като';
    saveDialog.InitialDir := GetCurrentDir;
    saveDialog.Filter := 'Pascal file|*.pas| Text file |*.txt|';
    saveDialog.DefaultExt := 'pas';
    saveDialog.FilterIndex := 1;

    if saveDialog.Execute
       then ShowMessage('File : '+saveDialog.FileName)
       else ShowMessage('Save file was cancelled');

  // Free up the dialog
  saveDialog.Free;
end;

procedure TForm1.OpenInEditorActionExecute(Sender: TObject);
begin
  OpenFileInEditor(OpenDialog1.FileName);
end;

procedure TForm1.ParallelMIClick(Sender: TObject);
begin
  SynEdit2.Visible:=not SynEdit2.Visible;
  Splitter2.Visible:=not Splitter2.Visible;
  SynEdit2.Highlighter:=SynEdit1.Highlighter;
  if SyntaxCppMI.Checked then SynEdit2.Lines.LoadFromFile(GetTempDir+'ProTranslator.cpp');
  if SyntaxPasMI.Checked then SynEdit2.Lines.LoadFromFile(GetTempDir+'ProTranslator.pas');
  if SourceCodeMI.Checked then SynEdit2.Lines.LoadFromFile(GetTempDir+'ProTranslator.txt');
  SynEdit2.Text:=SysToUTF8(SynEdit2.Text);
  if Splitter2.Visible then
    Splitter2.Left:= SynEdit2.Left-1;
end;

procedure TForm1.SynEdit2StatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if SynEdit1.TopLine<>SynEdit2.TopLine then SynEdit1.TopLine:=SynEdit2.TopLine;
end;

procedure TForm1.LoadSyntax(const KeywordDesc, CommandsFile, FunctionsFile: string);
var
  ParentMI, ChildMI: TMenuItem;
  sections, SectionValues: TStringList;
  str, str1: String;
  i, j: Integer;
begin
  if FileExists(KeywordDesc) then
    Keywords.LoadFromFile(KeywordDesc)
  else Keywords.Clear;
  if FileExists(CommandsFile) then begin
    CommandsIni.Create(CommandsFile);
    CommandsIni.ReadSections(ListBox1.Items);
  end
  else begin
    CommandsIni.Clear;
    ListBox1.Items.Clear;
  end;
  if FileExists(FunctionsFile) then
    Functions.LoadFromFile(FunctionsFile)
  else Functions.Clear;

  ExamplesMI.Clear;

  if FileExists(ExamplesFile) then begin
     IniExamples:=TMemIniFile.Create(ExamplesFile);
     sections:=TStringList.Create;
     IniExamples.ReadSections(sections);
     for i:=0 to sections.Count-1 do begin
         ParentMI:= TMenuItem.Create(Self);
         ParentMI.Caption:=SysToUTF8(sections[i]);
         ExamplesMI.Add(ParentMI);
         SectionValues:=TStringList.Create;
         IniExamples.ReadSectionValues(sections[i], SectionValues);
         for j:=0 to SectionValues.Count-1 do begin
           ChildMI:= TMenuItem.Create(Self);
           str:=SectionValues.Strings[j];
           str1:=SectionValues.Strings[j];
           Delete(str1, Pos('=', str), Length(str));
           ChildMI.Caption:=SysToUTF8(str1);
           Delete(str, 1, Pos('=', str));
           ChildMI.Hint:=ExtractFilePath(ParamStr(0))+SysToUTF8(str);
           ChildMI.OnClick:= @LoadExample;
           ParentMI.Add(ChildMI);
         end;
     end;
  end;
end;

procedure TForm1.SyntaxCppMIClick(Sender: TObject);
begin
  SyntaxCppMI.Checked:=true;
  SynEdit1.Highlighter:=SynCppSyn1;
  SynEdit2.Highlighter:=SynCppSyn1;
  LoadSyntax('KeyWordsCppDesc.txt', 'CommandsCpp.ini', 'FunctionsCpp.cpp');
end;

procedure TForm1.SyntaxPasMIClick(Sender: TObject);
begin
  SyntaxPasMI.Checked:=true;
  SynEdit1.Highlighter:=SynPasSyn1;
  SynEdit2.Highlighter:=SynPasSyn1;
  LoadSyntax('KeyWordsPasDesc.txt', 'CommandsPas.ini', 'FunctionsPas.cpp');
end;

procedure TForm1.Translate(const FromFile, ToFile: string);
var params: String;
begin
  Params:= '"'+FromFile+'" "'+ToFile+'"';
  SysUtils.ExecuteProcess(ExtractFilePath(ParamStr(0))+'protrans.exe', params);
  SynEdit1.Lines.LoadFromFile(ToFile);
  OpenDialog1.FileName:= ToFile;
  SynEdit1.Text:=SysToUTF8(SynEdit1.Text);
end;

procedure TForm1.TranslateNowMIClick(Sender: TObject);
var TranslateSoutce: String;
begin
  if SourceCodeMI.Checked then begin
  TranslateSoutce:=GetTempDir+'ProTranslator.txt';
  Translate(OpenDialog1.FileName, TranslateSoutce);
  ParallelMI.Enabled:=true;
  ParallelTB.Enabled:=true;
  TranslateTextMI.Checked:=true;
  end else
  if TranslateTextMI.Checked and SyntaxCppMI.Checked then TranslateNowToCppMI.Click
  else if TranslateTextMI.Checked and SyntaxPasMI.Checked then TranslateNowToPasMI.Click;
end;

procedure TForm1.TranslateNowToCppMIClick(Sender: TObject);
var TranslateSoutce: String;
begin
  TranslateSoutce:=GetTempDir+'ProTranslator.cpp';
  Translate(OpenDialog1.FileName, TranslateSoutce);
  SyntaxCppMI.Click;
  SourceCodeMI.Checked:=true;
  ParallelMI.Enabled:=true;
  ParallelTB.Enabled:=true;
end;

procedure TForm1.TranslateNowToPasMIClick(Sender: TObject);
var TranslateSoutce: String;
begin
  TranslateSoutce:=GetTempDir+'ProTranslator.pas';
  Translate(OpenDialog1.FileName, TranslateSoutce);
  SyntaxPasMI.Click;
  SourceCodeMI.Checked:=true;
  ParallelMI.Enabled:=true;
  ParallelTB.Enabled:=true;
end;

procedure TForm1.EditCopyActionExecute(Sender: TObject);
begin
  SynEdit1.CopyToClipboard;
end;

procedure TForm1.EditCopyActionUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=SynEdit1.Focused and SynEdit1.SelAvail;
end;

procedure TForm1.EditCutActionExecute(Sender: TObject);
begin
  SynEdit1.CutToClipboard;
end;

procedure TForm1.EditCutActionUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=SynEdit1.Focused and SynEdit1.SelAvail and not SynEdit1.ReadOnly;
end;

procedure TForm1.EditDeleteActionExecute(Sender: TObject);
begin
  SynEdit1.SelText := '';
end;

procedure TForm1.EditDeleteActionUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=SynEdit1.Focused and SynEdit1.SelAvail and not SynEdit1.ReadOnly;
end;

procedure TForm1.EditPasteActionExecute(Sender: TObject);
begin
 SynEdit1.PasteFromClipboard;
end;

procedure TForm1.EditPasteActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=SynEdit1.Focused and SynEdit1.CanPaste;
end;

procedure TForm1.EditRedoActionExecute(Sender: TObject);
begin
 SynEdit1.Redo;
end;

procedure TForm1.EditRedoActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=SynEdit1.CanRedo;
end;

procedure TForm1.EditSelectAllActionExecute(Sender: TObject);
begin
 SynEdit1.SelectAll;
end;

procedure TForm1.EditSelectAllActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=SynEdit1.Focused and (SynEdit1.Lines.Text<>'');
end;

procedure TForm1.EditUndoActionExecute(Sender: TObject);
begin
 SynEdit1.Undo;
end;

procedure TForm1.EditUndoActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=SynEdit1.CanUndo;
end;

procedure TForm1.LoadExample(Sender: TObject);
begin
  if (Sender is TMenuItem) then
    OpenFile(TMenuItem(Sender).Hint);
end;

end.

