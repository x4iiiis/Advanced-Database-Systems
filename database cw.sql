drop table BankAccount;
drop table employee;
drop table customer;
drop table customer_account;
drop table branch;

drop type customer_account_type;
drop type customer_type;
drop type employee_type;
drop type account_type;
drop type branch_type;
drop type employee;
drop type person;
drop type PersonName;
drop type Address;




CREATE TYPE PersonName AS OBJECT 
(title VARCHAR2(4), 
firstname VARCHAR2(20), 
surname VARCHAR2(20))
NOT FINAL;
/

CREATE TYPE Address AS OBJECT 
(street VARCHAR2(20), 
city VARCHAR2(20), 
postcode VARCHAR2(8))
NOT FINAL;
/

CREATE TYPE Person AS OBJECT
(pName PersonName,
pAddy Address,
niNum VARCHAR2(5))
NOT FINAL;
/

CREATE TYPE branch_type AS OBJECT
(bID NUMBER(4),
bAddy Address,
bPhone NUMBER(11));
/
CREATE TABLE branch of branch_type
(PRIMARY KEY(bID));
/

CREATE TYPE employee_type UNDER Person
(empID NUMBER(3),
empHomePhone NUMBER(11),
empMobile1 NUMBER(11),
empMobile2 NUMBER(11),
supervisorID NUMBER(3),
position VARCHAR(20),
salary NUMBER(6),
bID REF branch_type,
joinDate DATE);
/
CREATE TABLE employee OF employee_type
(PRIMARY KEY(empID),
FOREIGN KEY(bID) REFERENCES branch);
/

CREATE TYPE customer_type UNDER Person
(custID NUMBER(4),
custHomePhone NUMBER(11),
custMobile1 NUMBER(11),
custMobile2 NUMBER(11));
/
CREATE TABLE customer OF customer_type
(PRIMARY KEY(custID));
/


CREATE TYPE account_type AS OBJECT
(AccNum NUMBER(4),
accType VARCHAR(10),
balance NUMBER(6),
bID REF branch_type,
inRate FLOAT(6),
limitOfFreeOD NUMBER(3),
openDate DATE);
/
CREATE TABLE BankAccount OF account_type
(PRIMARY KEY(AccNum),
FOREIGN KEY(bID) REFERENCES branch);
/


CREATE TYPE customer_account_type AS OBJECT
(custID REF customer_type,
accNum REF account_type);
/
CREATE TABLE customer_account OF customer_account_type;
/



