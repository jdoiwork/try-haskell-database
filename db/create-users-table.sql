create table if not exists users (
    id integer primary key AUTOINCREMENT not NULL ,
    name text not null,
    email text not null
);
