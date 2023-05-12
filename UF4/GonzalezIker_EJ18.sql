CREATE TYPE engineer_type AS OBJECT (
    name VARCHAR2(50),
    phone_number VARCHAR2(20)
);

CREATE TYPE engineer_list_type AS VARRAY(2) OF engineer_type;

CREATE TYPE plan_type AS OBJECT (
    title VARCHAR2(100),
    signatories engineer_list_type
);

CREATE TYPE plan_list_type AS VARRAY(10) OF plan_type;

CREATE TYPE project_type AS OBJECT (
    name VARCHAR2(100),
    completion_date DATE,
    manager REF project_manager_type,
    plans plan_list_type
);

CREATE TYPE project_list_type AS VARRAY(100) OF project_type;

CREATE TYPE project_manager_type AS OBJECT (
    name VARCHAR2(50),
    phone_number VARCHAR2(20),
    projects project_list_type
);

CREATE TABLE project_manager_table OF project_manager_type;

CREATE TABLE project_table OF project_type;

ALTER TABLE project_table ADD CONSTRAINT project_manager_fk FOREIGN KEY (manager) REFERENCES project_manager_table;

INSERT INTO project_manager_table VALUES (
    project_manager_type('John Doe', '555-1234', project_list_type())
);

INSERT INTO project_manager_table VALUES (
    project_manager_type('Jane Smith', '555-5678', project_list_type())
);

INSERT INTO project_table VALUES (
    project_type(
        'PROJECT CONDITIONING ROAD CV-70 STREET PK 0+000 TO PK1+500',
        TO_DATE('2023-12-31', 'YYYY-MM-DD'),
        (SELECT REF(p) FROM project_manager_table p WHERE p.name = 'John Doe'),
        plan_list_type(
            plan_type('LOCATION AND SITE', engineer_list_type(engineer_type('Engineer A', '555-1111'), engineer_type('Engineer B', '555-2222'))),
            plan_type('AFFECTED SERVICES', engineer_list_type(engineer_type('Engineer C', '555-3333'), engineer_type('Engineer D', '555-4444'))),
            plan_type('SAFETY AND HEALTH', engineer_list_type(engineer_type('Engineer E', '555-5555'), engineer_type('Engineer F', '555-6666')))
        )
    )
);

UPDATE project_table
SET plans[2] = plan_type('AFFECTED SERVICES', engineer_list_type(engineer_type('Engineer C', '555-3333')))
WHERE project_type.name = 'PROJECT CONDITIONING ROAD CV-70 STREET PK 0+000 TO PK1+500';
