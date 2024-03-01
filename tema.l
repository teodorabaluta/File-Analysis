%{
// BALUTA TEODORA-VALENTINA 332CC
#include <stdio.h>
#include <string.h>
%}

%option noyywrap


%x BOOK
%x ARTICLE
%x INPROCEEDINGS
%x SKIPA
%x SKIPB
%x SKIPI
%x GHILIMELE_A
%x GHILIMELE_B
%x GHILIMELE_I

SKIP [^\n]*\n
%%
<INITIAL>"@article"|"@Article"|"@ARTICLE" {
    BEGIN(SKIPA);
    printf("\nArticol in revista:\n");
}

<INITIAL>"@book"|"@Book"|"@BOOK" {
    BEGIN(SKIPB);
    printf("\nCarte:\n");
}

<INITIAL>"@inproceedings"|"@Inproceedings"|"@INPROCEEDINGS" {
    BEGIN(SKIPI);
    printf("\nArticol prezentat la conferinta:\n");
}

<SKIPA>
    {SKIP}  { BEGIN(ARTICLE); }

<SKIPB>
    {SKIP}  { BEGIN(BOOK); }

<SKIPI>
    {SKIP}  { BEGIN(INPROCEEDINGS); }

<BOOK>
    "title={" { BEGIN(GHILIMELE_B);
                printf("Titlu: \""); }

<BOOK>
    "author={" {    BEGIN(BOOK);
                    printf("Autori: "); }

<BOOK>
    "year={" {  BEGIN(BOOK); 
                printf("Anul publicarii: "); }
    
<BOOK>
    "publisher={" { BEGIN(BOOK);
                    printf("Editura: "); }

<BOOK>
    "--"|"--0" { BEGIN(BOOK);
            printf("-"); }

<BOOK>
    "}" { BEGIN(INITIAL); }

<BOOK>
    "}\n}" { BEGIN(INITIAL); }

<BOOK>
    "}," { BEGIN(BOOK); }

<BOOK>
    "pages={"|"pages={0" { BEGIN(BOOK);
                printf("Pagini: "); }

<BOOK>
    "publisher={" { BEGIN(BOOK);
                    printf("Editura: "); }

<BOOK>
    "journal={" { BEGIN(BOOK);
                  printf("Revista: "); }

<BOOK>
    "volume={" {    BEGIN(BOOK);
                    printf("Volum: "); }

<BOOK>
    "doi={" { BEGIN(BOOK);
                  printf("Obiect digital identificat: "); }

<BOOK>
    "organization={" {    BEGIN(BOOK);
                    printf("Organizatia: "); }

  
                    
<ARTICLE>
    "title={" { BEGIN(GHILIMELE_A);
                printf("Titlu: \""); }
<ARTICLE>
    "author={" {    BEGIN(ARTICLE);
                    printf("Autori: "); }

<ARTICLE>
    "year={" {  BEGIN(ARTICLE);
                printf("Anul publicarii: "); }

<ARTICLE>
    "publisher={" { BEGIN(ARTICLE);
                    printf("Editura: "); }

<ARTICLE>
    "journal={" { BEGIN(ARTICLE);
                  printf("Revista: "); }

<ARTICLE>
    "volume={" {    BEGIN(ARTICLE);
                    printf("Volum: "); }

<ARTICLE>
    "number={" {    BEGIN(ARTICLE);
                    printf("Numele versiunii: "); }

<ARTICLE>
    "booktitle={" {    BEGIN(ARTICLE);
                    printf("Numele cartii: "); }

<ARTICLE>
    "pages={"|"pages={0" { BEGIN(ARTICLE);
                printf("Pagini: "); }

<ARTICLE>
    "--"|"--0" { BEGIN(ARTICLE);
            printf("-"); }

<ARTICLE>
    "doi={" { BEGIN(ARTICLE);
                  printf("Obiect digital identificat: "); }

<ARTICLE>
    "organization={" {    BEGIN(ARTICLE);
                    printf("Organizatia: "); }

<ARTICLE>
    "}" { BEGIN(INITIAL); }

<ARTICLE>
    "}\n}" { BEGIN(INITIAL); }

<ARTICLE>
    "}," { BEGIN(ARTICLE); }

<INPROCEEDINGS>
    "title={" { BEGIN(GHILIMELE_I);
                printf("Titlu: \""); }

<INPROCEEDINGS>
    "author={" {    BEGIN(INPROCEEDINGS);
                    printf("Autori: "); }

<INPROCEEDINGS>
    "year={" {  BEGIN(INPROCEEDINGS);
                printf("Anul prezentarii: "); }

<INPROCEEDINGS>
    "booktitle={" { BEGIN(INPROCEEDINGS);
                    printf("Conferinta: "); }

<INPROCEEDINGS>
    "organization={" {  BEGIN(INPROCEEDINGS);
                    printf("Organizatie: "); }

<INPROCEEDINGS>
    "pages={"|"pages={0" {  BEGIN(INPROCEEDINGS);
                            printf("Pagini: ");
    }

<INPROCEEDINGS>
    "doi={" { BEGIN(INPROCEEDINGS);
                  printf("Obiect digital identificat: "); }

<INPROCEEDINGS>
    "--"|"--0" {    BEGIN(INPROCEEDINGS);
                    printf("-"); }

<INPROCEEDINGS>
    "publisher={" {    BEGIN(INPROCEEDINGS);
                    printf("Organizatia: "); }

<INPROCEEDINGS>
    "volume={" {    BEGIN(INPROCEEDINGS);
                    printf("Volum: "); }

<INPROCEEDINGS>
    "number={" {    BEGIN(INPROCEEDINGS);
                    printf("Numarul versiunii: "); }

<INPROCEEDINGS>
    "}" {   BEGIN(INITIAL); }

<INPROCEEDINGS>
    "}\n}" {    BEGIN(INITIAL); }

<INPROCEEDINGS>
    "}," {  BEGIN(INPROCEEDINGS); }

<GHILIMELE_B>
    "}," {  printf("\"");
            BEGIN(BOOK); }

<GHILIMELE_A>
    "}," {  printf("\"");
            BEGIN(ARTICLE); }

<GHILIMELE_I>
    "}," { printf("\"");
            BEGIN(INPROCEEDINGS); }
%%

int main(int argc, char **argv) {
    FILE *f = fopen(argv[1], "r");
    if (!f) {
        fprintf(stderr, "Eroare la deschiderea fisierului.\n");
        return 1;
    }
    yyin = f;
    yylex();
    fclose(f);
    return 0;
}
