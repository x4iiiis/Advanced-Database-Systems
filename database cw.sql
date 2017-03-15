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
drop type FullName;
drop type Address;




CREATE TYPE FullName AS OBJECT 
(
  title VARCHAR2(4), 
  firstname VARCHAR2(20), 
  surname VARCHAR2(20)
)
NOT FINAL;
/

CREATE TYPE Address AS OBJECT 
(
  street VARCHAR2(20), 
  city VARCHAR2(20), 
  postcode VARCHAR2(8)
)
NOT FINAL;
/

CREATE TYPE Person AS OBJECT
(
  pName FullName,
  pAddy Address,
  niNum VARCHAR2(5)
)
NOT FINAL;
/

CREATE TYPE branch_type AS OBJECT
(
  bID VARCHAR2(4),
  bAddy Address,
  bPhone VARCHAR2(11)
);
/
CREATE TABLE branch of branch_type
(
    PRIMARY KEY(bID),
    
    CONSTRAINT branchStreet_const CHECK(bAddy.street IS NOT NULL),
    CONSTRAINT branchCity_const CHECK(bAddy.city IS NOT NULL),
    CONSTRAINT branchPostCode_const CHECK(bAddy.postcode IS NOT NULL),
    CONSTRAINT branchPhone_const CHECK(bPhone IS NOT NULL)
);
/

CREATE TYPE employee_type UNDER Person
(
  empID VARCHAR2(3),
  empHomePhone VARCHAR2(11),
  empMobile1 VARCHAR2(11),
  empMobile2 VARCHAR2(11),
  supervisorID VARCHAR2(3),
  position VARCHAR(20),
  salary VARCHAR2(6),
  bID REF branch_type,
  joinDate DATE
);
/
CREATE TABLE employee OF employee_type
(
    PRIMARY KEY(empID),
    FOREIGN KEY(bID) REFERENCES branch,
    
    CONSTRAINT empStreet_const CHECK(pAddy.street IS NOT NULL),
    CONSTRAINT empCity_const CHECK(pAddy.city IS NOT NULL),
    CONSTRAINT empPostCode_const CHECK(pAddy.postcode IS NOT NULL),
    CONSTRAINT empTitle_const CHECK(pName.title IN ('Mr', 'Mrs', 'Ms', 'Miss', 'Dr')),
    CONSTRAINT empFirstName_const CHECK(pName.firstname IS NOT NULL),
    CONSTRAINT empSurName_const CHECK(pName.surname IS NOT NULL),
    CONSTRAINT empNiNum_const UNIQUE(niNum),
    CONSTRAINT empHomePhone_const CHECK(empHomePhone IS NOT NULL),
    CONSTRAINT empMobile1_const CHECK(empMobile1 IS NOT NULL),
    CONSTRAINT empSupervisor_const CHECK(supervisorID IS NOT NULL),
    CONSTRAINT empPosition_const CHECK (position IN ('Head', 'Manager', 'Accountant', 'Leader')),
    CONSTRAINT empSalary_const CHECK(salary IS NOT NULL),
    CONSTRAINT empJoinDate_const CHECK(joinDate IS NOT NULL)     
);
/

CREATE TYPE customer_type UNDER Person
(
  custID VARCHAR2(4),
  custHomePhone VARCHAR2(11),
  custMobile1 VARCHAR2(11),
  custMobile2 VARCHAR2(11)
);
/
CREATE TABLE customer OF customer_type
(
    PRIMARY KEY(custID),
    
    CONSTRAINT custStreet_const CHECK(pAddy.street IS NOT NULL),
    CONSTRAINT custCity_const CHECK(pAddy.city IS NOT NULL),
    CONSTRAINT custPostCode_const CHECK(pAddy.postcode IS NOT NULL),
    CONSTRAINT custTitle_const CHECK(pName.title IS NOT NULL),
    CONSTRAINT custFirstName_const CHECK(pName.firstname IS NOT NULL),
    CONSTRAINT custSurName_const CHECK(pName.surname IS NOT NULL),
    CONSTRAINT custNiNum_const UNIQUE(niNum),
    CONSTRAINT custHomePhone_const CHECK(custHomePhone IS NOT NULL),
    CONSTRAINT custMobile1_const CHECK(custMobile1 IS NOT NULL)
);
/


CREATE TYPE account_type AS OBJECT
(
  AccNum VARCHAR2(4),
  accType VARCHAR(10),
  balance VARCHAR2(9),
  bID REF branch_type,
  inRate FLOAT(6),
  limitOfFreeOD VARCHAR2(3),
  openDate DATE
);
/
CREATE TABLE bankaccount OF account_type
(
    PRIMARY KEY(AccNum),
    FOREIGN KEY(bID) REFERENCES branch,
    
    CONSTRAINT accType_const CHECK(accType IN ('Savings', 'Current')),
    CONSTRAINT balance_const CHECK(balance IS NOT NULL),
    CONSTRAINT inRate_const CHECK(inRate IS NOT NULL),
    CONSTRAINT openDate_const CHECK(openDate IS NOT NULL)
);
/


CREATE TYPE customer_account_type AS OBJECT
(
  custID REF customer_type,
  accNum REF account_type
);
/
CREATE TABLE customer_account OF customer_account_type;
/



--------------------Data insertion
--Branch
INSERT INTO branch VALUES
(
      '901',
      Address('Market', 'Edinburgh', 'EH1 5AB'),
      '01311235560'
);
/

INSERT INTO branch VALUES
(
      '908',
      Address('Bridge', 'Glasgow', 'G18 1QQ'),
      '01413214556'
);
/

INSERT INTO branch VALUES
(
      '666',
      Address('Collinton',	'Edinburgh',	'EH6 9HE'),	
      '01506884072'
);
/

INSERT INTO branch VALUES
(
      '543',	
      Address('Morningside',	'Edinburgh',	'AS7 7HY'),
      '01506888999'
);
/

INSERT INTO branch VALUES
(
      '345',	
      Address('Main',	'Bathgate',	'AR3 6YH'),
      '01508992192'

);
/

INSERT INTO branch VALUES
(
      '365',
      Address('Side',	'Somewhere', 'FT1 3HR'),
      '01507999222'

);
/

INSERT INTO branch VALUES
(
      '007',	
      Address('Leith Walk',	'Edinburgh',	'HB3 2RG'),
      '01311902323'

);
/

INSERT INTO branch VALUES
(
      '321',
      Address('Bank',	'Aberdeen',	'JJ4 3IJ'),
      '01503888777'

);
/

INSERT INTO branch VALUES
(
      '456',
      Address('Down',	'Dundee',	'JH4 3HA'),
      '01592888723'

);
/

INSERT INTO branch VALUES
(
      '789',
      Address('North',	'Inverness',	'KK2 8KJ'),
      '01567898989'

);
/

INSERT INTO branch VALUES
(
      '999',
      Address('Twist',	'Motherwell',	'YD5 3WH'),
      '01234567890'

);
/

INSERT INTO branch VALUES
(
      '245',
      Address('Main',	'Wishaw',	'CJ4 7DT'),
      '09876543210'

);
/

INSERT INTO branch VALUES
(
      '696',
      Address('Love',	'Paisley',	'KS5 6JH'),
      '09876789876'

);
/

INSERT INTO branch VALUES
(
      '969',
      Address('Raith',	'Kirkaldy',	'YL1 9TT'),
      '09453268975'

);
/

INSERT INTO branch VALUES
(
      '555',
      Address('Zoo Lane',	'Glenrothes',	'HT5 1KK'),
      '09834567876'

);
/

INSERT INTO branch VALUES
(
      '233',
      Address('Knock',	'Kelty',	'HT4 5GG'),
      '06543878765'

);
/

INSERT INTO branch VALUES
(
      '888',	
      Address('Saint',	'Perth',	'EH5 3OD'),
      '01234987654'

);
/

INSERT INTO branch VALUES
(
      '159',
      Address('Griffith',	'Kilmarnock',	'JK4 JK5'),
      '01522333444'

);
/

INSERT INTO branch VALUES
(
      '500',
      Address('Pittencrief',	'Dunfermline',	'HG5 9KS'),
      '01234666666'

);
/

INSERT INTO branch VALUES
(
      '117',
      Address('Sierra',	'Edinburgh',	'HER 5AJ'),
      '01666999666'

);
/

--account
INSERT INTO bankaccount VALUES
(
      '1001',
      'Current',
      '820.50',
      (
          SELECT REF(b) 
          FROM branch b
          WHERE b.bID = '901'
      ),
      '0.005',
      '800',
      '01-MAY-11'
);
/
	
INSERT INTO bankaccount VALUES
(
      '1010',
      'Savings',
      '3122.20',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '901'
      ),
      '0.02',
      '',
      '08-MAR-10'
);
/

INSERT INTO bankaccount VALUES
(
      '8002',
      'Current',
      '200',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '908'
      ),
      '0.005',
      '100',
      '05-MAY-09'
);
/

INSERT INTO bankaccount VALUES
(
      '1902',
      'Current',
      '7062.32',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '007'
      ),
      '0.32',
      '114',
      '21-MAY-16'
);
/

INSERT INTO bankaccount VALUES 
(
      '1875',
      'Savings',
      '8.20',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '543'
      ),
      '0.002',
      '',
      '07-FEB-11'
);
/

INSERT INTO bankaccount VALUES 
(
      '3232',
      'Current',
      '4000.00',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '345'
      ),
      '0.12',
      '',
      '18-JUL-13'
);
/

INSERT INTO bankaccount VALUES
(
      '0762',
      'Savings',
      '598267.35',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '365'
      ),
      '0.04',
      '',
      '07-SEP-06'
);
/

INSERT INTO bankaccount VALUES
(
      '0114',
      'Current',
      '7062.51',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '007'
      ),
      '0.05',
      '999',
      '25-JAN-12'
);
/

INSERT INTO bankaccount VALUES
(
      '3333',
      'Current',
      '180.92',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '321'
      ),
      '0.20',
      '50',
      '12-APR-15'
);
/

INSERT INTO bankaccount VALUES
(
      '4444',
      'Savings',
      '332.28',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '456'
      ),
      '0.01',
      '',
      '28-FEB-09'
);
/

INSERT INTO bankaccount VALUES
(
      '5555',
      'Current',
      '95.80',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '789'
      ),
      '0.023',
      '',
      '16-AUG-16'
);
/

INSERT INTO bankaccount VALUES
(
      '6666',
      'Current',
      '450.71',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '999'
      ),
      '0.029',
      '90',
      '08-MAR-05'
);
/

INSERT INTO bankaccount VALUES
(
      '8774',
      'Savings',
      '5001.67',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '245'
      ),
      '0.198',
      '',
      '08-NOV-10'
);
/

INSERT INTO bankaccount VALUES
(
      '4566',
      'Current',
      '110.00',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '696'
      ),
      '0.003',
      '',
      '09-JUN-14'
);
/

INSERT INTO bankaccount VALUES
(
      '1223',
      'Savings',
      '9998.98',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '969'
      ),
      '0.1',
      '',
      '03-JAN-95'
);
/

INSERT INTO bankaccount VALUES
(
      '1114',
      'Savings',
      '976.52',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '555'
      ),
      '0.022',
      '',
      '06-APR-13'
);
/

INSERT INTO bankaccount VALUES
(
      '9864',
      'Savings',
      '3124.66',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '233'
      ),
      '0.045',
      '',
      '08-OCT-10'
);
/

INSERT INTO bankaccount VALUES
(
      '9871',
      'Current',
      '666.99',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '888'
      ),
      '0.045',
      '80',
      '18-SEP-14'
);
/

INSERT INTO bankaccount VALUES
(
      '1357',
      'Current',
      '69.96',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '159'
      ),
      '0.001',
      '',
      '01-OCT-11'
);
/

INSERT INTO bankaccount VALUES
(
      '2468',
      'Savings',
      '3122.89',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '500'
      ),
      '0.049',
      '',
      '26-DEC-07'
);
/

