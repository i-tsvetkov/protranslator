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
unit ProTranslator;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  IniFiles,
  LCLProc,
  FileUtil,
  SysUtils;

{ Само тези три функции се предоставят за публично ползване:
  GetErrors   - ако има грешки в конфигурацията ще върне информация за
                настъпилите грешки в противен случай празен низ.
  GetLangName - взима като аргумент файлово име и връща името на раздела от
                конфигурационния файл отговарящ за него.
  Translate   - превежда код като code е кода за превод
                lang е името на раздела отговарящ на кода
                (може да се намери с GetLangName).
                invert показва дали превода трябва да е от код до преведен код
                или от преведен код до код.
                Ако има настъпили грешки или името на раздела не съществува
                ще бъде върнат оригиналния код без промени. }
function GetErrors() : string;
function GetLangName(filename : string) : string;
function Translate(code      : string;
                   lang      : string;
                   invert    : boolean) : string;

implementation

type
  region = record
    start,
    stop : string;
    skip : TStringList;
  end;

const
  CONFIG_FILE = 'config.ini';
  NOT_ALPHA   = [ #0 .. ' ', '!', '"', '#', '$', '%', '&', '''', '(', ')',
                '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?',
                '@', '[', '\', ']', '^', '`', '{', '|', '}', '~' ];

var
  Regions       : array of region;
  RegionsCount  : integer;
  CurrentRegion : ^region;
  KeyWords      : TStringList;
  IniFile       : TMemIniFile;
  LastLang      : string;
  ConfigIsBad   : boolean;
  ConfigErrors  : TStringList;

{ Проверява дали s е буква }
function IsAlpha(s : string) : boolean;
begin
  IsAlpha := not (s[1] in NOT_ALPHA);
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

{ Връща информация за неправилна конфигурация. }
function GetErrors() : string;
begin
  if ConfigIsBad then
    GetErrors := ConfigErrors.Text
  else
    GetErrors := ''
end;

{ Регистрира настъпили грешки. }
procedure Panic(msg : string);
begin
  ConfigIsBad := true;
  ConfigErrors.Append('Грешка (' + SysToUTF8(DateTimeToStr(Now)) + ') : ' + msg);
end;

{ Проверява конфигурацията за нередности. }
procedure CheckConfig();
var
  i, j, rCount                  : integer;
  configFile, keyWordFile, jStr : string;
  sections                      : TStringList;
begin
  configFile := ExtractFilePath(ParamStr(0)) + UTF8ToSys(CONFIG_FILE);
  if not FileExists(configFile) then
    Panic('Конфигурационния файл "' + SysToUTF8(configFile) + '" не е намерен.');
  sections := TStringList.Create;
  IniFile.ReadSections(sections);
  for i := 0 to sections.Count-1 do begin
    if not IniFile.ValueExists(sections[i], 'FileExtensions') then
      Panic('В раздела ' + sections[i] +
            ' задължителния ключ FileExtensions липсва.');
    if not IniFile.ValueExists(sections[i], 'KeyWordFile') then
      Panic('В раздела ' + sections[i] +
            ' задължителния ключ KeyWordFile липсва.')
    else begin
      keyWordFile := ExtractFilePath(ParamStr(0)) +
                     UTF8ToSys(IniFile.ReadString(sections[i], 'KeyWordFile', ''));
      if not FileExists(keyWordFile) then
        Panic('Файла "' + SysToUTF8(keyWordFile) + '" указан от ключ KeyWordFile в раздел '
              + sections[i] + ' не е намерен.');
    end;
    if not IniFile.ValueExists(sections[i], 'RegionsCount') then
      Panic('В раздела ' + sections[i] +
            ' задължителния ключ RegionsCount липсва.')
    else begin
      rCount := IniFile.ReadInteger(sections[i], 'RegionsCount', 0);
      if rCount < 0 then
        Panic('RegionsCount в раздел ' + sections[i] + ' е отрицателен.')
      else
        for j := 0 to rCount-1 do begin
          jStr := IntToStr(j+1);
          if not IniFile.ValueExists(sections[i], 'Start'+ jStr) then
            Panic('Ключа Start'+ jStr + ' от раздел '
                  + sections[i] + ' липсва.');
          if not IniFile.ValueExists(sections[i], 'Stop' + jStr) then
            Panic('Ключа Stop' + jStr + ' от раздел '
                  + sections[i] + ' липсва.');
          if not IniFile.ValueExists(sections[i], 'Skip' + jStr) then
            Panic('Ключа Skip' + jStr + ' от раздел '
                  + sections[i] + ' липсва.');
        end;
    end;
  end;
  sections.Free;
end;

{ Инициализира ресурси необходими на преводача }
procedure ProTranslatorInit();
var
  configFile : string;
begin
  ConfigIsBad  := false;
  ConfigErrors := TStringList.Create;
  configFile := ExtractFilePath(ParamStr(0)) + UTF8ToSys(CONFIG_FILE);
  CurrentRegion := nil;
  RegionsCount  := 0;
  LastLang := '';
  IniFile  := TMemIniFile.Create(configFile);
  KeyWords := TStringList.Create;
  CheckConfig();
end;

{ Освобождава ресурсите използвани от преводача }
procedure ProTranslatorFree();
begin
  KeyWords.Free;
  IniFile.Free;
  ConfigErrors.Free;
  Regions:=nil;
end;

{ Връща името на раздела в config.ini отговарящ на името на файла }
function GetLangName(filename : string) : string;
var
  i                   : integer;
  fileExt, fileExtens : string;
  sections            : TStringList;
begin
  if ConfigIsBad then begin
    GetLangName := '';
    exit;
  end;
  sections := TStringList.Create;
  IniFile.ReadSections(sections);
  for i := 0 to sections.Count-1 do begin
    fileExt    := UTF8ToSys(IniFile.ReadString(sections[i], 'FileExtensions', '')) + ' ';
    fileExtens := ExtractFileExt(filename) + ' ';
    if Pos(fileExtens, fileExt) <> 0 then begin
      GetLangName := sections[i];
      sections.Free;
      exit;
    end;
  end;
  sections.Free;
  GetLangName := '';
end;

{ Зарежда настройки от раздела lang на config.ini }
function LoadSettings(lang : string) : boolean;
var
  i                 : integer;
  keyWordFile, iStr : string;
begin
  if not IniFile.SectionExists(lang) then begin
    LoadSettings := false;
    exit;
  end;
  for i := 0 to RegionsCount-1 do
    Regions[i].skip.Free;
  RegionsCount := IniFile.ReadInteger(lang, 'RegionsCount', 0);
  SetLength(Regions, RegionsCount);
  for i := 0 to RegionsCount-1 do begin
    iStr := IntToStr(i+1);
    Regions[i].start := IniFile.ReadString(lang, 'Start'+iStr, '');
    Regions[i].stop  := IniFile.ReadString(lang, 'Stop' +iStr, '');
    Regions[i].skip  := TStringList.Create;
    Regions[i].skip.Delimiter := ' ';
    Regions[i].skip.DelimitedText := IniFile.ReadString(lang, 'Skip'+iStr, '');
  end;
  KeyWords.CaseSensitive := IniFile.ReadBool(lang, 'CaseSensitive', true);
  keyWordFile := ExtractFilePath(ParamStr(0)) +
                 UTF8ToSys(IniFile.ReadString(lang, 'KeyWordFile', ''));
  KeyWords.LoadFromFile(keyWordFile);
  LastLang := lang;
  LoadSettings := true;
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
  code - кода за превод
  lang - името на раздела отговарящ на кода
  invert - показва дали превода е наопаки }
function Translate(code      : string;
                   lang      : string;
                   invert    : boolean) : string;
var
  codeLines : TStringList;
  currentLine, translatedLine, ch, wrd : string;
  p, i, j, currentLineLen              : integer;
  translatedLines                      : TStringList;
begin
  if ConfigIsBad then begin
    Translate := code;
    exit;
  end;
  if lang <> LastLang then
    if not LoadSettings(lang) then begin
      Translate := code;
      exit;
    end;
  codeLines:=TStringList.Create;
  codeLines.Text:=code;
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
  codeLines.Free;
  Translate := translatedLines.Text;
  translatedLines.Free;
end;

initialization
  ProTranslatorInit;

finalization
  ProTranslatorFree;

end.


