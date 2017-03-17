---------------------------------------------Query space-----------------
--a) 
--Display the first and last names of employees who live in Glasgow 
--and have "on" in their first name
COLUMN pName.firstname HEADING 'First Name'
COLUMN pName.surname HEADING 'Surname'
--Formatting the output
SELECT e.pName.firstname, e.pName.surname
FROM employee e
WHERE e.pAddy.city LIKE 'Glasgow' AND e.pName.firstname LIKE '%on%';
--Collecting the first and last names of the employees whose city 
--of residence is Glasgow and have a first name with "on" in it



--b)
--Find Display the number of savings accounts at each branch
--Display the number of savings accounts and the full branch address
COLUMN COUNT(ba.accType) HEADING 'Amount of Savings Accounts'
COLUMN bID.bAddy.street HEADING 'Street'
COLUMN bID.bAddy.city HEADING 'City'
COLUMN bID.bAddy.postcode HEADING 'Postcode'
--Formatting the output
SELECT COUNT (ba.accType), ba.bID.bAddy.street, ba.bID.bAddy.city, ba.bID.bAddy.postcode
FROM BankAccount ba
WHERE ba.accType LIKE 'Savings'
--Gathering each branch in the table's address, and counting the amount of
--savings accounts at each branch, displaying the result
GROUP BY ba.bID.bAddy.street, ba.bID.bAddy.city, ba.bID.bAddy.postcode;



--c) without OD
--Find the highest savings account balance at each branch
--Show the full name, balance and branch ID, and their OD limit from their current account
COLUMN custID.pName.title HEADING 'Title'
COLUMN custID.pName.firstname HEADING 'First Name'
COLUMN custID.pName.surname HEADING 'Surname'
COLUMN MAX(ca.accNum.balance) HEADING 'Balance'
COLUMN accNum.bID.bID HEADING 'Branch ID'
--Formatting the output
SELECT ca.custID.pName.title, ca.custID.pName.firstname, ca.custID.pName.surname, MAX(ca.accNum.balance), ca.accNum.bID.bID  
FROM customer_account ca
WHERE ca.accNum.accType LIKE 'Savings'
--Gathering the full names of customers with the most money in their savings
--accounts at each branch, and displaying their full name, balance, and the 
--branch ID at which their savings account is kept
GROUP BY ca.custID.pName.title, ca.custID.pName.firstname, ca.custID.pName.surname, ca.accNum.bID.bID;
--This query doesn't get the OD limit but it does the rest

--d)
--Find employees supervised by a manager and have accounts in the bank
--Display both the branch address that the employees work at, 
--as well as the branch address that they bank with
COLUMN bID.bAddy.street HEADING 'Work Street' 
COLUMN bID.bAddy.city HEADING 'Work City'
COLUMN bID.bAddy.postcode HEADING 'Work Postcode'
COLUMN accNum.bID.bAddy.street HEADING 'Account Street'
COLUMN accNum.bID.bAddy.city HEADING 'Account City'
COLUMN accNum.bID.bAddy.postcode HEADING 'Account Postcode'
--Formatting the output
SELECT e.bID.bAddy.street, e.bID.bAddy.city, e.bID.bAddy.postcode, ca.accNum.bID.bAddy.street, ca.accNum.bID.bAddy.city, ca.accNum.bID.bAddy.postcode
FROM employee e, customer_account ca
WHERE ca.custID.niNum = e.niNum AND e.supervisorID.position LIKE 'Manager';
--Roundig up the branch address that the employee works at, and that they are a
--customer of. 
--National Insurance number is used to check the identity of the employee is the
--same as the customer. 
--They also must be supervised by a manager, which is what the "LIKE 'Manager'" 
--part is for.



--e)
--SELECT ca.custID.bID.bID, ca.accNum.pName.title, ca.accNum.pName.firstname, ca.accNum.pName.surname, MAX(ca.custID.limitOfFreeOD)
--WHERE 


--f) --incomplete
--Find customers with more than one mobile, with at least one of the numbers beginning with '0770'
--Display the customer's full name and mobile numbers
SELECT c.pName.title, c.pName.firstname, c.pName.surname, p.*
FROM customer c, table(c.pContact.mobileNumbers) p
WHERE (SELECT COUNT (*) FROM table(c.pContact.mobileNumbers) p) > 1 AND SUBSTR(p.COLUMN_VALUE, 1,4) = '0770';
--Collecting the full names and mobile phone numbers of customers
--ensuring that they have more than 1 mobile phone, and that at least one
--of the phone numbers starts with the first four digits '0770'

--This query is incomplete as it only displays one mobile number


--incomplete