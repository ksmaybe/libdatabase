drop table if exists books cascade ;
drop table if exists authors cascade ;
drop table if exists written_by cascade;
drop table if exists patrons cascade;
drop table if exists book_check cascade;
drop table if exists movies cascade;
drop table if exists actors cascade;
drop table if exists starred_by cascade;
drop table if exists movie_check cascade;
drop table if exists albums cascade;
drop table if exists tracks cascade;
drop table if exists artists cascade;
drop table if exists created_by cascade;
drop table if exists album_check cascade;

create table books (
    isbn        varchar(13) primary key,
    name        varchar(64),
    year        integer,
    genre       varchar(16),
    publisher   varchar(64),
    stock    integer
);

create table authors (
    id      integer primary key,
    name    varchar(32),
    country varchar(32)
);

create table written_by (
    isbn    varchar(13),
    author  integer,
    primary key(isbn,author),
    foreign key(isbn) references books(isbn),
    foreign key(author) references authors(id)
);

create table patrons (
    id          integer primary key,
    name        varchar(32),
    address     varchar(64),
    email       varchar(64),
    phone       char(12)
);

create table book_check (
    id      integer,
    isbn    varchar(13),
    date    date,
    number  integer,
    primary key (id,isbn,date),
    foreign key(id) references patrons(id),
    foreign key(isbn) references books(isbn)
);

create table movies (
    id          integer primary key,
    name        varchar(64),
    year        integer,
    genre       varchar(16),
    director    varchar(32),
    stock    integer
);

create table actors (
    id      integer primary key,
    name    varchar(32),
    country varchar(32)
);

create table starred_by (
    mid     integer,
    aid     integer,
    primary key(mid,aid),
    foreign key(mid) references movies(id),
    foreign key(aid) references actors(id)
);

create table movie_check (
    pid     integer,
    mid     integer,
    date    date,
    number  integer,
    primary key (pid,mid,date),
    foreign key(pid) references patrons(id),
    foreign key(mid) references movies(id)
);

create table albums (
    id          integer primary key,
    name        varchar(64),
    year        integer,
    genre       varchar(16),
    stock    integer
);

create table album_tracks (
    id      integer,
    name    varchar(64),
    primary key(id,name),
    foreign key (id) references albums(id) on delete cascade
);

create table artists (
    id      integer primary key,
    name    varchar(32),
    country varchar(32)
);

create table created_by (
    artist    integer,
    album     integer,
    primary key(album,artist),
    foreign key(artist) references artists(id),
    foreign key(album) references albums(id)
);

create table album_check (
    pid     integer,
    aid     integer,
    date    date,
    number  integer,
    primary key (pid,aid,date),
    foreign key(pid) references patrons(id),
    foreign key(aid) references albums(id)
);

