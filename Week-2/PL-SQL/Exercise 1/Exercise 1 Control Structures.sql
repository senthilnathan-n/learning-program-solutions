-- Drop tables if they already exist (optional, for clean runs)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Transactions';
    EXECUTE IMMEDIATE 'DROP TABLE Accounts';
    EXECUTE IMMEDIATE 'DROP TABLE Loans';
    EXECUTE IMMEDIATE 'DROP TABLE Employees';
    EXECUTE IMMEDIATE 'DROP TABLE Customers';
EXCEPTION
    WHEN OTHERS THEN NULL; -- Ignore errors if tables don't exist
END;
/

-- Table Creation
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

-- Scenario 1: Customers above 60 years with loans
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (3, 'Elder One', TO_DATE('1950-01-01', 'YYYY-MM-DD'), 3000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (4, 'Senior Two', TO_DATE('1948-10-10', 'YYYY-MM-DD'), 2500, SYSDATE);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 3, 7000, 6, SYSDATE, ADD_MONTHS(SYSDATE, 48));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 4, 8000, 5.5, SYSDATE, ADD_MONTHS(SYSDATE, 36));

-- Scenario 2: VIP Customer with balance > 10000
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (5, 'Richie Rich', TO_DATE('1988-11-11', 'YYYY-MM-DD'), 20000, SYSDATE);

-- Also add an account to match existing structure
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 5, 'Savings', 20000, SYSDATE);

-- Scenario 3: Loan due within 30 days
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (6, 'Soon Due', TO_DATE('1975-08-25', 'YYYY-MM-DD'), 6000, SYSDATE);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (4, 6, 3000, 4.5, SYSDATE - 330, SYSDATE + 15);  -- Ends within next 30 days


-- Add IsVIP column
ALTER TABLE Customers ADD (IsVIP CHAR(1));

-- Scenario 1: Apply 1% interest discount for customers above 60 years
BEGIN
    FOR cust IN (SELECT CustomerID, DOB FROM Customers) LOOP
        IF MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12 > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Scenario 2: Set IsVIP = 'Y' for customers with balance > 10000
BEGIN
    FOR cust IN (SELECT CustomerID, Balance FROM Customers) LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Scenario 3: Print loan due reminders within next 30 days
SET SERVEROUTPUT ON
BEGIN
    FOR loan IN (
        SELECT LoanID, CustomerID, EndDate
        FROM Loans
        WHERE EndDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP
        DECLARE
            v_name VARCHAR2(100);
        BEGIN
            SELECT Name INTO v_name FROM Customers WHERE CustomerID = loan.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || v_name || ', your loan (ID: ' || loan.LoanID || ') is due on ' || TO_CHAR(loan.EndDate, 'YYYY-MM-DD'));
        END;
    END LOOP;
END;
/

select * from Accounts;
select * from CUSTOMERS;
select * from Loans;