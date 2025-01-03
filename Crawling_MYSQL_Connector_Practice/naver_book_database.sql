use bookdb;

drop table naver_book;

create table naver_book
(
	book_code int auto_increment primary key,
	book_title varchar(300),
    book_image varchar(300),
    author varchar(100),
    publisher varchar(100),
    isbn varchar(100),
    book_description varchar(3000),
    pub_date datetime
) engine=innodb;

SELECT *
  FROM naver_book;