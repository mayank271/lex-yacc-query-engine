%{
//Parser file
#include<stdio.h>
#include<stdlib.h>
struct Record{
	int id; //dnum, eid
	char* name; //dname, ename
	char* address; //dlocatoin, eaddress
	int egae;
	int salary;
	int deptno;
	struct Record *next;
};

struct Record* head = NULL;
%}
%union {
	int ival;
	char *sval;
}
%token <sval> AND COMMA DELETE FROM GET ID INSERT INTO OR SET SPACE TO UPDATE WHERE EQUAL NE GT GE LT LE
%token <ival> NUM
%%
stmt: S GET S FIELDS S FROM S ID S WHERE S CONDITIONS S {
	//Get filename from the query
	char* fname=malloc(sizeof(char)*(strlen($8)+4)); strcpy(fname, $8); strcat(fname, ".txt"); //printf("%s", fname);
	//Initialize data
	FILE *fp;
	fp = fopen(fname, "r");
	int c, stop=0;
	struct Record* temp = NULL;
	do{
		char buffer[2000];
		int buffer_i = 0;
		int buffer_c1 = 0, buffer_c2 = 0, buffer_c3 = 0; //to keep track of values
		do{
		c = fgetc(fp);
		if(feof(fp)){
			stop = 1;
			break;
		}
		buffer[buffer_i] = (char) c;
		if(buffer[buffer_i] == ','){
			if(buffer_c2 == 0){
				if(buffer_c1 > 0){
					buffer_c2 = buffer_i;
				}
				else{
					buffer_c1 = buffer_i;
				}
			}
		}
//		printf("%c", c);
		buffer_i++;
		}while(c!=(int)'\n');
		buffer_c3 = buffer_i-1;
		if(buffer_c1 == 0) break;
//		printf("%d %d %d\n", buffer_c1, buffer_c2, buffer_c3);
		struct Record *r;
		r = (struct Record*)malloc(sizeof(struct Record));
		
		int int_val=0;
		for(int i=5; i<buffer_c1; i++){
			int_val *= 10;
			int_val += buffer[i] - '0';
		}
		r->id = int_val;
//		printf("%d\n", r->id);
		
		char* buff_name=malloc(sizeof(char)*(200));
//		char buff_name[200];
		int_val = 0;
		for(int i=buffer_c1+8; i<buffer_c2; i++, int_val++){
			buff_name[int_val] = buffer[i];
		}
		buff_name[int_val] = '\0';
		r->name = buff_name;

		char* buff_add=malloc(sizeof(char)*(1000));
//		char buff_add[2000];
		int_val = 0;
		for(int i=buffer_c2+12; i< buffer_c3; i++, int_val++){
			buff_add[int_val] = buffer[i];
		}
		buff_add[int_val] = '\0';
		r->address = buff_add;
//		printf("%d| |%s| |%s\n", r->id, r->name, r->address);

		if(head == NULL){
			head = r;
			head->next = NULL;
		}
		else{
			if(temp == NULL){
				temp = r;				
				head->next = temp;
				temp->next = NULL;
			}
			else{
				r->next = NULL;
				temp->next = r;	
				temp = temp->next;
			}
		}
	}while(stop==0);
	fclose(fp);
//	while(head!=NULL){
//		printf("sss\n");
//		printf("%d %s ", head->id, head->name);
//		printf("%s\n", head->address);
//		head = head->next;
//	}
	}
  | S INSERT S FIELDS S INTO S ID S {/**/}
  | S UPDATE S ID S SET S ID S TO S NEWVAL S WHERE S CONDITIONS S {/**/}
  | S DELETE S FROM S ID S WHERE S CONDITIONS S {/**/}
  ;
FIELDS: FIELDS S COMMA S ID {/**/}
  | ID {/**/}
  ;
NEWVAL: ID {/**/}
  | NUM {/**/}
  ;
CONDITIONS: CONDITIONS S AND S CONDITION {/**/}
  | CONDITIONS S OR S CONDITION {/**/}
  | CONDITION {/**/}
  ;
CONDITION: ID S EQUAL S ID {/**/}
  | ID S NE S ID {/**/}
  | ID S EQUAL S NUM {/**/}
  | ID S NE S NUM {/**/}
  | ID S GT S NUM {/**/}
  | ID S GE S NUM {/**/}
  | ID S LT S NUM {/**/}
  | ID S LE S NUM {/**/}
  ;
S: SPACE
  |
  ;
%%
void main()
{
printf("enter statement : \n");
yyparse();
printf("valid statement");
exit(0);
}
void yyerror()
{
  printf("invalid statement");
exit(0);
}
