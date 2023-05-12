CREATE OR REPLACE TYPE address_type AS OBJECT (
  type VARCHAR2(20),
  number VARCHAR2(10),
  street VARCHAR2(50),
  floor VARCHAR2(10)
);

CREATE OR REPLACE TYPE address_collection AS VARRAY(3) OF address_type;

CREATE OR REPLACE TYPE company_type AS OBJECT (
  cif VARCHAR2(20),
  name VARCHAR2(50),
  addresses address_collection
);

CREATE OR REPLACE TYPE corporation_type UNDER company_type (
  num_shareholders NUMBER,
  share_capital NUMBER,
  budget NUMBER
);

CREATE OR REPLACE TYPE partner_type AS OBJECT (
  name VARCHAR2(50),
  percentage NUMBER
);

CREATE OR REPLACE TYPE partner_list AS VARRAY(10) OF partner_type;

CREATE OR REPLACE TYPE limited_company_type UNDER company_type (
  partners partner_list
);

CREATE TABLE employee (
  id NUMBER,
  name VARCHAR2(50),
  company REF company_type
);

CREATE TABLE corporation (
  cif VARCHAR2(20) PRIMARY KEY,
  name VARCHAR2(50),
  addresses address_collection,
  num_shareholders NUMBER,
  share_capital NUMBER,
  budget NUMBER
);

INSERT INTO corporation VALUES (
  '12345678A',
  'Example Corp',
  address_collection(
    address_type('fiscal', '123', 'Main St', '4th floor'),
    address_type('postal', '456', 'Second St', '2nd floor')
  ),
  10,
  1000000,
  500000
);

CREATE TABLE limited_company (
  cif VARCHAR2(20) PRIMARY KEY,
  name VARCHAR2(50),
  addresses address_collection,
  partners partner_list
);

CREATE TABLE limited_company (
  cif VARCHAR2(20) PRIMARY KEY,
  name VARCHAR2(50),
  addresses address_collection,
  partners partner_list
);

INSERT INTO limited_company VALUES (
  '87654321B',
  'Example Ltd',
  address_collection(
    address_type('fiscal', '789', 'Third St', '1st floor'),
    address_type('administrative', '1011', 'Fourth St', '3rd floor')
  ),
  partner_list(
    partner_type('Partner A', 50),
    partner_type('Partner B', 25),
    partner_type('Partner C', 15),
    partner_type('Partner D', 10)
  )
);

INSERT INTO employee VALUES (
  1,
  'John Doe',
  (SELECT REF(c) FROM corporation c WHERE c.name = 'Example Corp')
);

INSERT INTO employee VALUES (
  2,
  'Jane Smith',
  (SELECT REF(l) FROM limited_company l WHERE l.name = 'Example Ltd')
);

SELECT e.name AS employee_name, c.name AS company_name
FROM employee e
JOIN company_type c ON e.company = REF(c);
