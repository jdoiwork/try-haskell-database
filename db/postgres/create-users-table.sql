create table if not exists users (
    id serial primary key,
    name varchar(100) not null,
    email varchar(300) not null
);
