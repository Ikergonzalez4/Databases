CREATE TYPE phone_number_type AS OBJECT (
    country_code VARCHAR2(2),
    region_code VARCHAR2(3),
    number VARCHAR2(7)
);

CREATE TYPE phone_number_list_type AS VARRAY(5) OF phone_number_type;

CREATE TABLE phonebook (
    person_name VARCHAR2(50),
    phone_numbers phone_number_list_type
);

INSERT INTO phonebook (person_name, phone_numbers) VALUES (
    'John Smith',
    phone_number_list_type(
        phone_number_type('00', '124', '3566987'),
        phone_number_type('01', '234', '5678901')
    )
);

INSERT INTO phonebook (person_name, phone_numbers) VALUES (
    'Jane Doe',
    phone_number_list_type(
        phone_number_type('02', '345', '6789012'),
        phone_number_type('03', '456', '7890123')
    )
);

UPDATE phonebook
SET phone_numbers[1] = phone_number_type('00', '124', '1234567')
WHERE person_name = 'John Smith';


SELECT phone_numbers.country_code || '-' || phone_numbers.region_code || '-' || phone_numbers.number AS phone_number
FROM phonebook, TABLE(phonebook.phone_numbers) phone_numbers
WHERE person_name = 'John Smith';
