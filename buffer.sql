select * from pg_catalog.pg_available_extensions;

create extension postgres_fdw;

drop server if exists demo_pg cascade;

create server demo_pg foreign data wrapper postgres_fdw options (
    host 'localhost',
    dbname 'demo',
    port '5432'
);

create user mapping for postgres server demo_pg options (
    user 'postgres',
    password 'mysecretpassword'
);

drop schema if exists demo_src;
create schema demo_src AUTHORIZATION postgres;

import foreign schema bookings from server demo_pg into demo_src;