
INSERT INTO Customers VALUES (1, 'Senior One', 65, 12000, 'FALSE');
INSERT INTO Customers VALUES (2, 'Senior Two', 70, 8000, 'FALSE');
INSERT INTO Customers VALUES (3, 'Senior Three', 75, 9500, 'FALSE');


INSERT INTO Loans VALUES (101, 1, 10.5, SYSDATE + 15);  
INSERT INTO Loans VALUES (102, 2, 11.0, SYSDATE + 20);  
INSERT INTO Loans VALUES (103, 3, 9.5,  SYSDATE + 5); 

--scenario 1
BEGIN
  FOR i IN (SELECT CustomerID FROM Customers WHERE Age > 60) LOOP
    UPDATE Loans
    SET InterestRate = InterestRate - 1
    WHERE CustomerID = i.CustomerID;
  END LOOP;
  COMMIT;
END;

--scenario 2

BEGIN
  FOR i IN (SELECT CustomerID FROM Customers WHERE Balance > 10000) LOOP
    UPDATE Customers
    SET IsVIP = 'TRUE'
    WHERE CustomerID = i.CustomerID;
  END LOOP;
  COMMIT;
END;
/
--scenario 3

BEGIN
  FOR loan_rec IN (
    SELECT l.LoanID, l.DueDate, c.CustomerName
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || loan_rec.CustomerName ||
                         ', your loan (ID: ' || loan_rec.LoanID ||
                         ') is due on ' || TO_CHAR(loan_rec.DueDate, 'DD-MON-YYYY'));
  END LOOP;
END;
/



select * from CUSTOMERS;
select * from Loans;
/