-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.attributes
(
    id
    bigserial
    NOT
    NULL,
    type
    character
    varying
    COLLATE
    pg_catalog
    .
    "default"
    NOT
    NULL,
    CONSTRAINT
    attribute_pkey
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.clients
(
    id
    bigserial
    NOT
    NULL,
    first_name
    character
    varying
    COLLATE
    pg_catalog
    .
    "default"
    NOT
    NULL,
    last_name
    character
    varying
    COLLATE
    pg_catalog
    .
    "default"
    NOT
    NULL,
    login
    character
    varying
    NOT
    NULL,
    password
    character
    varying
    NOT
    NULL,
    phone
    bigint
    NOT
    NULL,
    is_deleted
    boolean
    NOT
    NULL,
    balance
    money
    NOT
    NULL,
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.deals
(
    id
    bigserial
    NOT
    NULL,
    cost
    money
    NOT
    NULL,
    start_date
    date
    NOT
    NULL,
    end_date
    date
    NOT
    NULL,
    object_id
    bigint
    NOT
    NULL,
    type_id
    bigint
    NOT
    NULL,
    buyer_client_id
    bigint
    NOT
    NULL,
    status_id
    bigint
    NOT
    NULL,
    employee_id
    bigint,
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.employees
(
    id
    bigserial
    NOT
    NULL,
    first_name
    character
    varying
    COLLATE
    pg_catalog
    .
    "default"
    NOT
    NULL,
    last_name
    character
    varying
    COLLATE
    pg_catalog
    .
    "default"
    NOT
    NULL,
    phone
    bigint,
    earning
    money
    NOT
    NULL,
    is_deleted
    boolean
    NOT
    NULL,
    position_id
    bigint
    NOT
    NULL,
    CONSTRAINT
    employee_pkey
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.estate
(
    id
    bigserial
    NOT
    NULL,
    "number"
    integer
    NOT
    NULL,
    square
    numeric
    NOT
    NULL,
    price
    money
    NOT
    NULL,
    end_date
    date
    NOT
    NULL,
    visible
    boolean
    NOT
    NULL,
    rank
    integer
    NOT
    NULL
    DEFAULT
    1,
    is_moderated
    boolean
    NOT
    NULL,
    owner_client_id
    bigint
    NOT
    NULL,
    address_id
    bigint
    NOT
    NULL,
    CONSTRAINT
    object_pk
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.type_deal
(
    id
    bigserial
    NOT
    NULL,
    type
    character
    varying
    COLLATE
    pg_catalog
    .
    "default"
    NOT
    NULL,
    CONSTRAINT
    type_deal_pkey
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.atribute_value
(
    id
    bigserial
    NOT
    NULL,
    value
    character
    varying
    NOT
    NULL,
    CONSTRAINT
    atribute_value_pkey
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.estate_attribute_value
(
    attribute_id
    bigint
    NOT
    NULL,
    estate_id
    bigint
    NOT
    NULL,
    value_id
    bigint
    NOT
    NULL,
    CONSTRAINT
    estate_attribute_value_pkey
    PRIMARY
    KEY
(
    estate_id,
    attribute_id,
    value_id
)
    );

CREATE TABLE IF NOT EXISTS public.status_deal
(
    id
    bigserial
    NOT
    NULL,
    status
    character
    varying
    NOT
    NULL,
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.c_addresses
(
    id
    bigserial
    NOT
    NULL,
    city
    character
    varying
    NOT
    NULL,
    street
    character
    varying
    NOT
    NULL,
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.client_role
(
    client_id
    bigint
    NOT
    NULL,
    role
    character
    varying
    NOT
    NULL
);

CREATE TABLE IF NOT EXISTS public.employee_role
(
    employee_id
    bigint
    NOT
    NULL,
    role
    character
    varying
    NOT
    NULL
);

CREATE TABLE IF NOT EXISTS public.wishlist
(
    estate_id
    bigserial
    NOT
    NULL,
    clients_id
    bigserial
    NOT
    NULL
);

CREATE TABLE IF NOT EXISTS public.c_positions
(
    id
    bigserial
    NOT
    NULL,
    "position"
    character
    varying
    NOT
    NULL,
    PRIMARY
    KEY
(
    id
)
    );

CREATE TABLE IF NOT EXISTS public.revenues
(
    id
    bigserial
    NOT
    NULL,
    date
    date
    NOT
    NULL,
    sum
    money
    NOT
    NULL,
    client_id
    bigint
    NOT
    NULL,
    PRIMARY
    KEY
(
    id
)
    );

ALTER TABLE IF EXISTS public.deals
    ADD CONSTRAINT deal_buyer_client_fk FOREIGN KEY (buyer_client_id)
    REFERENCES public.clients (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.deals
    ADD CONSTRAINT deal_employee_fk FOREIGN KEY (employee_id)
    REFERENCES public.employees (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.deals
    ADD CONSTRAINT deal_object_fk FOREIGN KEY (object_id)
    REFERENCES public.estate (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.deals
    ADD CONSTRAINT deal_type_fk FOREIGN KEY (type_id)
    REFERENCES public.type_deal (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.deals
    ADD CONSTRAINT deal_status_fk FOREIGN KEY (status_id)
    REFERENCES public.status_deal (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.employees
    ADD CONSTRAINT employee_position_fk FOREIGN KEY (position_id)
    REFERENCES public.c_positions (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.estate
    ADD CONSTRAINT address_fk FOREIGN KEY (address_id)
    REFERENCES public.c_addresses (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.estate
    ADD CONSTRAINT owner_client_estate_fk FOREIGN KEY (owner_client_id)
    REFERENCES public.clients (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.estate_attribute_value
    ADD CONSTRAINT estate_attribute_value_on_estate_fk FOREIGN KEY (estate_id)
    REFERENCES public.estate (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.estate_attribute_value
    ADD CONSTRAINT estate_attribute_value_on_attribute_fk FOREIGN KEY (attribute_id)
    REFERENCES public.attributes (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.estate_attribute_value
    ADD CONSTRAINT estate_attribute_value_on_value_fk FOREIGN KEY (value_id)
    REFERENCES public.atribute_value (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.client_role
    ADD CONSTRAINT client_role_fk FOREIGN KEY (client_id)
    REFERENCES public.clients (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.employee_role
    ADD CONSTRAINT employee_role_fk FOREIGN KEY (employee_id)
    REFERENCES public.employees (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.wishlist
    ADD FOREIGN KEY (clients_id)
    REFERENCES public.clients (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.wishlist
    ADD FOREIGN KEY (estate_id)
    REFERENCES public.estate (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.revenues
    ADD CONSTRAINT client_revenue_fk FOREIGN KEY (client_id)
    REFERENCES public.clients (id) MATCH SIMPLE
    ON
UPDATE NO ACTION
ON
DELETE
NO ACTION
    NOT VALID;

END;