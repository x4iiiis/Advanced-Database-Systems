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

CREATE TYPE NestedMobiles AS TABLE OF VARCHAR2(11);
/

CREATE TYPE ContactDetails AS OBJECT
(
  homeNumber VARCHAR(11),
  mobileNumbers NestedMobiles
)
NOT FINAL;
/


CREATE TYPE Person AS OBJECT
(
  pName FullName,
  pAddy Address,
  pContact ContactDetails,
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
    CONSTRAINT empPosition_const CHECK (position IN ('Head', 'Manager', 'Accountant', 'Leader')),
    CONSTRAINT empSalary_const CHECK(salary IS NOT NULL),
    CONSTRAINT empJoinDate_const CHECK(joinDate IS NOT NULL))
    NESTED TABLE pContact.mobileNumbers STORE AS empMobiles;
/

CREATE TYPE customer_type UNDER Person
(
  custID VARCHAR2(4)
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
    CONSTRAINT custNiNum_const UNIQUE(niNum))
    NESTED TABLE pContact.mobileNumbers STORE AS custMobiles;
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
      '7122.29',
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

INSERT INTO bankaccount VALUES
(
      '8642',
      'Savings',
      '3232.32',
      (
          SELECT REF(b)
          FROM branch b
          WHERE b.bID = '901'
      ),
      '0.032',
      '',
      '21-MAY-16'
);
/


--Employee
INSERT INTO employee VALUES
(
      FullName('Mrs', 'Alison', 'Smith'),
      Address('Dart', 'Edinburgh', 'EH10 5TT'),
      ContactDetails('01312125555', NestedMobiles('07705623443', '07907812345')),
      'NI001',
      '101',
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
      ContactDetails('01312031990', NestedMobiles('07902314551','07701234567')),
      'NI010',
      '105',
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
      FullName('Miss',	'Chelsea',	'Pittman'),
      Address('Letham',	'Livingston',	'EH20 0FV'),
      ContactDetails('01506200595', NestedMobiles('07763187321', '')),
      'NI205',
      '801',
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
      FullName('Mr', 'Anthony',	'Stokes'),
      Address('Hampden',	'Glasgow',	'EH32 7HB'),
      ContactDetails('01411233232', NestedMobiles('07070707070')),
      'NI114',
      '442',
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
      FullName('Miss',	'Allison',	'Thomson'),
      Address('Lodge',	'Glenrothes',	'GR08 3BD'),
      ContactDetails('01526696969', NestedMobiles('07812666999', '')),
      'NI108',
      '100',
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
      FullName('Mr',	'Jason',	'Cummings'),
      Address('Tynie',	'Edinburgh',	'LO43 7TH'),
      ContactDetails('01010101031', NestedMobiles('07076262707', '')),
      'NI720',
      '114',
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
      FullName('Mr',	'Jon',	'Kerridge'),
      Address('Fun',	'Glasgow',	'BS11 3AD'),
      ContactDetails('01411112223', NestedMobiles('07852468502', '')),
      'NI870',
      '867',
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
      ContactDetails('01506115523', NestedMobiles('07812748900', '')),
      'NI804',
      '190',
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
      FullName('Mrs',	'Shanye',	'West'),
      Address('Swag',	'Edinburgh',	'XO32 9GG'),
      ContactDetails('01315245223', NestedMobiles('07888098900', '')),
      'NI881',
      '300',
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
      ContactDetails('01611971223', NestedMobiles('07812095901', '')),
      'NI274',
      '998',
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
      FullName('Mr', 'Sean',	'Baxter'),
      Address('McDonald',	'Perth',	'EH32 7SB'),
      ContactDetails('01411582582', NestedMobiles('07582585858', '07626582626')),
      'NI224',
      '582',
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

INSERT INTO employee VALUES
(
      FullName('Mr', 'Mark', 'Slack'),
      Address('Old', 'Edinburgh', 'EH94BB'),
      ContactDetails('01312102211', NestedMobiles('', '')),
      'NI120',
      '108',
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
      ContactDetails('01311112223', NestedMobiles('07812098900', '')),
      'NI810',
      '804',
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
      FullName('Miss',	'Sarah',	'Barbour'),
      Address('Harrysmuir',	'Bathgate',	'BG02 9AV'),
      ContactDetails('01572030303', NestedMobiles('07898222222', '')),
      'NI360',
      '291',
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
      FullName('Mr',	'David',	'Gray'),
      Address('Easter',	'Edinburgh',	'EH32 6TH'),
      ContactDetails('01411101010', NestedMobiles('07732076232', '')),
      'NI777',
      '352',
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
      FullName('Mrs',	'Lauren',	'King'),
      Address('Mansefield',	'Livingston',	'EH53 0DE'),
      ContactDetails('01506515151', NestedMobiles('07707515151', '')),
      'NI015',
      '451',
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
      FullName('Mrs',	'Eleanor',	'Kay'),
      Address('Main',	'Livingston',	'EH69 2DB'),
      ContactDetails('01506443322', NestedMobiles('07897261900', '')),
      'NI180',
      '550',
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
      FullName('Mr',	'Matt',	'Shadows'),
      Address('Bat',	'Inverness',	'IV39 2EV'),
      ContactDetails('01911118223', NestedMobiles('07773063018', '')),
      'NI900',
      '290',
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
      FullName('Miss',	'Ruth',	'Davidson'),
      Address('Lemon',	'Wishaw',	'LI42 4WM'),
      ContactDetails('01311112229', NestedMobiles('07812098927', '')),
      'NI765',
      '118',
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
      FullName('Mr',	'Yer',	'Da'),
      Address('Patter',	'Perth',	'YD12 3PP'),
      ContactDetails('01711150223', NestedMobiles('07812069904', '')),
      'NI753',
      '777',
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

--Customer
INSERT INTO customer VALUES
(
      FullName('Mr', 'Jack', 'Smith'),
      Address('Adam', 'Edinburgh', 'EH1 6EA'),
      ContactDetails('01311112223', NestedMobiles('0781209890', '0770234567')),     
      'NI810',
      '1002'
);
/

INSERT INTO customer VALUES
(
      FullName('Ms', 'Anna', 'Smith'),
      Address('Adam', 'Edinburgh', 'EH1 6EA'),
      ContactDetails('01311112223', NestedMobiles('0770111222', '')),     
      'NI310',
      '1003'
);
/

INSERT INTO customer VALUES
(
      FullName('Mr', 'Liam', 'Bain'),
	    Address('New', 'Edinburgh', 'EH2 8XN'),
      ContactDetails('01314425567', NestedMobiles('', '')),     
      'NI034',
      '1098'
);
/

INSERT INTO customer VALUES 
(
      FullName('Mr', 'Ronnie', 'Pickering'),
      Address('Roadrage', 'Edinburgh', 'ED11 6RR'),
      ContactDetails('01314513204', NestedMobiles('0781205134', '')),     
      'NI235',
      '1013'
);	
/

INSERT INTO customer VALUES
(			
      FullName('Mr',	'Judd',	'Trump'),
      Address('Table',	'Edinburgh',	'EH14 7JT'),
      ContactDetails('01311471471', NestedMobiles('07702011616', '')),     
      'NI741',
      '0147'
);	
/

INSERT INTO customer VALUES
(	 				
      FullName('Miss',	'Amy',	'Thomson'),
      Address('Dug',	'Edinburgh',	'EH21 0EW'),
      ContactDetails('01310210210', NestedMobiles('07701656716', '')),     
      'NI210',
      '0210'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mrs',	'Avril',	'Lavigne'),
      Address('Skater',	'Glasgow',	'HH23 3YY'),
      ContactDetails('01410838383', NestedMobiles('07896101010', '07090909078')),     
      'NI838',
      '6070'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Derek',	'Riordan'),
      Address('Deek',	'Edinburgh',	'DO07 4TH'),
      ContactDetails('01317776262', NestedMobiles('07777777777', '')),     
      'NI033',
      '6207'
);	
/

INSERT INTO customer VALUES
(					
      FullName('Mr',	'Ronnie',	'OSullivan'),
      Address('Century',	'Edinburgh',	'EH14 7RO'),
      ContactDetails('01310100147', NestedMobiles('07147147147', '')),     
      'NI147',
      '1147'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Miss',	'Ava',	'Barbour'),
      Address('Station',	'Bathgate',	'BG03 4VA'),
      ContactDetails('01516884932', NestedMobiles('', '')),     
      'NI434',
      '3020'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Miss',	'Joanna',	'Robertson'),
      Address('Maxi',	'Livingston',	'EH53 9OT'),
      ContactDetails('01506884072', NestedMobiles('07702011616', '')),     
      'NI910',
      '0910'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mrs',	'Helen',	'Wilson'),
      Address('Nurse',	'Aberdeen',	'AB53 7HB'),
      ContactDetails('01904886343', NestedMobiles('07762999999', '07911911911')),     
      'NI333',
      '1110'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Mixu',	'Paatelainen'),
      Address('Traing',	'Dundee',	'WT10 0FP'),
      ContactDetails('01880626266', NestedMobiles('07626200762', '')),     
      'NI062',
      '6262'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Miss',	'Mei',	'Ling'),
      Address('Metal',	'Inverness',	'IV04 4MG'),
      ContactDetails('09901010101', NestedMobiles('07701212121', '')),     
      'NI111',
      '1000'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Dennis',	'Bergkamp'),
      Address('Spin',	'Motherwell',	'MW08 6KB'),
      ContactDetails('01566060606', NestedMobiles('07789721567', '')),     
      'NI044',
      '3040'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'John', 'McGinn'),
      Address('Super',	'Paisley',	'WG30 3JM'),
      ContactDetails('01333777864', NestedMobiles('07792303030', '')),     
      'NI579',
      '3030'
);	
/

INSERT INTO customer VALUES 
(						
      FullName('Mr',	'Thierry',	'Henry'),
      Address('Boss',	'Glenrothes',	'GR14 1TH'),
      ContactDetails('08655876255', NestedMobiles('07703040304', '07777343434')),     
      'NI818',
      '3004'
);	
/

INSERT INTO customer VALUES
(						
      FullName('Mr',	'Franck',	'Sauzee'),
      Address('God',	'Perth',	'LG05 1FS'),
      ContactDetails('01756334443', NestedMobiles('07705776622', '')),     
      'NI136',
      '1312'
);	
/

INSERT INTO customer VALUES 
(						
      FullName('Ms',	'Blair',	'Waldorf'),
      Address('Queen',	'Kilmarnock',	'QB01 1WD'),
      ContactDetails('01234567890', NestedMobiles('07701010101', '07101010101')),     
      'NI001',
      '0001'
);	
/

INSERT INTO customer VALUES 
(			
      FullName('Mr',	'David',	'Gray'),
      Address('Easter',	'Edinburgh',	'EH32 6TH'),
      ContactDetails('01411101010', NestedMobiles('07732076232', '')),     
      'NI777',
      '7077'
);	
/

INSERT INTO customer VALUES 
(					
      FullName('Mr',	'Neil',	'Robertson'),
      Address('Skippy',	'Dunfermline',	'DF12 3AU'),
      ContactDetails('01237889256', NestedMobiles('07799778855', '')),     
      'NI080',
      '8888'
);	
/


--Customer Account
INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1002'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1001'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1002'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1010'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1003'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1010'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1098'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '8002'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1013'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1902'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '0147'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1875'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '0210'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '3232'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '6070'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '0762'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '6207'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '0114'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1147'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '3333'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '3020'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '4444'
  )
);
/

INSERT INTO customer_account VALUES 
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '0910'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '5555'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1110'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '6666'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '6262'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '8774'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1000'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '4566'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '3040'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1223'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '3030'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1114'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '3004'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '9864'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '1312'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '9871'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '0001'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '1357'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '8888'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '2468'
  )
);
/

INSERT INTO customer_account VALUES
(
  (
    SELECT REF(c)
    FROM customer c
    WHERE c.custID = '7077'
  ),
  (
    SELECT REF(ba)
    FROM bankaccount ba
    WHERE ba.accNum = '8642'
  )
);
/