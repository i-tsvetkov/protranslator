using namespace std;
#include <windows.h>
#include <time.h>
// максималният размер на C низовете
#define MAX 500
// максималният брой ключови думи
#define KEY_WORD_NUM 100

string keyWords[KEY_WORD_NUM], bgWords[KEY_WORD_NUM], SourceStr, TranslateSourceStr = "";
int CaseSensitivity;

// структура представяща коментар
struct Comment
{
	string begin;
	string end;
};

bool isalphabg(char a)
{
  return isalpha(a) || a == '_' || ('а'<=a && a<='я') || ('А'<=a && a<='Я');
}

// връща низ в горен регистър
string toupperStr(string str)
{
       for(int i = 0; i < str.size(); i++)
       str[i] = toupper(str[i]);
       return str;
}

// функция връщаща пълния път до някой файл
// намиращ се в директорията с изпълнимия файл
string GetFullPath(char FileName[], char argv[])
{
	char CurrentDirectory[MAX], *p;
	strcpy(CurrentDirectory, argv);
	p = strrchr(CurrentDirectory, '\\');
	strcpy(p, "\\");
	strcat(CurrentDirectory, FileName);
	return CurrentDirectory;
}

// функция връщаща файловото разширение на даден файл
string GetFileType(char path[])
{
	return (string) strrchr(path, '.');
}

// връща името на раздела в ini файла отговарящ на файловото разширение
string GetSectionName(char FileType[], char IniFilePath[])
{
	char SectionNames[MAX];
	int s = GetPrivateProfileSectionNames(SectionNames, MAX, IniFilePath);
	for(int i = 0; i < s; i++) if(SectionNames[i] == '\0') SectionNames[i] = '$';
	for(char *p = strtok(SectionNames, "$"); p != NULL; p = strtok(NULL, "$"))
	{
		char buf[MAX];
		GetPrivateProfileString(p, "FileExtensions", NULL, buf, MAX, IniFilePath);
		strcat(buf, " ");
		if(strstr(buf, FileType) != 0) return p;
	}
	return "";
}

// покозва дали на i позиция се намира str1 в str2
bool SearchStrStr(int i, string str1, string str2)
{
	for(int x = 0; x < str1.size(); x++) if(str1[x] != str2[i++]) return false;
	return true;
}

// добавя знаците намиращи се между i и j позиция
void AddText(int i, int j)
    {
        for(int x = i; x < j; x++) TranslateSourceStr += SourceStr[x];
    }

// прескача коментар намиращ се на i позиция и завършващ с end
void CommentJmp(int &i, string end)
{
	int x;
	for(x = i; x < SourceStr.size(); x++)
	{
		if(SearchStrStr(x, end, SourceStr))
		{
			AddText(i, x + end.size());
            i = x + end.size();
			return;
		}
	}
}

// прескача низ типът на низа ('' или "") се показва с str
void StringJmp(int &i, char str)
{
   if(str == '\"')
	for(int x = i+1; x < SourceStr.size(); x++)
	{
		if(SourceStr[x] == '\\') x++;
		else if(SourceStr[x] == str)
        {
            AddText(i, x+1);
            i = x+1;
	     	return;
        }
	}
	
   if(str == '\'')
    for(int x = i+1; x < SourceStr.size(); x++)
	{
		if((SourceStr[x] == '\'' && SourceStr[x+1] == '\'') || SourceStr[x] == '\\') x++;
		else if(SourceStr[x] == str)
        {
                AddText(i, x+1);
                i = x+1;
	         	return;
        }
	}
	
}

// замества дума в кода с нейния превод
    void ReadWord(int &i)
    {
        string word;
        int x;
        for(x = i; isalphabg(SourceStr[x]) || isdigit(SourceStr[x]); x++) word += SourceStr[x];
        i = x;
        for(int j = 0; j < KEY_WORD_NUM; j++)
        if((CaseSensitivity == 1) ? (word == keyWords[j]) : (toupperStr(word) == toupperStr(keyWords[j])))
        {
                TranslateSourceStr += bgWords[j];
                return;
        }
        TranslateSourceStr += word;
    }

void error(string err)
{
     time_t t = time(NULL);
     ofstream ErrorFile("Errors.txt", ios::app);
              ErrorFile << err << " - " << ctime(&t);
     ErrorFile.close();
     exit(EXIT_FAILURE);
}

