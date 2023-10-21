create table `order`
(
    id           int auto_increment
        primary key,
    title        varchar(255)               not null,
    date_created date default curdate() not null
);

insert into `order` (`title`) values ('Order - 1'), ('Order - 2'), ('Order - 3')