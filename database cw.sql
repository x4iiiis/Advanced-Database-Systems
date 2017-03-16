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
  --supervisorID VARCHAR2(3),
  supervisorID REF employee_type,
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
    CONSTRAINT custHomePhone_const CHECK(custHomePhone IS NOT NULL)
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
      Address('Centre',	'Livingston', 'FT1 3HR'),
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
      '200',
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
      '50',
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
      '50',
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
      '50',
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


--Employee
INSERT INTO employee VALUES
(
      FullName('Mrs', 'Alison', 'Smith'),
      Address('Dart', 'Edinburgh', 'EH10 5TT'),
      'NI001',
      '101',
      '01312125555',
      '07705623443', 
      '07907812345',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = ''
      ),
      'Head', 
      '50000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '901'
      ), 
			'01-FEB-08'
);
/

INSERT INTO employee VALUES 
(
      FullName('Mr', 'John', 'William'),
      Address('New', 'Edinburgh', 'EH24AB'),
      'NI010',
      '105',
      '01312031990',
      '07902314551', 
      '07701234567',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '101'
      ),
      'Manager', 
      '40000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '901'
      ), 
			'04-MAR-09'
);
/

INSERT INTO employee VALUES
(
      FullName('Mr', 'Mark', 'Slack'),
      Address('Old', 'Edinburgh', 'EH94BB'),
      'NI120',
      '108',
      '01312102211',
      '', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '105'
      ),
      'Accountant', 
      '30000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '901'
      ), 
			'01-FEB-12'
);
/

INSERT INTO employee VALUES
(
      FullName('Mr', 'Jack', 'Smith'),
      Address('Dart', 'Edinburgh', 'EH16EA'),
      'NI810',
      '804',
      '01311112223',
      '07812098900', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '801'
      ),
      'Leader', 
      '35000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '908'
      ), 
			'05-FEB-14'
);
/

INSERT INTO employee VALUES
(
      FullName('Mrs',	'Lauren',	'King'),
      Address('Mansefield',	'Livingston',	'EH53 0DE'),
      'NI015',
      '451',
      '01506515151',
      '07707515151', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '352'
      ),
      'Accountant',	
      '30000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '365'
      ), 
			'15-MAR-17'
);
/

INSERT INTO employee VALUES
(
      FullName('Miss',	'Chelsea',	'Pittman'),
      Address('Letham',	'Livingston',	'EH20 0FV'),
      'NI205',
      '801',
      '01506200595',
      '07763187321', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = ''
      ),
      'Head',	
      '50000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '908'
      ), 
			'20-MAY-16'
);
/

INSERT INTO employee VALUES
(
      FullName('Mr', 'David',	'Gray'),
      Address('Hampden',	'Glasgow',	'EH32 7HB'),
      'NI114',
      '442',
      '01411233232',
      '07070707070', 
      '07626262626',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = ''
      ),
      'Head',
      '50000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '908'
      ), 
			'21-MAY-16'
);
/

INSERT INTO employee VALUES
(
      FullName('Mr',	'Anthony',	'Stokes'),
      Address('Easter',	'Edinburgh',	'EH32 6TH'),
      'NI777',
      '352',
      '01411101010',
      '07732076232', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '291'
      ),
      'Leader',	
      '35000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '365'
      ), 
			'26-DEC-10'
);
/

INSERT INTO employee VALUES
(
      FullName('Miss',	'Allison',	'Thomson'),
      Address('Lodge',	'Glenrothes',	'GR08 3BD'),
      'NI108',
      '100',
      '01526696969',
      '07812666999', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = ''
      ),
      'Head',	
      '50000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '007'
      ), 
			'05-OCT-14'
);
/

INSERT INTO employee VALUES
(
      FullName('Mrs',	'Eleanor',	'Kay'),
      Address('Main',	'Livingston',	'EH69 2DB'),
      'NI180',
      '550',
      '01506443322',
      '07897261900', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '352'
      ),
      'Accountant',	
      '30000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '365'
      ), 
			'19-AUG-04'
);
/

INSERT INTO employee VALUES
(
      FullName('Miss',	'Sarah',	'Barbour'),
      Address('Harrysmuir',	'Bathgate',	'BG02 9AV'),
      'NI360',
      '291',
      '01572030303',
      '07898222222', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '998'
      ),
      'Manager',	
      '40000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '365'
      ), 
			'27-NOV-11'
);
/

INSERT INTO employee VALUES
(
      FullName('Mr',	'Jason',	'Cummings'),
      Address('Tynie',	'Edinburgh',	'LO43 7TH'),
      'NI720',
      '114',
      '01010101031',
      '07076262707', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '100'
      ),
      'Manager',	
      '40000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '007'
      ), 
			'14-FEB-06'
);
/

INSERT INTO employee VALUES 
(
      FullName('Mr',	'David',	'Draiman'),
      Address('Gig',	'Glasgow',	'BS11 3AD'),
      'NI870',
      '867',
      '01411112223',
      '07852468502', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '114'
      ),
      'Leader',	
      '35000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '007'
      ), 
			'05-JUL-14'
);
/

INSERT INTO employee VALUES 
(
      FullName('Mrs',	'Karen',	'Hatton'),
      Address('Calder',	'Livingston',	'SM66 6SD'),
      'NI804',
      '190',
      '01506115523',
      '07812748900', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '867'
      ),
      'Accountant',	
      '30000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '007'
      ), 
			'15-JUN-12'
);
/

INSERT INTO employee VALUES 
(
      FullName('Mr',	'Matt',	'Shadows'),
      Address('Bat',	'Inverness',	'IV39 2EV'),
      'NI900',
      '290',
      '01911118223',
      '07773063018', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '998'
      ),
      'Accountant',	
      '30000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '321'
      ), 
			'08-MAY-16'
);
/

INSERT INTO employee VALUES 
(
      FullName('Mrs',	'Shanye',	'West'),
      Address('Swag',	'Edinburgh',	'XO32 9GG'),
      'NI881',
      '300',
      '01315245223',
      '07888098900', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '100'
      ),
      'Manager',	
      '40000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '007'
      ), 
			'07-APR-15'
);
/

INSERT INTO employee VALUES
(
      FullName('Miss',	'Lzzy',	'Hale'),
      Address('Storm',	'Dundee',	'HA13 5TO'),
      'NI274',
      '998',
      '01611971223',
      '07812095901', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = ''
      ),
      'Head',
      '50000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '321'
      ), 
			'06-MAR-13'
);
/

INSERT INTO employee VALUES 
(
      FullName('Mr',	'Yer',	'Da'),
      Address('Patter',	'Perth',	'YD12 3PP'),
      'NI753',
      '777',
      '01711150223',
      '07812069904', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '118'
      ),
      'Accountant',	
      '30000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '888'
      ), 
			'03-JAN-10'
);
/

INSERT INTO employee VALUES 
(
      FullName('Miss',	'Ruth',	'Davidson'),
      Address('Lemon',	'Wishaw',	'LI42 4WM'),
      'NI765',
      '118',
      '01311112229',
      '07812098927', 
      '',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = '582'
      ),
      'Leader',
      '35000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '888'
      ), 
			'06-FEB-14'
);
/

INSERT INTO employee VALUES
(
      FullName('Mr', 'Sean',	'Baxter'),
      Address('McDonald',	'Perth',	'EH32 7SB'),
      'NI224',
      '582',
      '01411582582',
      '07582585858', 
      '07626582626',
      (
            SELECT REF(e)
            FROM employee e
            WHERE e.empID = ''
      ),
      'Head',
      '50000',
      (
            SELECT REF(b)
						FROM branch b
						WHERE b.bID = '888'
      ), 
			'23-MAY-16'
);
/

--Customer
INSERT INTO customer VALUES
(
      FullName('Mr', 'Jack', 'Smith'),
      Address('Adam', 'Edinburgh', 'EH1 6EA'),
      'NI810',
      '1002',
      '01311112223',
      '0781209890', 
      '0770234567'
  );
/

INSERT INTO customer VALUES
(
      FullName('Ms', 'Anna', 'Smith'),
      Address('Adam', 'Edinburgh', 'EH1 6EA'),
      'NI310',
      '1003',
      '01311112223',
      '0770111222',
      ''
);
/

INSERT INTO customer VALUES
(
      FullName('Mr', 'Liam', 'Bain'),
	    Address('New', 'Edinburgh', 'EH2 8XN'),
      'NI034',
      '1098',
      '01314425567',
      '',
      ''
);
/

INSERT INTO customer VALUES 
(
      FullName('Mr', 'Ronnie', 'Pickering'),
      Address('Roadrage', 'Edinburgh', 'ED11 6RR'),
      'NI235',
      '1013',
      '01314513204', 
      '0781205134',
      ''
);	
/

INSERT INTO customer VALUES
(			
      FullName('Mr',	'Judd',	'Trump'),
      Address('Table',	'Edinburgh',	'EH14 7JT'),
      'NI741',
      '0147',
      '01311471471', 
      '07702011616',
      ''
);	
/

INSERT INTO customer VALUES
(	 				
      FullName('Miss',	'Amy',	'Thomson'),
      Address('Dug',	'Edinburgh',	'EH21 0EW'),
      'NI210',
      '0210',
      '01310210210', 
      '07701656716',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mrs',	'Avril',	'Lavigne'),
      Address('Skater',	'Glasgow',	'HH23 3YY'),
      'NI838',
      '6070',
      '01410838383', 
      '07896101010',
      '07090909078'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Derek',	'Riordan'),
      Address('Deek',	'Edinburgh',	'DO07 4TH'),
      'NI033',
      '6207',
      '01317776262', 
      '07777777777',
      ''
);	
/

INSERT INTO customer VALUES
(					
      FullName('Mr',	'Ronnie',	'OSullivan'),
      Address('Century',	'Edinburgh',	'EH14 7RO'),
      'NI147',
      '1147',
      '01310100147', 
      '07147147147',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Miss',	'Ava',	'Barbour'),
      Address('Station',	'Bathgate',	'BG03 4VA'),
      'NI434',
      '3020',
      '01516884932', 
      '',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Miss',	'Joanna',	'Robertson'),
      Address('Maxi',	'Livingston',	'EH53 9OT'),
      'NI910',
      '0910',
      '01506884072', 
      '07702011616',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mrs',	'Helen',	'Wilson'),
      Address('Nurse',	'Aberdeen',	'AB53 7HB'),
      'NI333',
      '1110',
      '01904886343', 
      '07762999999',
      '07911911911'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Mixu',	'Paatelainen'),
      Address('Traing',	'Dundee',	'WT10 0FP'),
      'NI062',
      '6262',
      '01880626266', 
      '07626200762',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Miss',	'Mei',	'Ling'),
      Address('Metal',	'Inverness',	'IV04 4MG'),
      'NI111',
      '1000',
      '09901010101', 
      '07701212121',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Dennis',	'Bergkamp'),
      Address('Spin',	'Motherwell',	'MW08 6KB'),
      'NI044',
      '3040',
      '01566060606', 
      '07789721567',
      ''
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'John', 'McGinn'),
      Address('Super',	'Paisley',	'WG30 3JM'),
      'NI579',
      '3030',
      '01333777864', 
      '07792303030',
      ''
);	
/

INSERT INTO customer VALUES 
(						
      FullName('Mr',	'Thierry',	'Henry'),
      Address('Boss',	'Glenrothes',	'GR14 1TH'),
      'NI818',
      '3004',
      '08655876255', 
      '07703040304',
      '07777343434'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Franck',	'Sauzee'),
      Address('God',	'Perth',	'LG05 1FS'),
      'NI136',
      '1312',
      '01756334443', 
      '07705776622',
      ''
);	
/

INSERT INTO customer VALUES 
(						
      FullName('Ms',	'Blair',	'Waldorf'),
      Address('Queen',	'Kilmarnock',	'QB01 1WD'),
      'NI001',
      '0001',
      '01234567890', 
      '07701010101',
      '07101010101'
);	
/

INSERT INTO customer VALUES 
(					
      FullName('Mr',	'Neil',	'Robertson'),
      Address('Skippy',	'Dunfermline',	'DF12 3AU'),
      'NI080',
      '8888',
      '01237889256', 
      '07799778855',
      ''
);	
/


