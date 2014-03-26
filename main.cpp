#include <cstdlib>
#include <iostream>
#include <fstream>
#include "transl.h"
#define INI_FILE "configfile.ini"
using namespace std;

int main(int argc, char *argv[])
{
    char FromFile[MAX];
    char ToFile[MAX];
    // ����� ���� �� �����
    string txttype = ".txt";
    string type;
	bool ReverseTranslate;
    // ��� ���� �� ����� �� ��������� ����������
    if(argc != 3) error("������ ���� ���������");

    // ����� ������� �� ���������
    strcpy(FromFile, argv[1]);
    strcpy(ToFile, argv[2]);
    type = GetFileType(FromFile);

    ReverseTranslate =toupperStr(type)==toupperStr(txttype);
    if(ReverseTranslate)
 	    type = GetFileType(ToFile);
    
    // �������� ���� �� ini �����
    string IniFilePath = GetFullPath(INI_FILE, argv[0]);
    
    // ����� �������� ���������� �� ����
    string SectionName = GetSectionName((char *) (type + " ").c_str(), (char *) IniFilePath.c_str());
    if(SectionName == "") error((string)"�� � �������� ������ ���������� �� ���� �� �����: " + FromFile);
    
    char KeyWordFile[MAX];
    int DoubleQuotes, SingleQuotes;
    
    // ����������� �� �� ������ �� �������� '' � ""
    // ���� � ini ����� �� ���������� �������� - 1, ��������� - 0
    DoubleQuotes = GetPrivateProfileInt((char *) SectionName.c_str(), "DoubleQuotes", -1, (char *) IniFilePath.c_str());
    if(DoubleQuotes == -1) error("� �������� " + SectionName + "�� � ������� ������������� ���� DoubleQuotes");
    
    SingleQuotes = GetPrivateProfileInt((char *) SectionName.c_str(), "SingleQuotes", -1, (char *) IniFilePath.c_str());
    if(SingleQuotes == -1) error("� �������� " + SectionName + "�� � ������� ������������� ���� SingleQuotes");
    
    // ����������� �� ���������� �� ��������� �� �������
    CaseSensitivity = GetPrivateProfileInt((char *) SectionName.c_str(), "CaseSensitivity", -1, (char *) IniFilePath.c_str());
    if(CaseSensitivity == -1) error("� �������� " + SectionName + "�� � ������� ������������� ���� CaseSensitivity");
    
    int NumMultiLineComments, NumOneLineComments;
    
    // ����� ���� �� ������������ � ������������� ���������
    NumMultiLineComments = GetPrivateProfileInt((char *) SectionName.c_str(), "NumMultiLineComments", -1, (char *) IniFilePath.c_str());
    if(NumMultiLineComments == -1) error("� �������� " + SectionName + "�� � ������� ������������� ���� NumMultiLineComments");
    NumOneLineComments = GetPrivateProfileInt((char *) SectionName.c_str(), "NumOneLineComments", -1, (char *) IniFilePath.c_str());
    if(NumOneLineComments == -1) error("� �������� " + SectionName + "�� � ������� ������������� ���� NumOneLineComments");
    
    // ������� ����� �� ����� � ��������� ����
    GetPrivateProfileString((char *) SectionName.c_str(), "KeyWordFile", "", KeyWordFile, MAX, (char *) IniFilePath.c_str());
    if(strcmp(KeyWordFile, "") == 0) error("� �������� " + SectionName + "�� � ������� ������������� ���� KeyWordFile");
    
    Comment comment[NumMultiLineComments + NumOneLineComments];
    
    // ����� �����������
    for(int i = 0; i < NumMultiLineComments; i++)
    {
            char begin[MAX], end[MAX], num[2], BeginKey[30] = "MultiLineCommentBegin", EndKey[30] = "MultiLineCommentEnd";
            sprintf(num, "%d", i+1);
            strcat(BeginKey, num);
            GetPrivateProfileString((char *) SectionName.c_str(), BeginKey, "", begin, MAX, (char *) IniFilePath.c_str());
            if(strcmp(BeginKey, "") == 0) error("� �������� " + SectionName + "�� � ������� ����� " + begin);
            strcat(EndKey, num);
            GetPrivateProfileString((char *) SectionName.c_str(), EndKey, "", end, MAX, (char *) IniFilePath.c_str());
            if(strcmp(EndKey, "") == 0) error("� �������� " + SectionName + "�� � ������� ����� " + end);
            comment[i].begin = begin;
            comment[i].end = end;
    }
    
    for(int i = NumMultiLineComments, j = 1; i < (NumMultiLineComments + NumOneLineComments); i++, j++)
    {
            char begin[MAX], end[MAX], num[2], BeginKey[30] = "OneLineComment";
            sprintf(num, "%d", j);
            strcat(BeginKey, num);
            GetPrivateProfileString((char *) SectionName.c_str(), BeginKey, "", begin, MAX, (char *) IniFilePath.c_str());
            if(strcmp(BeginKey, "") == 0) error("� �������� " + SectionName + "�� � ������� ����� " + begin);
            comment[i].begin = begin;
            comment[i].end = "\n";
    }
    
    // ����� ��������� ����
    string readBuf;
    string wordfile = GetFullPath(KeyWordFile, argv[0]);
    ifstream keyFile((char *) wordfile.c_str());
    for(int i = 0; !keyFile.eof() && i<KEY_WORD_NUM; i++)
    {
        getline(keyFile, readBuf);
    if((readBuf!="")&&(strchr(readBuf.c_str(), '=')!=0))
		if(!ReverseTranslate)
		{
			keyWords[i] = strtok((char *) readBuf.c_str(), "=");
			bgWords[i] = strtok( NULL, "=");
		}
		else
		{
			bgWords[i] = strtok((char *) readBuf.c_str(), "=");
			keyWords[i] = strtok( NULL, "=");
		}
    }
    keyFile.close();
        
    // ����� ���� ����
    ifstream Source(FromFile);
    while(!Source.eof())
    {
        string FileLine;
        getline(Source, FileLine);
        SourceStr += FileLine + "\n";
    }
    Source.close();
    
    // ����������
    for(int i = 0; i < SourceStr.size(); i++)
    {
            
            if(DoubleQuotes && SourceStr[i] == '\"') StringJmp(i, '\"');
            
            if(SingleQuotes && SourceStr[i] == '\'') StringJmp(i, '\'');
            
            for(int j = 0; j < (NumMultiLineComments + NumOneLineComments); j++)
                if(SearchStrStr(i, comment[j].begin, SourceStr)) CommentJmp(i, comment[j].end);
                
            if(isalphabg(SourceStr[i])) ReadWord(i);
            
            TranslateSourceStr += SourceStr[i];
    }
	
    // ��������� ������� � ����
    ofstream TranslateSource(ToFile);
        TranslateSource << TranslateSourceStr;
    TranslateSource.close();
	
    return EXIT_SUCCESS;
}
