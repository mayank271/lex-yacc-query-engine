%{
//Parser file
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
struct Record{
	int id; //dnum, eid
	char* name; //dname, ename
	char* address; //dlocation, eaddress
	int egae;
	int salary;
	int deptno;
	struct Record *next;
};
int display[6] = {0}; //for displaying purposes (GET)

struct Record* head = NULL;
struct Record* temp = NULL;
struct Record* results = NULL;
struct Record* tresults = NULL;

struct Cond{
	char* field;
	int min_val; //for int fields
	int max_val; //for int fields
	char* ex_val; // for string fields
};

struct Conditions{
	int type; //0->END, 1->AND, 2->OR
	struct Conditions *left;
	struct Cond *right;	
};

struct Conditions* chead = NULL;
struct Conditions* ctemp = NULL;
%}
%union {
	int ival;
	char *sval;
	struct Cond *cval;
}
%token <sval> AND COMMA DELETE FROM GET ID INSERT INTO OR SET SPACE TO UPDATE WHERE EQUAL NE GT GE LT LE VALUE
%token <ival> NUM
%type <sval> VALUES
%type <cval> CONDITION
%%
stmt: S GET S FIELDS S FROM S ID S WHERE S CONDITIONS S {
	//Get filename from the query
			char* fname=malloc(sizeof(char)*(strlen($8)+4)); strcpy(fname, $8); strcat(fname, ".txt"); //printf("%s", fname);
			//Initialize data
			FILE *fp;
			fp = fopen(fname, "r");
			if(strcmp(fname, "DEPT.txt")==0){// INSERT FILE CHECK HERE [EMP, DEPT] TO BE DEALT SEPARATELY
				int c, stop=0;
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
			}
			else{
				//EMPLOYEE FILE CASE
				int c, stop=0;
				do{
					char buffer[2000];
					int buffer_i = 0;
					int buffer_c1 = 0, buffer_c2 = 0, buffer_c3 = 0, buffer_c4 = 0, buffer_c5 = 0, buffer_c6 = 0; //to keep track of values
					do{
					c = fgetc(fp);
					if(feof(fp)){
						stop = 1;
						break;
					}
					buffer[buffer_i] = (char) c;
					if(buffer[buffer_i] == ','){
						if(buffer_c5 == 0){
							if(buffer_c4 > 0){
									buffer_c5 = buffer_i;
							}
							else{
								if(buffer_c3 > 0){
									buffer_c4 = buffer_i;
								}
								else{
									if(buffer_c2 > 0){
										buffer_c3 = buffer_i;
									}
									else{
										if(buffer_c1 > 0){
											buffer_c2 = buffer_i;
										}
										else{
											buffer_c1 = buffer_i;
										}
									}
								}
							}
						}
					}
					buffer_i++;
					}while(c!=(int)'\n');
					buffer_c6 = buffer_i-1;
					if(buffer_c1 == 0) break;
					struct Record *r;
					r = (struct Record*)malloc(sizeof(struct Record));
					int int_val=0;
					for(int i=4; i<buffer_c1; i++){
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

					int_val=0;
					for(int i=buffer_c2+7; i<buffer_c3; i++){
						int_val *= 10;
						int_val += buffer[i] - '0';
					}
					r->egae = int_val;

					int_val=0;
					for(int i=buffer_c3+9; i<buffer_c4; i++){
						int_val *= 10;
						int_val += buffer[i] - '0';
					}
					r->salary = int_val;

					int_val=0;
					for(int i=buffer_c4+9; i<buffer_c5; i++){
						int_val *= 10;
						int_val += buffer[i] - '0';
					}
					r->deptno = int_val;
					char* buff_add=malloc(sizeof(char)*(1000));
				//		char buff_add[2000];
					int_val = 0;
					for(int i=buffer_c5+11; i< buffer_c6; i++, int_val++){
						buff_add[int_val] = buffer[i];
					}
					buff_add[int_val] = '\0';
					r->address = buff_add;
				//		printf("%d %s %d %d %d\n", r->id, r->name, r->egae, r->salary, r->deptno);
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
			}
			fclose(fp);
			// while(head!=NULL){
			// 	printf("%d\n%s\n", head->id, head->name);
			// 	printf("%s\n", head->address);
			// 	head = head->next;
			// }
			
			temp = head;
			while(temp!=NULL){
				int eval = 0;
				ctemp = chead;
				while(ctemp!=NULL){
					int curr_eval = 0;
					
					if(strcmp(ctemp->right->field, "dnum")==0){
						// CODE TO VALID THIS RECORD, IF VALID
						if(ctemp->right->max_val==-1){
							if(ctemp->right->min_val!=temp->id){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(ctemp->right->min_val<=temp->id){
									if(ctemp->right->max_val>=temp->id){
										curr_eval=1;
									}else{
										curr_eval=0;
									}
								}else{
									curr_eval=0;
								}
							}
						}
					}
					if(strcmp(ctemp->right->field, "dname")==0){
						if(ctemp->right->max_val==1){
							if(strcmp(ctemp->right->ex_val, temp->name)==1){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(strcmp(ctemp->right->ex_val, temp->name)==0){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
							}
						}
					}
					if(strcmp(ctemp->right->field, "dlocation")==0){
						if(ctemp->right->max_val==1){
							if(strcmp(ctemp->right->ex_val, temp->address)==1){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(strcmp(ctemp->right->ex_val, temp->address)==0){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
							}
						}
					}
					if(strcmp(ctemp->right->field, "eid")==0){
						if(ctemp->right->max_val==-1){
							if(ctemp->right->min_val!=temp->id){
								printf("%s\n",temp->name);
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(ctemp->right->min_val<=temp->id){
									if(ctemp->right->max_val>=temp->id){
										curr_eval=1;
									}else{
										curr_eval=0;
									}
								}else{
									curr_eval=0;
								}
							}
						}
					}
					if(strcmp(ctemp->right->field, "ename")==0){
						if(ctemp->right->max_val==1){
							if(strcmp(ctemp->right->ex_val, temp->name)==1){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(strcmp(ctemp->right->ex_val, temp->name)==0){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
							}
						}
					}
					if(strcmp(ctemp->right->field, "egae")==0){
						if(ctemp->right->max_val==-1){
							if(ctemp->right->min_val!=temp->egae){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(ctemp->right->min_val<=temp->egae){
									if(ctemp->right->max_val>=temp->egae){
										curr_eval=1;
									}else{
										curr_eval=0;
									}
								}else{
									curr_eval=0;
								}
							}
						}
					}
					if(strcmp(ctemp->right->field, "eaddress")==0){
						if(ctemp->right->max_val==1){
							if(strcmp(ctemp->right->ex_val, temp->address)==1){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(strcmp(ctemp->right->ex_val, temp->address)==0){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
							}
						}
					}
					if(strcmp(ctemp->right->field, "salary")==0){
						if(ctemp->right->max_val==-1){
							if(ctemp->right->min_val!=temp->salary){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(ctemp->right->min_val<=temp->salary){
									if(ctemp->right->max_val>=temp->salary){
										curr_eval=1;
									}else{
										curr_eval=0;
									}
								}else{
									curr_eval=0;
								}
							}
						}
					}
					if(strcmp(ctemp->right->field, "deptno")==0){
						if(ctemp->right->max_val==-1){
							if(ctemp->right->min_val!=temp->deptno){
								curr_eval=1;
							}else{
								curr_eval=0;
							}
						}else{
							if(ctemp->right->min_val<=temp->deptno){
									if(ctemp->right->max_val>=temp->deptno){
										curr_eval=1;
									}else{
										curr_eval=0;
									}
								}else{
									curr_eval=0;
								}
							}
						}
					}
					//printf("%d %s \n", chead->type, chead->right->field);
					if(ctemp->type == 2){
						//OR type
						if(curr_eval==1){
							eval=1;
							break;
						}
					}
					if(ctemp->type == 1){
						//AND type
						if(curr_eval==0){
							eval=0;
							break;
						}
					}
					if(ctemp->type == 0){
						break;
					}
					ctemp = ctemp->left;
				}
				//add to results OR tresults
				if(eval==1){
					if(results==NULL){
						
					}else{
						if(tresults==NULL){

						}else{
							
						}
					}
				}
				temp = temp->next;
			}
			}
	| S INSERT S VALUES S INTO S ID S {
		// ###### WORKS FINE BOTH INCLUSIVE ######
		//Get filename from the query
		char* fname=malloc(sizeof(char)*(strlen($8)+4)); strcpy(fname, $8); strcat(fname, ".txt");
		FILE *fp;
		fp = fopen(fname, "a");
		fprintf(fp, "%s\n",$4);
		printf("Record succesfully inserted...\n");
		fclose(fp);
		}
  | S UPDATE S ID S SET S ID S TO S NEWVAL S WHERE S CONDITIONS S {/**/}
  | S DELETE S FROM S ID S WHERE S CONDITIONS S {/**/}
  ;
VALUES: NUM S COMMA S VALUE S COMMA S VALUE {
	// ###### WORKS FINE BOTH INCLUSIVE###### 
    // dnum, dname, dlocation
    //convert nums to string
	int dnum = $1;
	char s1[12];
	sprintf(s1, "%d", dnum);
	char* dname_t=malloc(sizeof(char)*(strlen($5)+1));
	dname_t = $5;
	char* dname=malloc(sizeof(char)*(strlen($5)-1));	
	for(int i=0;i<strlen($5)-2;i++){
		dname[i] = dname_t[i+1];
	}
	char* dloc_t =malloc(sizeof(char)*(strlen($9)+1));
	dloc_t = $9;
	char* dloc=malloc(sizeof(char)*(strlen($9)-1));	
	for(int i=0;i<strlen($9)-2;i++){
		dloc[i] = dloc_t[i+1];
	}
	char* s=malloc(sizeof(char)*(5+strlen(s1)+2+6+strlen(dname)+2+10+strlen(dloc)+1));
	strcpy(s, "dnum ");
	strcat(s,s1);
	strcat(s, ", ");
	strcat(s, "dname ");
	strcat(s, dname);
	strcat(s, ", ");
	strcat(s, "dlocation ");
	strcat(s, dloc);
	$$=s;
    }
  |NUM S COMMA S VALUE S COMMA S NUM S COMMA S NUM S COMMA S NUM S COMMA S VALUE {
    // eid, ename, egae, salary, deptno, eaddress
	int eid = $1;
	char s1[12];
	sprintf(s1, "%d", eid);
	
	char* ename_t=malloc(sizeof(char)*(strlen($5)+1));
	ename_t = $5;
	char* ename=malloc(sizeof(char)*(strlen($5)-1));	
	for(int i=0;i<strlen($5)-2;i++){
		ename[i] = ename_t[i+1];
	}
	
	int egae = $9;
	char s2[12];
	sprintf(s2, "%d", egae);
	
	int salary = $13;
	char s3[12];
	sprintf(s3, "%d", salary);

	int deptno = $17;
	char s4[12];
	sprintf(s4, "%d", deptno);
	
	char* eadd_t =malloc(sizeof(char)*(strlen($21)+1));
	eadd_t = $21;
	char* eadd=malloc(sizeof(char)*(strlen($21)-1));	
	for(int i=0;i<strlen($21)-2;i++){
		eadd[i] = eadd_t[i+1];
	}

	char* s=malloc(sizeof(char)*(4+strlen(s1)+2+6+strlen(ename)+2+5+strlen(s2)+2+9+strlen(eadd)+2+7+strlen(s3)+2+7+strlen(s4)+1));
	strcpy(s, "eid ");
	strcat(s,s1);
	strcat(s, ", ");
	strcat(s, "ename ");
	strcat(s, ename);
	strcat(s, ", ");
	strcat(s, "egae ");
	strcat(s, s2);
	strcat(s, ", ");
	strcat(s, "salary ");
	strcat(s, s3);
	strcat(s, ", ");
	strcat(s, "deptno ");
	strcat(s, s4);
	strcat(s, ", ");
	strcat(s, "eaddress ");
	strcat(s, eadd);
	$$=s;
    }
FIELDS: FIELDS S COMMA S ID {
	//HARDCODED VALUES FOR EACH STRCMP
	char* id = malloc(sizeof(char)*(strlen($5))+1);
	id = $5;
	if(strcmp(id, "dnum")==0){
		display[0]=1;
	}
	if(strcmp(id, "eid")==0){
		display[0]=1;
	}
	if(strcmp(id, "dname")==0){
		display[1]=1;
	}
	if(strcmp(id, "ename")==0){
		display[1]=1;
	}
	if(strcmp(id, "dlocation")==0){
		display[2]=1;
	}
	if(strcmp(id, "eaddress")==0){
		display[2]=1;
	}
	if(strcmp(id, "egae")==0){
		display[3]=1;
	}
	if(strcmp(id, "salary")==0){
		display[4]=1;
	}
	if(strcmp(id, "deptno")==0){
		display[5]=1;
	}
	}
  | ID {
	//HARDCODED VALUES FOR EACH STRCMP
		char* id = malloc(sizeof(char)*(strlen($1))+1);
		id = $1;
		if(strcmp(id, "dnum")==0){
			display[0]=1;
		}
		if(strcmp(id, "eid")==0){
			display[0]=1;
		}
		if(strcmp(id, "dname")==0){
			display[1]=1;
		}
		if(strcmp(id, "ename")==0){
			display[1]=1;
		}
		if(strcmp(id, "dlocation")==0){
			display[2]=1;
		}
		if(strcmp(id, "eaddress")==0){
			display[2]=1;
		}
		if(strcmp(id, "egae")==0){
			display[3]=1;
		}
		if(strcmp(id, "salary")==0){
			display[4]=1;
		}
		if(strcmp(id, "deptno")==0){
			display[5]=1;
		}
		}
  ;
NEWVAL: ID {/**/}
  | NUM {/**/}
  ;
CONDITIONS: CONDITIONS S AND S CONDITION{
	struct Conditions *cns;
	cns = (struct Conditions*)malloc(sizeof(struct Conditions));
	cns->type = 1;
	cns->right = $5;
	if (chead == NULL) {
		chead = cns;
	}
	else{
		if(ctemp == NULL){
			ctemp = cns;
			chead->left = ctemp;
		}
		else{
			ctemp->left = cns;
			ctemp = ctemp->left;
		}
	}
	}
  | CONDITIONS S OR S CONDITION {
	struct Conditions *cns;
	cns = (struct Conditions*)malloc(sizeof(struct Conditions));
	cns->type = 2;
	cns->right = $5;
	if (chead == NULL) {
		chead = cns;
	}
	else{
		if(ctemp == NULL){
			ctemp = cns;
			chead->left = ctemp;
		}
		else{
			ctemp->left = cns;
			ctemp = ctemp->left;
		}
	}
	}
  | CONDITION {
	struct Conditions *cns;
	cns = (struct Conditions*)malloc(sizeof(struct Conditions));
	cns->type = 0;
	cns->right = $1;
	if (chead == NULL) {
		chead = cns;
	}
	else{
		if(ctemp == NULL){
			ctemp = cns;
			chead->left = ctemp;
		}
		else{
			ctemp->left = cns;
			ctemp = ctemp->left;
		}
	}
	}
  ;
CONDITION: ID S EQUAL S ID {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	char* expected_val = malloc(sizeof(char)*(strlen($5)+1));
	expected_val = $5;
	c->min_val = 0;
	c->max_val = 0;
	c->ex_val = expected_val;
	$$=c;		
	}
  | ID S NE S ID {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	char* expected_val = malloc(sizeof(char)*(strlen($5)+1));
	expected_val = $5;
	c->min_val = 0;
	c->max_val = 1; // to ensure inequality strcmp(...,...) == c->max_val
	c->ex_val = expected_val;
	$$=c;		
	}
  | ID S EQUAL S NUM {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	c->min_val = $5;
	c->max_val = $5;
	$$=c;
	}
  | ID S NE S NUM {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	c->min_val = $5;
	c->max_val = -1;
	$$=c;
	}
  | ID S GT S NUM {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	c->min_val = $5 + 1;
	c->max_val = 200000000;
	$$=c;
	}
  | ID S GE S NUM {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	c->min_val = $5;
	c->max_val = 200000000;
	$$=c;
	}
  | ID S LT S NUM {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	c->min_val = -200000000;
	c->max_val = $5-1;
	$$=c;
	}
  | ID S LE S NUM {
	struct Cond *c;
	c = (struct Cond*)malloc(sizeof(struct Cond));
	char* name=malloc(sizeof(char)*(strlen($1)+1));
	name = $1;
	c->field = name;
	c->min_val = -200000000;
	c->max_val = $5;
	$$=c;
	}
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
