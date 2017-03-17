---------------------------------------------Query space-----------------
--a)
COLUMN pName.firstname HEADING 'First Name'
COLUMN pName.surname HEADING 'Surname'

SELECT e.pName.firstname, e.pName.surname
FROM employee e
WHERE e.pAddy.city LIKE 'Glasgow' AND e.pName.firstname LIKE '%on%';


--b)
COLUMN COUNT(ba.accType) HEADING 'Amount of Savings Accounts'
COLUMN bID.bAddy.street HEADING 'Street'
COLUMN bID.bAddy.city HEADING 'City'
COLUMN bID.bAddy.postcode HEADING 'Postcode'

SELECT COUNT
(ba.accType), ba.bID.bAddy.street, ba.bID.bAddy.city, ba.bID.bAddy.postcode
FROM BankAccount ba
WHERE ba.accType LIKE 'Savings'
GROUP BY ba.bID.bAddy.street, ba.bID.bAddy.city, ba.bID.bAddy.postcode;


--c) without OD
COLUMN custID.pName.title HEADING 'Title'
COLUMN custID.pName.firstname HEADING 'First Name'
COLUMN custID.pName.surname HEADING 'Surname'
COLUMN MAX(ca.accNum.balance) HEADING 'Balance'
COLUMN accNum.bID.bID HEADING 'Branch ID'

SELECT ca.custID.pName.title, ca.custID.pName.firstname, ca.custID.pName.surname, MAX(ca.accNum.balance), ca.accNum.bID.bID  
FROM customer_account ca
WHERE ca.accNum.accType LIKE 'Savings'
GROUP BY ca.custID.pName.title, ca.custID.pName.firstname, ca.custID.pName.surname, ca.accNum.bID.bID;


--d)
COLUMN bID.bAddy.street HEADING 'Work Street' 
COLUMN bID.bAddy.city HEADING 'Work City'
COLUMN bID.bAddy.postcode HEADING 'Work Postcode'
COLUMN accNum.bID.bAddy.street HEADING 'Account Street'
COLUMN accNum.bID.bAddy.city HEADING 'Account City'
COLUMN accNum.bID.bAddy.postcode HEADING 'Account Postcode'

SELECT e.bID.bAddy.street, e.bID.bAddy.city, e.bID.bAddy.postcode, ca.accNum.bID.bAddy.street, ca.accNum.bID.bAddy.city, ca.accNum.bID.bAddy.postcode
FROM employee e, customer_account ca
WHERE ca.custID.niNum = e.niNum AND e.supervisorID.position LIKE 'Manager';


--e)
--SELECT ca.custID.bID.bID, ca.accNum.pName.title, ca.accNum.pName.firstname, ca.accNum.pName.surname, MAX(ca.custID.limitOfFreeOD)
--WHERE 


--f)
SELECT c.pName.title, c.pName.firstname, c.pName.surname, p.*
FROM customer c, table(c.pContact.mobileNumbers) p
WHERE (SELECT COUNT (*) FROM table(c.pContact.mobileNumbers) p) > 1 AND SUBSTR(p.COLUMN_VALUE, 1,4) = '0770';