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
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Dialogs, Menus,
  ComCtrls, ExtCtrls, StdCtrls, ActnList, StdActns, SynHighlighterCpp,
  SynHighlighterPas, SynEdit, INIFiles, Unit2, Types,
  LConvEncoding, ProTranslator, LCLIntf, LCLProc;

type

  TCurrentFile = Class
    public
      name         : String;
      path         : String;
      encoding     : String;
      extension    : String;
      fullpath     : string;
      isTranslated : Boolean;
      isWritable   : Boolean;
      constructor Create;
      destructor Destroy; override;
      function GetText() : String;
      procedure SetText(str : String);
  end;

  { TMainForm }

  TMainForm = class(TForm)
    KeywordInfoAction: TAction;
    ApplicationProperties: TApplicationProperties;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    LightColorsMI: TMenuItem;
    DarkColorsMI: TMenuItem;
    ViewMI: TMenuItem;
    IncreaseFontMI: TMenuItem;
    ResetFontMI: TMenuItem;
    DecreaseFontMI: TMenuItem;
    ShowWordInfoMI: TMenuItem;
    OpenWebPageMI: TMenuItem;
    NewFileCppMI: TMenuItem;
    NewFileTrPasMI: TMenuItem;
    NewFileTrCppMI: TMenuItem;
    OpenInEditorMI: TMenuItem;
    ExamplesMI: TMenuItem;
    EditKeyWordsAction: TMenuItem;
    MenuItem4: TMenuItem;
    ErrorsMI: TMenuItem;
    NewFileMI: TMenuItem;
    NewFilePasMI: TMenuItem;
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
    ToolsMI: TMenuItem;
    ShowKeyWordMI: TMenuItem;
    ShowKeyWordAction: TAction;
    ActionList: TActionList;
    ImageList: TImageList;
    ListBox1: TListBox;
    MainMenu: TMainMenu;
    Memo1: TMemo;
    FileMI: TMenuItem;
    MenuItem1: TMenuItem;
    Separator4MI: TMenuItem;
    ParallelMI: TMenuItem;
    Separator2MI: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    DeleteMI: TMenuItem;
    SelectAllMI: TMenuItem;
    ShowWordTB: TToolButton;
    RedoTB: TToolButton;
    OpenInEditorTB: TToolButton;
    ToolButton13: TToolButton;
    InsertConstructsTB: TToolButton;
    ShowWordInfoTB: TToolButton;
    OpenTB: TToolButton;
    SaveTB: TToolButton;
    ToolButton4: TToolButton;
    TranslateNowTB: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    UndoTB: TToolButton;
    TranslateNowMI: TMenuItem;
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
    OpenDialog: TOpenDialog;
    InsertConstructionPanel: TPanel;
    PopupMenuRC: TPopupMenu;
    SaveDialogOne: TSaveDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    StatusBar: TStatusBar;
    SynCppSyn: TSynCppSyn;
    MainSynEdit: TSynEdit;
    ParallelSynEdit: TSynEdit;
    SynPasSyn: TSynPasSyn;
    ToolBar: TToolBar;
    procedure AboutMIClick(Sender: TObject);
    procedure ApplicationPropertiesDropFiles(Sender: TObject;
      const FileNames: array of String);
    procedure DarkColorsMIClick(Sender: TObject);
    procedure EditKeyWordsActionClick(Sender: TObject);
    procedure ErrorsMIClick(Sender: TObject);
    procedure ExitMIClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IncreaseFontMIClick(Sender: TObject);
    procedure InsertConstructionsMIClick(Sender: TObject);
    procedure InstructionsMIClick(Sender: TObject);
    procedure KeywordInfoActionExecute(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure DecreaseFontMIClick(Sender: TObject);
    procedure LightColorsMIClick(Sender: TObject);
    procedure ResetFontMIClick(Sender: TObject);
    procedure OpenWebPageMIClick(Sender: TObject);
    procedure NewFileCppMIClick(Sender: TObject);
    procedure NewFileTrPasMIClick(Sender: TObject);
    procedure NewFileTrCppMIClick(Sender: TObject);
    procedure NewFilePasMIClick(Sender: TObject);
    procedure SaveAsMIClick(Sender: TObject);
    procedure OpenInEditorActionExecute(Sender: TObject);
    procedure OpenMIClick(Sender: TObject);
    procedure ParallelMIClick(Sender: TObject);
    procedure SaveMIClick(Sender: TObject);
    procedure ShowKeyWordActionExecute(Sender: TObject);
    procedure MainSynEditClick(Sender: TObject);
    procedure MainSynEditClickLink(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MainSynEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MainSynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure ParallelSynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure SourceCodeMIClick(Sender: TObject);
    procedure SyntaxCppMIClick(Sender: TObject);
    procedure SyntaxPasMIClick(Sender: TObject);
    procedure TranslateNowMIClick(Sender: TObject);
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

    Type
        NewFileMode = (NewPascal, NewCpp, NewTrPascal, NewTrCpp);

    const
      WEB_PAGE_URL = 'http://www.protranslator.gymnasium-lom.com/';
      PAS_LANG = 'Pascal';
      CPP_LANG = 'C++';
      MODE_OPT = '-mode=';
      PAS_MODE = MODE_OPT+PAS_LANG;
      CPP_MODE = MODE_OPT+CPP_LANG;

    procedure TranslateTextMIClick(Sender: TObject);
  private
    Functions, Keywords: TStringList;
    HintWindow : THintWindow;
    KeywordDescPas, KeywordDescCpp,
    CommandsFilePas, CommandsFileCpp,
    FunctionsFilePas, FunctionsFileCpp,
    ExamplesFilePas, ExamplesFileCpp,
    KeywordsFilePas, KeywordsFileCpp,
    ErrorsFile, AboutFile, InstructionsFile : String;
    function GetWordDesc(const AWord: string): string;
    procedure LoadExample(Sender: TObject);
    procedure LoadSyntax(const KeywordDesc, CommandsFile, FunctionsFile, ExamplesFile: string);
    procedure OpenFile(AFileName: string);
    procedure TranslateNow();
    function AnswerAskToSave() : Boolean;
    procedure MakeNewFile(mode : NewFileMode);
    procedure EnableAllEditing();
    procedure LoadCommands();
    procedure TranslateMemo();
    function CurrentLang() : string;
    procedure ResetState();
  public
    { public declarations }
    CommandsIni: TMemIniFile;
  end;

var
  MainForm: TMainForm;
  CurrentFile : TCurrentFile;

implementation

{$R *.lfm}

uses
  SynEditTypes;

constructor TCurrentFile.Create;
begin
     name:='';
     path:=GetCurrentDir;
     extension:='';
     fullpath:='';
     encoding:=EncodingUTF8;
     isTranslated:=False;
     isWritable:=True;
end;

destructor TCurrentFile.Destroy;
begin
end;

function TCurrentFile.GetText() : String;
begin
     Result:=MainForm.MainSynEdit.Lines.Text;
end;

function TMainForm.AnswerAskToSave() : Boolean;
begin
     case QuestionDlg('Незаписани промени',
                      'Има незаписани промени.' + LineEnding +
                      'Желаете ли да запишете направените промени?',
                      mtConfirmation, [mrYes, mrNo, mrCancel], '') of
          mrYes:
            begin
              SaveMI.Click;
              Result:=not MainSynEdit.Modified;
            end;
          mrNo:
            Result:=True;
          mrCancel:
            Result:=False;
     end;
end;

procedure TMainForm.EnableAllEditing();
begin
     MainSynEdit.Visible:=True;
     SaveMI.Enabled:=True;
     SaveAsMI.Enabled:=True;
     IncreaseFontMI.Enabled:=True;
     ResetFontMI.Enabled:=True;
     DecreaseFontMI.Enabled:=True;
     LightColorsMI.Enabled:=True;
     DarkColorsMI.Enabled:=True;
     TranslateNowMI.Enabled:=True;
     ParallelMI.Enabled:=True;
     ShowWordInfoMI.Enabled:=True;
     ShowKeyWordMI.Enabled:=True;
     InsertConstructionsMI.Enabled:=True;
     OpenInEditorMI.Enabled:=True;
     TranslateMI.Enabled:=True;
     SyntaxMI.Enabled:=True;
     ExamplesMI.Enabled:=True;
     ToolsMI.Enabled:=True;
     InstructionsMI.Enabled:=True;
     InsertConstructionsDialogMI.Enabled:=True;
     SaveTB.Enabled:=True;
     TranslateNowTB.Enabled:=True;
     OpenInEditorTB.Enabled:=True;
     InsertConstructsTB.Enabled:=True;
     ShowWordInfoTB.Enabled:=True;
     ShowWordTB.Enabled:=True;
     ParallelTB.Enabled:=True;
     EditKeyWordsAction.Enabled:=True;
end;

procedure TMainForm.ResetState();
begin
  SyntaxPasMI.Checked:=False;
  SyntaxCppMI.Checked:=False;
  SourceCodeMI.Checked:=True;
  TranslateTextMI.Checked:=False;
end;

function TMainForm.CurrentLang() : string;
begin
  if SyntaxPasMI.Checked then
    Result:=PAS_LANG
  else if SyntaxCppMI.Checked then
    Result:=CPP_LANG
  else Result:='';
end;

procedure TMainForm.MakeNewFile(mode : NewFileMode);
begin
  if MainSynEdit.Modified then
    if not AnswerAskToSave() then
      Exit;

  EnableAllEditing();
  ResetState();

  case mode of
    NewPascal:
      begin
        SyntaxPasMI.Checked:=True;
        SourceCodeMI.Checked:=True;
        TranslateTextMI.Checked:=False;
        SyntaxPasMI.Click;
      end;
    NewCpp:
      begin
        SyntaxCppMI.Checked:=True;
        SourceCodeMI.Checked:=True;
        TranslateTextMI.Checked:=False;
        SyntaxCppMI.Click;
      end;
    NewTrPascal:
      begin
        SyntaxPasMI.Checked:=True;
        SourceCodeMI.Checked:=False;
        TranslateTextMI.Checked:=True;
        SyntaxPasMI.Click;
      end;
    NewTrCpp:
      begin
        SyntaxCppMI.Checked:=True;
        SourceCodeMI.Checked:=False;
        TranslateTextMI.Checked:=True;
        SyntaxCppMI.Click;
      end;
  end;

  CurrentFile.Destroy;
  CurrentFile:=TCurrentFile.Create;
  CurrentFile.SetText('');
  MainSynEdit.Modified:=False;
  Caption:='ProTranslator - Нов Файл';
end;

procedure TCurrentFile.SetText(str : String);
begin
     MainForm.MainSynEdit.Lines.Text:=str;
end;

procedure OpenFileInEditor(const AFileName: string);
begin
  OpenDocument(SysToUTF8(AFileName));
end;

{ TMainForm }

procedure TMainForm.MainSynEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if MainSynEdit.TopLine<>ParallelSynEdit.TopLine then ParallelSynEdit.TopLine:=MainSynEdit.TopLine;
end;

procedure TMainForm.SaveMIClick(Sender: TObject);
var tl : TStringList;
begin
  if (CurrentFile.name <> '') and not CurrentFile.isTranslated and CurrentFile.isWritable then begin
    tl:=TStringList.Create;
    tl.Text:=MainSynEdit.Lines.Text;
    {FIXME
     (project1:7500): GLib-CRITICAL **: Source ID 420
      was not found when attempting to remove it
      TApplication.HandleException Access violation
      Stack trace:
      $000000000078FBF0
      $00000000007F5178
      $000000000045EAA4
      ...
      $000000000069E731
      WARNING: TLCLComponent.Destroy with LCLRefCount>0.
      Hint: Maybe the component is processing an event?
    }
    {MainSynEdit.Lines.SaveToFile(CurrentFile.path
                               + DirectorySeparator
                               + CurrentFile.name
                               + CurrentFile.extension);}
    {MainSynEdit.Lines.SaveToFile('foo.c');}
    tl.SaveToFile(CurrentFile.fullpath);
    MainSynEdit.Modified:=False;
    tl.Free;
  end
  else begin
    if not CurrentFile.isWritable then begin
      MessageDlg('Нямате права за запис',
                 'Нямате права да презапишете файла.', mtWarning, [mbYes], '');
    end;

    SaveAsMI.Click;
  end;
end;

procedure TMainForm.ShowKeyWordActionExecute(Sender: TObject);
var word: String;
begin
  if ParallelSynEdit.Focused then
    word:=ParallelSynEdit.GetWordAtRowCol(MainSynEdit.CaretXY)
  else word:=MainSynEdit.GetWordAtRowCol(MainSynEdit.CaretXY);
    // маркира думата, върху която е курсора
    if ShowKeyWordAction.Checked then begin
       MainSynEdit.SetHighlightSearch(word, [ssoWholeWord, ssoEntireScope]);
       ParallelSynEdit.SetHighlightSearch(word, [ssoWholeWord, ssoEntireScope]);
    end
    else begin
     MainSynEdit.SetHighlightSearch('', [ssoEntireScope]);
     ParallelSynEdit.SetHighlightSearch('', [ssoEntireScope]);
    end;
end;

procedure TMainForm.MainSynEditClick(Sender: TObject);
var word: String;
begin
   word:=MainSynEdit.GetWordAtRowCol(MainSynEdit.CaretXY);
   StatusBar.SimpleText:=GetWordDesc(word);
end;

function TMainForm.GetWordDesc(const AWord: string): string;
var
  Section: TStringList;
  w: String;
begin
  w:=AWord;
  if not SourceCodeMI.Checked then
    w:=Trim(Translate(AWord, CurrentLang, True));

  Result:=Keywords.Values[w];
  if Result <> '' then Exit;

  Result:=Functions.Values[w];
  if Result <> '' then Exit;

  if CommandsIni.SectionExists(w) then begin
     Section:=TStringList.Create;
     CommandsIni.ReadSectionValues(w, Section);
     Result:=Section.Text;
     Section.Free;
     Exit;
  end;

  Result:='';
end;

procedure TMainForm.MainSynEditClickLink(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeywordInfoAction.Execute;
end;

procedure TMainForm.MainSynEditMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  HideDistance = 50;
begin
  with HintWindow do
    if Visible and ((Abs(Left-Mouse.CursorPos.X)>HideDistance) or
                   ((Abs(Top-Mouse.CursorPos.Y)>HideDistance))) then
      Hide;
end;

procedure TMainForm.OpenFile(AFileName: string);
var
  textlines : TStringList;
  encoding  : String;
  extension : String;
begin
  if MainSynEdit.Modified then
    if not AnswerAskToSave() then
      Exit;

  if LowerCase(GuessEncoding(AFileName)) = LowerCase(EncodingUTF8) then
     AFileName:=UTF8ToSys(AFileName);

  if not FileExists(AFileName) then begin
     MessageDlg('Файла не е намерен',
     'Файлът "'+SysToUTF8(AFileName)+'" не съществува.', mtWarning, [mbYes], '');
     Exit;
  end;

  if not FileIsReadable(SysToUTF8(AFileName)) then begin
    MessageDlg('Файла не е четим',
               'Нямате права за четене на файла.', mtWarning, [mbYes], '');
    Exit;
  end;

  if not FileIsText(SysToUTF8(AFileName)) then begin
    MessageDlg('Файла не може да се отвори',
               'Файла не е текстов файл.', mtWarning, [mbYes], '');
    Exit;
  end;

  EnableAllEditing();
  ResetState();

  textlines:=TStringList.Create;
  textlines.LoadFromFile(AFileName);

  encoding:=GuessEncoding(textlines.Text);
  if encoding = 'ISO-8859-1' then
     encoding:='CP1251';

  CurrentFile.SetText(ConvertEncoding(textlines.Text, encoding, EncodingUTF8));
  CurrentFile.name:=UTF8ToSys(ExtractFileNameOnly(SysToUTF8(AFileName)));
  CurrentFile.path:=ExtractFileDir(AFileName);
  CurrentFile.extension:=ExtractFileExt(AFileName);
  CurrentFile.fullpath:=AFileName;
  CurrentFile.encoding:=encoding;
  CurrentFile.isTranslated:=False;
  CurrentFile.isWritable:=FileIsWritable(SysToUTF8(AFileName));

  extension:=LowerCase(CurrentFile.extension);

  if (Pos(extension+' ',
     '.c .cc .cpp .cs .cxx .h .hpp .hxx ') <> 0)
     or (GetLangName(CurrentFile.extension) = CPP_LANG) then begin
     SourceCodeMI.Checked:=True;
     TranslateTextMI.Checked:=False;
     SyntaxCppMI.Click;
  end;

  if (Pos(extension+' ', '.inc .p .pas .pp .lpr .dpr ') <> 0)
     or (GetLangName(CurrentFile.extension) = PAS_LANG) then begin
     SourceCodeMI.Checked:=True;
     TranslateTextMI.Checked:=False;
     SyntaxPasMI.Click;
  end;

  if Pos(extension+' ', '.tcpp ') <> 0 then begin
     SourceCodeMI.Checked:=False;
     TranslateTextMI.Checked:=True;
     SyntaxCppMI.Click;
  end;

  if Pos(extension+' ', '.tpas ') <> 0 then begin
     SourceCodeMI.Checked:=False;
     TranslateTextMI.Checked:=True;
     SyntaxPasMI.Click;
  end;

  Caption:='ProTranslator - ' + SysToUTF8(AFileName);
  MainSynEdit.Modified:=False;

  textlines.Free;
end;

procedure TMainForm.OpenMIClick(Sender: TObject);
begin
  OpenDialog.Filter:='Pascal/C++ файлове|*.c;*.cc;*.cpp;*.cs;*.cxx;*.dpk;*.dpr;'
                                       +'*.h;*.hh;*.hpp;*.hxx;*.inc;*.lpr;*.p;'
                                       +'*.pas;*.pp;*.tcpp;*.tpas';
  if SyntaxPasMI.Checked then
    OpenDialog.Filter:=SynPasSyn.DefaultFilter+'|'+SynCppSyn.DefaultFilter;
  if SyntaxCppMI.Checked then
    OpenDialog.Filter:=SynCppSyn.DefaultFilter+'|'+SynPasSyn.DefaultFilter;
  OpenDialog.Filter:=OpenDialog.Filter+'|Всички файлове|*.*';

  if OpenDialog.Execute then begin
    OpenFile(UTF8ToSys(OpenDialog.FileName));
  end;
end;

procedure TMainForm.ExitMIClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if MainSynEdit.Modified then
     CanClose:=AnswerAskToSave()
  else
     CanClose:=True;
end;

procedure TMainForm.ApplicationPropertiesDropFiles(Sender: TObject;
  const FileNames: array of String);
begin
  if Length(FileNames) > 0 then
    OpenFile(FileNames[0]);
end;

procedure TMainForm.DarkColorsMIClick(Sender: TObject);
begin
  MainSynEdit.Color:=$362b00;
  ParallelSynEdit.Color:=$362b00;
  MainSynEdit.Highlighter.IdentifierAttribute.Foreground:=$969483;
  ParallelSynEdit.Highlighter.IdentifierAttribute.Foreground:=$969483;
  MainSynEdit.Gutter.Parts.Part[0].MarkupInfo.Background:=$423607;
  MainSynEdit.Gutter.Parts.Part[0].MarkupInfo.Foreground:=$756e58;
  MainSynEdit.LineHighlightColor.Background:=$423607;
  ParallelSynEdit.LineHighlightColor.Background:=$423607;
  if SyntaxPasMI.Checked then
    SynPasSyn.SymbolAttri.Foreground:=$0089b5
  else
    SynCppSyn.SymbolAttri.Foreground:=$0089b5;
end;

procedure TMainForm.AboutMIClick(Sender: TObject);
begin
  if FileExists(AboutFile) then OpenFileInEditor(AboutFile);
end;

procedure TMainForm.EditKeyWordsActionClick(Sender: TObject);
begin
  if SyntaxPasMI.Checked and FileExists(KeywordsFilePas) then OpenFile(KeywordsFilePas);
  if SyntaxCppMI.Checked and FileExists(KeywordsFileCpp) then OpenFile(KeywordsFileCpp);
end;

procedure TMainForm.ErrorsMIClick(Sender: TObject);
begin
  if FileExists(ErrorsFile) then OpenFile(ErrorsFile)
  else ShowMessage('Няма грешки');
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  errorsLog : TStringList;
  i         : Integer;
  appDir    : String;
begin
  CurrentFile:=TCurrentFile.Create;
  HintWindow := THintWindow.Create(self);
  HintWindow.AutoHide:= True;
  HintWindow.HideInterval:= 5000;
  Functions:= TStringList.Create;
  Keywords:= TStringList.Create;
  CommandsIni:= TMemIniFile.Create('');
  SynPasSyn.DefaultFilter:=SynPasSyn.DefaultFilter+';*.p;*.pp;*.lpr;*.tpas';
  SynCppSyn.DefaultFilter:=SynCppSyn.DefaultFilter+';*.cc;*.cs;*.cxx;*.hxx;*.tcpp';

  appDir:=ExtractFilePath(ParamStr(0));

  KeywordDescPas  := appDir + UTF8ToSys('KeyWordsPasDesc.txt');
  KeywordDescCpp  := appDir + UTF8ToSys('KeyWordsCppDesc.txt');

  KeywordsFilePas := appDir + UTF8ToSys('KeyWordsPas.txt');
  KeywordsFileCpp := appDir + UTF8ToSys('KeyWordsCpp.txt');

  FunctionsFilePas:= appDir + UTF8ToSys('FunctionsPas.txt');
  FunctionsFileCpp:= appDir + UTF8ToSys('FunctionsCpp.txt');

  CommandsFilePas := appDir + UTF8ToSys('CommandsPas.ini');
  CommandsFileCpp := appDir + UTF8ToSys('CommandsCpp.ini');

  ExamplesFilePas := appDir + UTF8ToSys('ExamplesPas.ini');
  ExamplesFileCpp := appDir + UTF8ToSys('ExamplesCpp.ini');

  AboutFile       := appDir + UTF8ToSys('About.html');
  InstructionsFile:= appDir + UTF8ToSys('Help.html');
  ErrorsFile      := appDir + UTF8ToSys('Errors.txt');

  if GetErrors() <> '' then begin
    MessageDlg('Неправилна конфигурация',
               'Има намерени грешки.' + LineEnding +
               'Вижте "' + SysToUTF8(ErrorsFile) + '" за повече подробности.',
                mtWarning, [mbYes], '');
    errorsLog:=TStringList.Create;
    if FileExists(ErrorsFile) then begin
      errorsLog.LoadFromFile(ErrorsFile);
      errorsLog.Append(Trim(GetErrors()));
    end
    else begin
      errorsLog.Text:=GetErrors();
    end;
    errorsLog.SaveToFile(ErrorsFile);
    errorsLog.Free;
  end;

  SyntaxPasMIClick(nil);
  ExamplesMI.Enabled:=True;

  for i:=1 to Application.ParamCount do
    if FileExists(Application.Params[i])
       and (Application.Params[i] <> PAS_MODE)
       and (Application.Params[i] <> CPP_MODE) then begin
      OpenFile(Application.Params[i]);
      break;
    end;

  for i:=1 to Application.ParamCount do
    case Application.Params[i] of
      PAS_MODE : begin SyntaxPasMIClick(nil); ExamplesMI.Enabled:=True; end;
      CPP_MODE : begin SyntaxCppMIClick(nil); ExamplesMI.Enabled:=True; end;
    end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  CurrentFile.Destroy;
  CommandsIni.Free;
  Functions.Free;
  Keywords.Free;
  HintWindow.Free;
end;

procedure TMainForm.IncreaseFontMIClick(Sender: TObject);
begin
  if MainSynEdit.Font.Size < 72 then begin
    MainSynEdit.Font.Size:=MainSynEdit.Font.Size + 1;
    ParallelSynEdit.Font.Size:=MainSynEdit.Font.Size;
  end;
end;

procedure TMainForm.InsertConstructionsMIClick(Sender: TObject);
begin
  InsertConstructionPanel.Visible:=not InsertConstructionPanel.Visible;
  Splitter2.Visible:=not Splitter2.Visible;
  Splitter2.Left:=InsertConstructionPanel.Left-1;
  if Sender is TMenuItem then
     InsertConstructsTB.Down:=not InsertConstructsTB.Down;
  if InsertConstructionPanel.Visible then begin
     Memo1.Text:='';
     LoadCommands();
  end;
end;

procedure TMainForm.InstructionsMIClick(Sender: TObject);
begin
  if FileExists(InstructionsFile) then OpenFileInEditor(InstructionsFile);
end;

procedure TMainForm.KeywordInfoActionExecute(Sender: TObject);
var
  Rect: TRect;
  word, desc: String;
  P: TPoint;
begin
   word:=MainSynEdit.GetWordAtRowCol(MainSynEdit.CaretXY);
   desc:= GetWordDesc(word);
   if desc =  '' then Exit;
   Rect := HintWindow.CalcHintRect(0, desc,nil);
   P:= MainSynEdit.RowColumnToPixels(MainSynEdit.CaretXY);
   P:= MainSynEdit.ClientToScreen(P);
   OffsetRect(Rect, P.X, P.Y);
   Delete(desc, 1, Pos(',', desc));
   HintWindow.ActivateHint(Rect, desc);
end;

procedure TMainForm.ListBox1Click(Sender: TObject);
var
  sl        : TStringList;
  sections  : TStringList;
begin
  sl:=TStringList.Create;
  sections:=TStringList.Create;
  if ListBox1.ItemIndex>=0 then begin
    CommandsIni.ReadSections(sections);
    CommandsIni.ReadSectionValues(sections[ListBox1.ItemIndex], sl);
    sl.Text:=removeComments(sl.Text);
    sl.Text:=stripTags(sl.Text);
    if not SourceCodeMI.Checked then begin
      Memo1.Text:=Translate(sl.Text, CurrentLang, False);
    end
    else  Memo1.Text:=sl.Text;
  end;
  sl.Free;
  sections.Free;
end;

procedure TMainForm.LoadCommands();
var lang: String;
  Sections: TStringList;
  i: Integer;
begin
  if not SourceCodeMI.Checked then begin
    lang:=CurrentLang;
    Sections:=TStringList.Create;
    CommandsIni.ReadSections(Sections);
    ListBox1.Items.Clear;
    for i:=0 to Sections.Count-1 do
      ListBox1.Items.Append(Trim(Translate(Sections[i], lang, False)));
    Sections.Free;
  end
  else begin
     CommandsIni.ReadSections(ListBox1.Items);
  end;
end;

procedure TMainForm.TranslateMemo();
begin
  Memo1.Text:=Translate(Memo1.Text, CurrentLang, SourceCodeMI.Checked)
end;

procedure TMainForm.ListBox1DblClick(Sender: TObject);
var
  Spaces: String;
  i: Integer;
  tsl: TStringList;
  sections: TStringList;
  needArguments: Boolean;
begin
  if (ListBox1.Items.Count = 0) or (ListBox1.ItemIndex < 0) then Exit;
  tsl := TStringList.Create;
  sections:=TStringList.Create;
  Spaces:='';
  CommandsIni.ReadSections(sections);
  CommandsIni.ReadSectionValues(sections[ListBox1.ItemIndex], tsl);
  tsl.Text:=removeComments(tsl.Text);
  needArguments := Pos('`', StringReplace(tsl.Text, '\`', '', [rfReplaceAll])) <> 0;

  if not SourceCodeMI.Checked then begin
    CommandFrm.sl.Text:=Translate(tsl.Text, CurrentLang, False)
  end
  else  CommandFrm.sl.Text:=tsl.Text;

  for i:=0 to MainSynEdit.CaretX-2-UTF8Length(MainSynEdit.SelText) do
      Spaces:=Spaces+' ';
  if not InsertConstructionsDialogMI.Checked or not needArguments then
  begin
    for i:=1 to CommandFrm.sl.Count-1 do
      CommandFrm.sl.Strings[i]:=Spaces+CommandFrm.sl.Strings[i];
    CommandFrm.sl.Text:=stripTags(CommandFrm.sl.Text);
    MainSynEdit.SelText:=Trim(CommandFrm.sl.Text);
  end
  else
  begin
     if CommandFrm.ShowModal = mrOK then begin
       for i:=1 to CommandFrm.PreviewSynEdit.Lines.Count-1 do
         CommandFrm.PreviewSynEdit.Lines.Strings[i]:=Spaces+CommandFrm.PreviewSynEdit.Lines.Strings[i];
       MainSynEdit.SelText:=Trim(CommandFrm.PreviewSynEdit.Text);
     end;
  end;
  FocusControl(MainSynEdit);
  tsl.Free;
  sections.Free;
end;

procedure TMainForm.DecreaseFontMIClick(Sender: TObject);
begin
  if MainSynEdit.Font.Size > 6 then begin
    MainSynEdit.Font.Size:=MainSynEdit.Font.Size - 1;
    ParallelSynEdit.Font.Size:=MainSynEdit.Font.Size;
  end;
end;

procedure TMainForm.LightColorsMIClick(Sender: TObject);
begin
  MainSynEdit.Color:=$e3f6fd;
  ParallelSynEdit.Color:=$e3f6fd;
  MainSynEdit.Highlighter.IdentifierAttribute.Foreground:=$837b65;
  ParallelSynEdit.Highlighter.IdentifierAttribute.Foreground:=$837b65;
  MainSynEdit.Gutter.Parts.Part[0].MarkupInfo.Background:=$d5e8ee;
  MainSynEdit.Gutter.Parts.Part[0].MarkupInfo.Foreground:=$a1a193;
  MainSynEdit.LineHighlightColor.Background:=$d5e8ee;
  ParallelSynEdit.LineHighlightColor.Background:=$d5e8ee;
  if SyntaxPasMI.Checked then
    SynPasSyn.SymbolAttri.Foreground:=$c4716c
  else
    SynCppSyn.SymbolAttri.Foreground:=$c4716c;
end;

procedure TMainForm.ResetFontMIClick(Sender: TObject);
begin
  MainSynEdit.Font.Size:=16;
  ParallelSynEdit.Font.Size:=MainSynEdit.Font.Size;
end;

procedure TMainForm.OpenWebPageMIClick(Sender: TObject);
begin
  OpenURL(WEB_PAGE_URL);
end;

procedure TMainForm.NewFileCppMIClick(Sender: TObject);
begin
  MakeNewFile(NewCpp);
end;

procedure TMainForm.NewFileTrPasMIClick(Sender: TObject);
begin
  MakeNewFile(NewTrPascal);
end;

procedure TMainForm.NewFileTrCppMIClick(Sender: TObject);
begin
  MakeNewFile(NewTrCpp);
end;

procedure TMainForm.NewFilePasMIClick(Sender: TObject);
begin
  MakeNewFile(NewPascal);
end;

procedure TMainForm.SaveAsMIClick(Sender: TObject);
var
  SaveDialog : TSaveDialog;
  tl : TStringList;
label
  saveFile;
begin
  SaveDialog:=TSaveDialog.Create(Self);
  SaveDialog.Title:='Запиши като';
  SaveDialog.InitialDir:=CurrentFile.path;

  if SyntaxPasMI.Checked and SourceCodeMI.Checked then begin
     SaveDialog.Filter:=SynPasSyn.DefaultFilter;
  end
  else if SyntaxCppMI.Checked and SourceCodeMI.Checked then begin
       SaveDialog.Filter:=SynCppSyn.DefaultFilter;
  end;
  if SyntaxPasMI.Checked and TranslateTextMI.Checked then begin
     SaveDialog.Filter:='*.tpas|*.tpas';
  end
  else if SyntaxCppMI.Checked and TranslateTextMI.Checked then begin
       SaveDialog.Filter:='*.tcpp|*.tcpp';
  end;

  SaveDialog.Filter:=SaveDialog.Filter+'|Всички файлове|*.*';

  if SaveDialog.Execute then begin
    if FileExists(UTF8ToSys(SaveDialog.FileName)) then begin
      if QuestionDlg('Запис на файл',
                     'Файлът съществува.' + LineEnding +
                     'Желаете ли да презапишете съдържанието му?',
                     mtConfirmation, [mrYes, mrNo], '') = mrYes then begin
        goto saveFile;
      end;
    end
    else begin
      saveFile:
        if (FileExists(UTF8ToSys(SaveDialog.FileName)) and not FileIsWritable(SaveDialog.FileName)) or
           (not FileExists(UTF8ToSys(SaveDialog.FileName)) and not DirectoryIsWritable(SysToUTF8(ExtractFileDir(UTF8ToSys(SaveDialog.FileName))))) then begin
          MessageDlg('Нямате права за запис',
                     'Нямате права да запишете файла.', mtWarning, [mbYes], '')
        end
        else begin
          tl:=TStringList.Create;
          tl.Text:=MainSynEdit.Lines.Text;
          tl.SaveToFile(UTF8ToSys(SaveDialog.FileName));
          { FIXME }
          {MainSynEdit.Lines.SaveToFile(SaveDialog.FileName);}
          tl.Free;
          MainSynEdit.Modified:=False;
          OpenFile(UTF8ToSys(SaveDialog.FileName));
        end;
    end;
  end;

  SaveDialog.Free;
end;

procedure TMainForm.OpenInEditorActionExecute(Sender: TObject);
begin
  if CurrentFile.name <> '' then
    OpenFileInEditor(CurrentFile.fullpath);
end;

procedure TMainForm.ParallelMIClick(Sender: TObject);
begin
  if Sender is TMenuItem then
     ParallelTB.Down:=not ParallelTB.Down;

  ParallelSynEdit.Visible:=not ParallelSynEdit.Visible;
  Splitter1.Visible:=not Splitter1.Visible;
  Splitter1.Left:=ParallelSynEdit.Left-1;
  ParallelSynEdit.Highlighter:=MainSynEdit.Highlighter;
  MainSynEdit.ReadOnly:=not MainSynEdit.ReadOnly;

  ExamplesMI.Enabled:=not ExamplesMI.Enabled;
  OpenMI.Enabled:=not OpenMI.Enabled;
  TranslateNowMI.Enabled:=not TranslateNowMI.Enabled;
  TranslateNowTB.Enabled:=not TranslateNowTB.Enabled;
  OpenTB.Enabled:=not OpenTB.Enabled;
  InsertConstructionsMI.Enabled:=not InsertConstructionsMI.Enabled;
  InsertConstructsTB.Enabled:=not InsertConstructsTB.Enabled;
  ErrorsMI.Enabled:=not ErrorsMI.Enabled;
  EditKeyWordsAction.Enabled:=not EditKeyWordsAction.Enabled;
  NewFileMI.Enabled:=not NewFileMI.Enabled;

  ParallelSynEdit.Width:=round(MainForm.Width/2);

  if InsertConstructsTB.Down then begin
    InsertConstructionPanel.Visible:=not InsertConstructionPanel.Visible;
    Splitter2.Visible:=not Splitter2.Visible;
  end;

  if ParallelSynEdit.Visible then begin
    ParallelSynEdit.Lines.Text:=Translate(
      CurrentFile.GetText(), CurrentLang, not SourceCodeMI.Checked)
  end;
end;

procedure TMainForm.ParallelSynEditStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if MainSynEdit.TopLine<>ParallelSynEdit.TopLine then MainSynEdit.TopLine:=ParallelSynEdit.TopLine;
end;

procedure TMainForm.SourceCodeMIClick(Sender: TObject);
begin
  LoadCommands();
  TranslateMemo();
end;

procedure TMainForm.LoadSyntax(const KeywordDesc, CommandsFile, FunctionsFile, ExamplesFile: string);
var
  ParentMI, ChildMI: TMenuItem;
  sections, SectionValues: TStringList;
  IniExamples: TMemIniFile;
  str, str1: String;
  i, j: Integer;
begin
  if FileExists(KeywordDesc) then
    Keywords.LoadFromFile(KeywordDesc)
  else Keywords.Clear;
  Memo1.Text:='';
  if FileExists(CommandsFile) then begin
    CommandsIni.Create(CommandsFile);
    LoadCommands();
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
         ParentMI.Caption:=sections[i];
         ExamplesMI.Add(ParentMI);
         SectionValues:=TStringList.Create;
         IniExamples.ReadSectionValues(sections[i], SectionValues);
         for j:=0 to SectionValues.Count-1 do begin
           ChildMI:= TMenuItem.Create(Self);
           str:=SectionValues.Strings[j];
           str1:=SectionValues.Strings[j];
           Delete(str1, Pos('=', str), Length(str));
           ChildMI.Caption:=str1;
           Delete(str, 1, Pos('=', str));
           ChildMI.Hint:=SysToUTF8(ExtractFilePath(ParamStr(0)))
                       + StringReplace(str, ' => ', DirectorySeparator,
                                      [rfReplaceAll]);
           ChildMI.OnClick:= @LoadExample;
           ParentMI.Add(ChildMI);
         end;
         SectionValues.Free;
     end;
     IniExamples.Free;
     sections.Free;
  end;
end;

procedure TMainForm.SyntaxCppMIClick(Sender: TObject);
begin
  SyntaxCppMI.Checked:=true;
  MainSynEdit.Highlighter:=SynCppSyn;
  ParallelSynEdit.Highlighter:=SynCppSyn;
  LoadSyntax(KeywordDescCpp, CommandsFileCpp, FunctionsFileCpp, ExamplesFileCpp);
end;

procedure TMainForm.SyntaxPasMIClick(Sender: TObject);
begin
  SyntaxPasMI.Checked:=true;
  MainSynEdit.Highlighter:=SynPasSyn;
  ParallelSynEdit.Highlighter:=SynPasSyn;
  LoadSyntax(KeywordDescPas, CommandsFilePas, FunctionsFilePas, ExamplesFilePas);
end;


procedure TMainForm.TranslateNow();
var Acur: TPoint;
    Atop: Integer;
begin
  Acur:=MainSynEdit.CaretXY;
  Atop:=MainSynEdit.TopLine;

  CurrentFile.SetText(Translate(
    CurrentFile.GetText(), CurrentLang, not SourceCodeMI.Checked));

  MainSynEdit.TopLine:=Atop;
  MainSynEdit.CaretXY:=Acur;
  CurrentFile.isTranslated:=not CurrentFile.isTranslated;
  SourceCodeMI.Checked:=not SourceCodeMI.Checked;
  TranslateTextMI.Checked:=not SourceCodeMI.Checked;

  if InsertConstructionPanel.Visible then begin
    LoadCommands();
    TranslateMemo();
  end;
end;

procedure TMainForm.TranslateNowMIClick(Sender: TObject);
begin
  TranslateNow();
end;

procedure TMainForm.EditCopyActionExecute(Sender: TObject);
begin
  MainSynEdit.CopyToClipboard;
end;

procedure TMainForm.EditCopyActionUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=MainSynEdit.Focused and MainSynEdit.SelAvail;
end;

procedure TMainForm.EditCutActionExecute(Sender: TObject);
begin
  MainSynEdit.CutToClipboard;
end;

procedure TMainForm.EditCutActionUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=MainSynEdit.Focused and MainSynEdit.SelAvail and not MainSynEdit.ReadOnly;
end;

procedure TMainForm.EditDeleteActionExecute(Sender: TObject);
begin
  MainSynEdit.SelText := '';
end;

procedure TMainForm.EditDeleteActionUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=MainSynEdit.Focused and MainSynEdit.SelAvail and not MainSynEdit.ReadOnly;
end;

procedure TMainForm.EditPasteActionExecute(Sender: TObject);
begin
 MainSynEdit.PasteFromClipboard;
end;

procedure TMainForm.EditPasteActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=MainSynEdit.Focused and MainSynEdit.CanPaste;
end;

procedure TMainForm.EditRedoActionExecute(Sender: TObject);
begin
 MainSynEdit.Redo;
end;

procedure TMainForm.EditRedoActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=MainSynEdit.CanRedo;
end;

procedure TMainForm.EditSelectAllActionExecute(Sender: TObject);
begin
 MainSynEdit.SelectAll;
end;

procedure TMainForm.EditSelectAllActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=MainSynEdit.Focused and (MainSynEdit.Lines.Text<>'');
end;

procedure TMainForm.EditUndoActionExecute(Sender: TObject);
begin
 MainSynEdit.Undo;
end;

procedure TMainForm.EditUndoActionUpdate(Sender: TObject);
begin
TAction(Sender).Enabled :=MainSynEdit.CanUndo;
end;

procedure TMainForm.TranslateTextMIClick(Sender: TObject);
begin
  LoadCommands();
  TranslateMemo();
end;

procedure TMainForm.LoadExample(Sender: TObject);
begin
  if (Sender is TMenuItem) then
    OpenFile(UTF8ToSys(TMenuItem(Sender).Hint));
  CurrentFile.Destroy;
  CurrentFile:=TCurrentFile.Create;
end;

end.





