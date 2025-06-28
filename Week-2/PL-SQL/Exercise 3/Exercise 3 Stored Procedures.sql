CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    AccountType VARCHAR2(20),
    Balance NUMBER
);


INSERT INTO Accounts VALUES (1001, 'SAVINGS', 10000);
INSERT INTO Accounts VALUES (1002, 'SAVINGS', 20000);
INSERT INTO Accounts VALUES (1003, 'CURRENT', 30000);

COMMIT;

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(100),
    DepartmentID NUMBER,
    Salary NUMBER
);


INSERT INTO Employees VALUES (1, 'Alice', 101, 50000);
INSERT INTO Employees VALUES (2, 'Bob', 101, 55000);
INSERT INTO Employees VALUES (3, 'Charlie', 102, 60000);

COMMIT;





--scenario 1
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
  FOR acc IN (SELECT AccountID FROM Accounts WHERE UPPER(AccountType) = 'SAVINGS') LOOP
    UPDATE Accounts
    SET Balance = Balance * 1.01
    WHERE AccountID = acc.AccountID;
  END LOOP;
  COMMIT;
END;
/

BEGIN
  ProcessMonthlyInterest;
END;
/

--scenario 2

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
  p_DepartmentID IN NUMBER,
  p_BonusPercent IN NUMBER
) AS
BEGIN
  UPDATE Employees
  SET Salary = Salary + (Salary * p_BonusPercent / 100)
  WHERE DepartmentID = p_DepartmentID;
  
  COMMIT;
END;
/

EXEC UpdateEmployeeBonus(101, 10)


--scenario 3

CREATE OR REPLACE PROCEDURE TransferFunds(
  p_FromAccountID IN NUMBER,
  p_ToAccountID IN NUMBER,
  p_Amount IN NUMBER
) AS
  v_FromBalance NUMBER;
BEGIN
  
  SELECT Balance INTO v_FromBalance
  FROM Accounts
  WHERE AccountID = p_FromAccountID;

  IF v_FromBalance < p_Amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'No balance');
  END IF;


  UPDATE Accounts
  SET Balance = Balance - p_Amount
  WHERE AccountID = p_FromAccountID;

  UPDATE Accounts
  SET Balance = Balance + p_Amount
  WHERE AccountID = p_ToAccountID;

  COMMIT;
END;
/

EXEC TransferFunds(1001, 1002, 500);


select * from Accounts;
select * from EMPLOYEES;
