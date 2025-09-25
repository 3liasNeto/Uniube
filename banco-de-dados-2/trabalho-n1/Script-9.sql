CREATE TABLE Product (
id int not null identity primary key,
name varchar(255) not null,
description varchar(500),
value decimal(10,2) not null,
categoryId int,
foreign key (categoryId) references ProductCategory(id)
)


CREATE TABLE Sales (
id int not null identity primary key,
productId int not null,
userId int not null,
quantity int,
payWay varchar(64),
buyDate datetime not null default GETDate(),
foreign key (productId) references product(id),
foreign key (userId) references users(id)
)


CREATE TABLE Stock (
id int not null identity primary key,
productId int not null,
quantity int not null,
lastUpdate date not null default GETDATE(),
foreign key (productId) references product(id)
)

CREATE TABLE ProductCategory(
id int not null primary key,
name varchar(255) not null,
description varchar(500),
)


CREATE TABLE Users (
id int not null primary key,
name varchar(255) not null,
lastName varchar(255) not null,
email varchar(300) unique,
address varchar(500) null,
zipCode varchar(30) null,
city varchar(266) null,
country varchar(300) null,
createdIn date not null default GETDATE()
)

CREATE TABLE Clients (
userId int primary key,
nickname varchar(255),
foreign key (userId) references users(id)
)

CREATE TABLE Employees (
userId int primary key,
role varchar(255),
salary decimal(10,2) not null,
foreign key (userId) references users(id)
)



CREATE TABLE Tracking (
id int primary key identity,
saleId int not null,
status varchar(30) not null,
deliveryDate date,
shippingDate date,
    delivered bit,
foreign key (saleId) references sales(id)
)


