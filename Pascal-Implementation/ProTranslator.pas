program ProTranslator;

{$mode objfpc}{$H+}

uses
  Classes,
  IniFiles,
  LCLProc,
  StrUtils,
  SysUtils;

type
  region = record
    start,
    stop : string;
    skip : TStringList;
  end;

const
  CONFIG_FILE = 'config.ini';

var
  Regions       : array of region;
  RegionsCount  : integer;
  CurrentRegion : ^region;
  KeyWords      : TStringList;
  IniFile       : TMemIniFile;
  LastLang      : string;

{ Проверява дали s е буква }
function IsAlpha(s : string) : boolean;
begin
  IsAlpha := not (s[1] in StdWordDelims);
end;

{ Извлича дума от s намираща се на p позиция }
function ExtractWordFromPos(s : string; p : integer) : string;
var
  len, i  : integer;
  wrd, ch : string;
begin
  wrd := '';
  len := UTF8Length(s);
  for i := p to len do begin
    ch := UTF8Copy(s, i, 1);
    if IsAlpha(ch) then
      wrd := wrd + ch
    else begin
      ExtractWordFromPos := wrd;
      exit;
    end;
  end;
  ExtractWordFromPos := wrd;
end;

{ Показва дали подниза substr се намира на p позиция в s }
function IsSubStringAtPos(s, substr : string; p : integer) : boolean;
var
  substrLen, len, i : integer;
  chOne, chTwo      : string;
begin
  len := UTF8Length(s);
  substrLen := UTF8Length(substr);
  if not (len-p+1 >= substrLen) then begin
    IsSubStringAtPos := false;
    exit;
  end;
  for i := 1 to substrLen do begin
    chOne := UTF8Copy(s,  p+i-1, 1);
    chTwo := UTF8Copy(substr, i, 1);
    if chOne <> chTwo then begin
      IsSubStringAtPos := false;
      exit;
    end;
  end;
  IsSubStringAtPos := true;
end;

{ Принтира съобщение за грешка и затваря програмата }
procedure Panic(msg : string);
begin
  writeln(msg + ' - ' + DateTimeToStr(Now));
  halt;
end;

{ Инициализира ресурси необходими на преводача }
procedure ProTranslatorInit();
var
  configFile : string;
begin
  configFile := ExtractFilePath(ParamStr(0)) + CONFIG_FILE;
  if not FileExists(configFile) then
    Panic(configFile + ' не е намерен.');
  CurrentRegion := nil;
  RegionsCount  := 0;
  LastLang := '';
  IniFile  := TMemIniFile.Create(configFile);
  KeyWords := TStringList.Create;
end;

{ Освобождава ресурсите използвани от преводача }
procedure ProTranslatorFree();
begin
  KeyWords.Free;
  IniFile.Free;
  Regions:=nil;
end;

{ Връща името на раздела в config.ini отговарящ на името на файла }
function GetLangName(filename : string) : string;
var
  i                   : integer;
  fileExt, fileExtens : string;
  sections            : TStringList;
begin
  sections := TStringList.Create;
  IniFile.ReadSections(sections);
  for i := 0 to sections.Count-1 do begin
    if not IniFile.ValueExists(sections[i], 'FileExtensions') then
      Panic('Раздел ' + sections[i] + ' е непълен.');
    fileExt    := IniFile.ReadString(sections[i], 'FileExtensions', '') + ' ';
    fileExtens := ExtractFileExt(filename) + ' ';
    if Pos(fileExtens, fileExt) <> 0 then begin
      GetLangName := sections[i];
      sections.Free;
      exit;
    end;
  end;
  sections.Free;
  Panic('Не е намерен раздел отговарящ на файла.');
end;

{ Зарежда настройки от раздела lang на config.ini }
procedure LoadSettings(lang : string);
var
  i                 : integer;
  keyWordFile, iStr : string;
begin
  if not (IniFile.ValueExists(lang, 'KeyWordFile') or
          IniFile.ValueExists(lang, 'RegionsCount')) then
    Panic('Раздел ' + lang + ' е непълен.');
  for i := 0 to RegionsCount-1 do
    Regions[i].skip.Free;
  RegionsCount := IniFile.ReadInteger(lang, 'RegionsCount', 0);
  SetLength(Regions, RegionsCount);
  for i := 0 to RegionsCount-1 do begin
    iStr := IntToStr(i+1);
    if not (IniFile.ValueExists(lang, 'Start'+iStr) or
            IniFile.ValueExists(lang, 'Stop' +iStr) or
            IniFile.ValueExists(lang, 'Skip' +iStr)) then
      Panic('Регион ' + iStr + ' на раздел' + lang + ' е непълен.');
    Regions[i].start := IniFile.ReadString(lang, 'Start'+iStr, '');
    Regions[i].stop  := IniFile.ReadString(lang, 'Stop' +iStr, '');
    Regions[i].skip  := TStringList.Create;
    Regions[i].skip.Delimiter := ' ';
    Regions[i].skip.DelimitedText := IniFile.ReadString(lang, 'Skip'+iStr, '');
  end;
  KeyWords.CaseSensitive := IniFile.ReadBool(lang, 'CaseSensitive', true);
  keyWordFile := ExtractFilePath(ParamStr(0)) +
                 IniFile.ReadString(lang, 'KeyWordFile', '');
  if not FileExists(keyWordFile) then
    Panic(keyWordFile + ' не е намерен.');
  KeyWords.LoadFromFile(keyWordFile);
  LastLang := lang;
end;

{ Превежда дума invert показва дали превода е обърнат }
function TranslateWord(wrd : string; invert : boolean) : string;
var
  b       : boolean;
  i       : integer;
  w, n, v : string;
begin
  if invert then begin
    for i := 0 to KeyWords.Count-1 do begin
      KeyWords.GetNameValue(i, n, v);
      if KeyWords.CaseSensitive then
        b := wrd = v
      else
        b := UTF8LowerCase(wrd) = UTF8LowerCase(v);
      if b then begin
        TranslateWord := n;
        exit;
      end;
    end;
  end
  else begin
    w := KeyWords.Values[wrd];
    if w <> '' then begin
      TranslateWord := w;
      exit;
    end;
  end;
  TranslateWord := wrd;
end;

{ Функцията извършваща превода
  codeLines - кода за превод
  lang - името на раздела отговарящ на кода
  invert - показва дали превода е наопаки }
function Translate(codeLines : TStringList;
                   lang      : string;
                   invert    : boolean) : string;
var
  currentLine, translatedLine, ch, wrd : string;
  p, i, j, currentLineLen              : integer;
  translatedLines                      : TStringList;
begin
  if lang <> LastLang then
    LoadSettings(lang);
  translatedLines := TStringList.Create;
  CurrentRegion := nil;
  { Четем кода ред по ред }
  for i := 0 to codeLines.Count-1 do begin
    currentLine := codeLines[i];
    translatedLine := '';
    currentLineLen := UTF8Length(currentLine);
    p := 1;
    { Четем реда знак по знак }
    while p <= currentLineLen do begin
      { Ако сме извън регион }
      if CurrentRegion = nil then begin
        { Търсим начало на регион }
        for j := 0 to RegionsCount-1 do begin
          if IsSubStringAtPos(currentLine, Regions[j].start, p) then begin
            CurrentRegion := @Regions[j];
            translatedLine := translatedLine + Regions[j].start;
            p := p + UTF8Length(Regions[j].start);
            break;
            //continue;
          end;
        end;
        { Ако не сме намерили регион }
        if CurrentRegion = nil then begin
          ch := UTF8Copy(currentLine, p, 1);
          { проверяваме за начало на дума }
          if IsAlpha(ch) then begin
            wrd := ExtractWordFromPos(currentLine, p);
            translatedLine := translatedLine + TranslateWord(wrd, invert);
            p := p + UTF8Length(wrd);
          end
          else begin
            translatedLine := translatedLine + ch;
            p := p + UTF8Length(ch);
          end;
        end;
      end
      { Ако сме в регион }
      else begin
        { Проверяваме дали региона(коментара) е едноредов }
        if CurrentRegion^.stop = '' then begin
          translatedLine := translatedLine +
                            UTF8Copy(currentLine, p, currentLineLen);
          CurrentRegion := nil;
          break;
        end;
        j := 0;
        { Търсим за низове които трябва да пренебрегнем }
        while j < CurrentRegion^.skip.Count do begin
          if IsSubStringAtPos(currentLine, CurrentRegion^.skip[j], p) then begin
            translatedLine := translatedLine + CurrentRegion^.skip[j];
            p := p + UTF8Length(CurrentRegion^.skip[j]);
            { започваме търсенето отначало }
            j := 0;
            continue;
          end;
        j := j + 1;
        end;
        { Проверяваме за края на региона }
        if IsSubStringAtPos(currentLine, CurrentRegion^.stop, p) then begin
          translatedLine := translatedLine + CurrentRegion^.stop;
          p := p + UTF8Length(CurrentRegion^.stop);
          CurrentRegion := nil;
        end
        else begin
          ch := UTF8Copy(currentLine, p, 1);
          translatedLine := translatedLine + ch;
          p := p + UTF8Length(ch);
        end;
      end;
    end;
    translatedLines.Append(translatedLine);
  end;
  Translate := translatedLines.Text;
  translatedLines.Free;
end;

var
  sourceLines : TStringList;
  filename    : string;
begin
  filename := ParamStr(1);
  if not FileExists(filename) then
    Panic(filename + ' не е намерен.');
  sourceLines := TStringList.Create;
  sourceLines.LoadFromFile(filename);
  ProTranslatorInit();
  write(Translate(sourceLines, GetLangName(filename), false));
  sourceLines.Free;
  ProTranslatorFree();
end.


