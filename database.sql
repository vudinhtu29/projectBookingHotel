create database DemoHotel
use DemoHotel
CREATE TABLE "Type_customer"(
    "type_customer" INT IDENTITY(1,1) NOT NULL,
    "type_customer_name" NVARCHAR(255) NOT NULL,
    "money_level" FLOAT NOT NULL, 
    "discount" FLOAT NOT NULL,
    CONSTRAINT "type_customer_type_customer_primary" PRIMARY KEY("type_customer")
);

CREATE TABLE "Customer"(
    "customer_id" INT IDENTITY(1,1) NOT NULL,
    "type_customer" INT NOT NULL,
    "first_name" NVARCHAR(255),
    "last_name" NVARCHAR(255),
    "email" NVARCHAR(255) Unique NOT NULL,
    "password" NVARCHAR(255) NOT NULL,
    "phone" NVARCHAR(255),
    "address" NVARCHAR(255),
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "customer_customer_id_primary" PRIMARY KEY("customer_id"),
    CONSTRAINT "customer_type_customer_foreign" FOREIGN KEY("type_customer") REFERENCES "Type_customer"("type_customer")
);


CREATE TABLE "Role"(
    "staff_type_id" INT IDENTITY(1,1) NOT NULL,
    "type" NVARCHAR(255) NOT NULL,
    CONSTRAINT "role_staff_type_id_primary" PRIMARY KEY("staff_type_id")
);

CREATE TABLE "Staff"(
    "staff_id" INT IDENTITY(1,1) NOT NULL,
    "staff_type_id" INT NOT NULL,
    "email" NVARCHAR(255) NOT NULL,
    "password" NVARCHAR(255) NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "staff_staff_id_primary" PRIMARY KEY("staff_id"),
    CONSTRAINT "staff_staff_type_id_foreign" FOREIGN KEY("staff_type_id") REFERENCES "Role"("staff_type_id")
);

CREATE TABLE "Room_type"(
    "room_type_id" INT IDENTITY(1,1) NOT NULL,
    "type_name" NVARCHAR(255) NOT NULL,
    "status" NVARCHAR(255) NULL,
	"quantity" int not null,
	"roomtype_img"  NVARCHAR(255) NOT NULL,
	"title_descripsion" NVARCHAR(255) NOT NULL,
    "roomtype_descripsion" NVARCHAR(MAX) NOT NULL,
	"content_descripsion" NVARCHAR(MAX) NOT NULL,
	"room_type_price" FLOAT NOT NULL,
    CONSTRAINT "room_type_room_type_id_primary" PRIMARY KEY("room_type_id")
);

CREATE TABLE "Room"(
    "room_id" INT IDENTITY(1,1) NOT NULL,
    "room_type_id" INT NOT NULL,
    "room_name" NVARCHAR(255) NOT NULL,
	
    "room_status" NVARCHAR(255) NULL,
    CONSTRAINT "room_room_id_primary" PRIMARY KEY("room_id"),
    CONSTRAINT "room_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Room_Images"(
    "room_type_id" INT,
    "img" NVARCHAR(255),
    CONSTRAINT "room_images_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Service"(
    "service_id" INT IDENTITY(1,1) NOT NULL,
    "name_service" NVARCHAR(MAX) NOT NULL,
    "title_service" NVARCHAR(MAX) NULL,
    "description" NVARCHAR(MAX) NULL,
    "img" NVARCHAR(MAX) NULL,
    "status" NVARCHAR(MAX) NOT NULL,
	"service_price" FLOAT NOT NULL,
    CONSTRAINT "service_service_id_primary" PRIMARY KEY("service_id"),
);

CREATE TABLE "Event_id"(
    "event_id" INT IDENTITY(1,1) NOT NULL,
	"title_event" NVARCHAR(MAX) NULL,
	"img" NVARCHAR(MAX) NOT NULL,
    "start_date" DATETIME NOT NULL,
    "end_date" DATETIME NOT NULL,
    "detail" NVARCHAR(MAX) NOT NULL,
    "discount_percent" FLOAT NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "event_id_event_id_primary" PRIMARY KEY("event_id"),
);

CREATE TABLE "News"(
    "news_id" INT IDENTITY(1,1) NOT NULL,
    "staff_id" INT NOT NULL,
    "img" NVARCHAR(MAX) NOT NULL,
    "title" NVARCHAR(MAX) NOT NULL,
    "create_date" DATE NOT NULL,
    "desccription" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(MAX) NOT NULL,
    CONSTRAINT "news_news_id_primary" PRIMARY KEY("news_id"),
    CONSTRAINT "news_staff_id_foreign" FOREIGN KEY("staff_id") REFERENCES "Staff"("staff_id")
);

CREATE TABLE "Detail_news"(
    "detail_news_id" INT IDENTITY(1,1) NOT NULL,
    "news_id" INT NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    CONSTRAINT "detail_news_detail_news_id_primary" PRIMARY KEY("detail_news_id"),
    CONSTRAINT "detail_news_news_id_foreign" FOREIGN KEY("news_id") REFERENCES "News"("news_id")
);

CREATE TABLE "Reservation"(
    "reservation_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "discountpercent_level" FLOAT NOT NULL,
    "event_id" INT,
    "total_price" FLOAT NOT NULL,
	"quantity" int not null,
	"staff_id" INT,
    CONSTRAINT "reservation_reservation_id_primary" PRIMARY KEY("reservation_id"),
    CONSTRAINT "reservation_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id"),
    CONSTRAINT "reservation_event_id_foreign" FOREIGN KEY("event_id") REFERENCES "Event_id"("event_id"),
	CONSTRAINT "reservation_staff_id_foreign" FOREIGN KEY("staff_id") REFERENCES "Staff"("staff_id")
);

CREATE TABLE "Invoice_customer"(
    "invoice_customer_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "reservation_id" INT NOT NULL,
    "invoice_amount" FLOAT NOT NULL,
    "ts_paid" DATETIME NULL,
    CONSTRAINT "invoice_customer_invoice_customer_id_primary" PRIMARY KEY("invoice_customer_id"),
    CONSTRAINT "invoice_customer_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "invoice_customer_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Level_customer"(
    "level_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "reservation_id" INT NOT NULL,
    "total" FLOAT NOT NULL,
    CONSTRAINT "level_customer_level_id_primary" PRIMARY KEY("level_id"),
    CONSTRAINT "level_customer_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "level_customer_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Comment"(
    "comment_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "detai_new_id" INT NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    "comment_date" DATE NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "comment_comment_id_primary" PRIMARY KEY("comment_id"),
    CONSTRAINT "comment_detai_new_id_foreign" FOREIGN KEY("detai_new_id") REFERENCES "Detail_news"("detail_news_id"),
    CONSTRAINT "comment_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Reply"(
    "reply_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "comment_id" INT NOT NULL,
    "content" NVARCHAR(MAX) NOT NULL,
    "reply_date" DATE NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "reply_reply_id_primary" PRIMARY KEY("reply_id"),
    CONSTRAINT "reply_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id"),
    CONSTRAINT "reply_comment_id_foreign" FOREIGN KEY("comment_id") REFERENCES "Comment"("comment_id")
);

CREATE TABLE "Room_reserved"(
    "reservation_id" INT NOT NULL,
    "room_id" INT NOT NULL,
    "price" FLOAT NOT NULL,
    CONSTRAINT "room_reserved_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "room_reserved_room_id_foreign" FOREIGN KEY("room_id") REFERENCES "Room"("room_id")
);

CREATE TABLE "Room_service"(
    "service_id" INT NOT NULL,
    "room_type_id" INT NOT NULL,
    CONSTRAINT "room_service_service_id_foreign" FOREIGN KEY("service_id") REFERENCES "Service"("service_id"),
    CONSTRAINT "room_service_room_type_id_foreign" FOREIGN KEY("room_type_id") REFERENCES "Room_type"("room_type_id")
);

CREATE TABLE "Review"(
    "review_id" INT IDENTITY(1,1) NOT NULL,
    "customer_id" INT NOT NULL,
    "staff_id" INT NOT NULL,
	"room_id" INT NOT NULL,
    "description" NVARCHAR(MAX) NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    CONSTRAINT "review_review_id_primary" PRIMARY KEY("review_id"),
    CONSTRAINT "review_customer_id_foreign" FOREIGN KEY("customer_id") REFERENCES "Customer"("customer_id"),
    CONSTRAINT "review_staff_id_foreign" FOREIGN KEY("staff_id") REFERENCES "Staff"("staff_id"),
	CONSTRAINT "review_room_id_foreign" FOREIGN KEY("room_id") REFERENCES "Room"("room_id")
);

CREATE TABLE "Convenient" (
	"convenient_id" INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	"convenient_name" NVARCHAR(255) NOT NULL,
	"status" NVARCHAR(255) NOT NULL	
);

CREATE TABLE "Room_Convenient" (
    "room_id" INT NOT NULL,
    "convenient_id" INT NOT NULL,
    "status" NVARCHAR(255) NOT NULL,
    PRIMARY KEY ("room_id", "convenient_id"),
    CONSTRAINT "room_convenient_room_id_foreign" FOREIGN KEY ("room_id") REFERENCES "Room"("room_id"),
    CONSTRAINT "room_convenient_convenient_id_foreign" FOREIGN KEY ("convenient_id") REFERENCES "Convenient"("convenient_id")
);
CREATE TABLE "Service_reserved"(
	"reservation_id" INT NOT NULL,
    "service_id" INT NOT NULL,
    CONSTRAINT "service_reserved_reservation_id_foreign" FOREIGN KEY("reservation_id") REFERENCES "Reservation"("reservation_id"),
    CONSTRAINT "service_reserved_service_id_foreign" FOREIGN KEY("service_id") REFERENCES "Service"("service_id")
);
--------------------------------------------------------------------
INSERT INTO "Role" ( "type")
VALUES
( N'Admin'),
( N'Staff')








INSERT INTO "Customer"("type_customer", "first_name", "last_name", "email", "password", "phone", "address", "status") 
VALUES
(1, 'John', 'Doe', 'mahihoang0@gmail.com', '123456', '123456789', '123 Main St, City', 'Active'),
(1, 'John', 'Doe', 'mikizay175d@gmail.com', '123456', '123456789', '123 Main St, City', 'Active')

INSERT INTO "Type_customer" ("type_customer_name", "money_level",  "discount")
VALUES
('VIP', 2, 0.5)
select * from role
select * from staff
select * from "Customer"
select * from "Type_customer"

INSERT INTO "Staff" ( "staff_type_id", "email", "password", "status")
VALUES
( 1, 'admin', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', 'active'),
( 2, 'dinhtu@gmail.com', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', 'active')


select * from Event_id where status = 'inactive'
select * from Service where status = 'active'

INSERT INTO Event_id ("start_date", "end_date", "detail", "discount_percent", "description", "status") 
VALUES ('2024-04-30', '2024-05-01', N'Chao mung 50 Giai Phong Mien Nam', 20, N'Giam tat ca cac phong', 'active');
INSERT INTO "Service"(name_service,title_service,description,img,status)
VALUES('Phong GYM','FREE','Cho cac phong luxury','https://www.google.com/url?sa=i&url=https%3A%2F%2Fm8group.co.uk%2Fblog%2Fdesign-for-maximum-guest-fitness%2F&psig=AOvVaw0_JkZu9Rz1NdZZKtLaqELU&ust=1717927343103000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCIiI-5ngy4YDFQAAAAAdAAAAABAI','active')
c
UPDATE Service Set status = 'inactive' WHERE service_id = 3

select * from Service where service_id =?
select * from Customer

INSERT [Type_customer] ([type_customer_name], [money level], [discount]) VALUES (N'new', 0, 0)
INSERT [Type_customer] ([type_customer_name], [money level], [discount]) VALUES (N'vip', 500000, 1)
INSERT [Type_customer] ([type_customer_name], [money level], [discount]) VALUES (N'svip', 1000000, 1.5)

INSERT INTO "Customer"("type_customer", "first_name", "last_name", "email", "password", "phone", "address", "status") 
VALUES
(1, 'John', 'Doe', 'vinhtien@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '123456789', '123 Main St, City', 'Active'),
(1, 'John', 'Doe', 'vudinhtu2904@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '123456789', '123 Main St, City', 'Active')

select * from Room_type
select * from Service

 
 select * from Room_service where room_type_id = 1
insert into Room_type("type_name", "status","quantity")
values
(N'Phòng Tổng Thống', 'active',10),
(N'Phòng Thượng Hạng', 'active',10)

insert into Room_service(room_type_id,service_id) values (1,1)
insert into Room_service(room_type_id,service_id) values (1,3)
insert into Room_service(room_type_id,service_id) values (1,2)

delete from Service where status = 'active'
select * from Room_service
delete from Room_service where service_id = 1
ALTER TABLE Review DROP CONSTRAINT review_staff_id_foreign;
ALTER TABLE Review DROP COLUMN staff_id;

INSERT INTO "Room_type" (
    "type_name",
    "status",
    "quantity",
    "roomtype_img",
    "descripsion",
    "room_type_price"
) VALUES (
    N'Loại Deluxe', -- type_name
    N'Kích hoạt', -- status
    10, -- quantity
    N'deluxe.jpg', -- roomtype_img
    N'Mô tả chi tiết về loại phòng Deluxe', -- descripsion
    150.0 -- room_type_price
);


INSERT INTO "Room" (
    "room_type_id",
    "room_name",
    "title_descripsion",
    "room_descripsion",
    "content_descripsion",
    "current_price",
    "room_status"
) VALUES (
    1, -- room_type_id (giả sử ID của loại Deluxe là 1)
    N'Phòng 101', -- room_name
    N'Tiêu đề phòng 101', -- title_descripsion
    N'Mô tả ngắn về phòng 101', -- room_descripsion
    N'Mô tả chi tiết về phòng 101', -- content_descripsion
    160.0, -- current_price
    N'Kích hoạt' -- room_status
);


UPDATE "Room"
SET "room_status" = N'active'
WHERE "room_name" = N'Phòng 101';


------------------------------------------------------------------------------------------------------------
INSERT INTO "Room_type" ("type_name", "status", "quantity", "roomtype_img", "descripsion", "room_type_price") VALUES
('Single', 'Available', 10, 'single.jpg', 'Single room description', 100.00),
('Double', 'Available', 20, 'double.jpg', 'Double room description', 150.00),
('Suite', 'Unavailable', 5, 'suite.jpg', 'Suite room description', 300.00),
('Deluxe', 'Available', 8, 'deluxe.jpg', 'Deluxe room description', 250.00),
('Family', 'Available', 15, 'family.jpg', 'Family room description', 200.00),
('Executive', 'Unavailable', 4, 'executive.jpg', 'Executive room description', 400.00),
('Presidential', 'Available', 2, 'presidential.jpg', 'Presidential room description', 500.00),
('Budget', 'Available', 25, 'budget.jpg', 'Budget room description', 80.00),
('Standard', 'Available', 30, 'standard.jpg', 'Standard room description', 120.00),
('Penthouse', 'Unavailable', 1, 'penthouse.jpg', 'Penthouse room description', 1000.00);
-- Insert data into Room
INSERT INTO "Room" ("room_type_id", "room_name", "title_descripsion", "room_descripsion", "content_descripsion", "current_price", "room_status") VALUES
(1, '101', 'Room 101', 'Description of Room 101', 'Content for Room 101', 100.00, 'Available'),
(2, '102', 'Room 102', 'Description of Room 102', 'Content for Room 102', 150.00, 'Occupied'),
(3, '103', 'Room 103', 'Description of Room 103', 'Content for Room 103', 300.00, 'Available'),
(4, '104', 'Room 104', 'Description of Room 104', 'Content for Room 104', 250.00, 'Available'),
(5, '105', 'Room 105', 'Description of Room 105', 'Content for Room 105', 200.00, 'Occupied'),
(6, '106', 'Room 106', 'Description of Room 106', 'Content for Room 106', 400.00, 'Available'),
(7, '107', 'Room 107', 'Description of Room 107', 'Content for Room 107', 500.00, 'Available'),
(8, '108', 'Room 108', 'Description of Room 108', 'Content for Room 108', 80.00, 'Available'),
(9, '109', 'Room 109', 'Description of Room 109', 'Content for Room 109', 120.00, 'Occupied'),
(10, '110', 'Room 110', 'Description of Room 110', 'Content for Room 110', 1000.00, 'Available');

INSERT INTO "Service" ("name_service", "title_service", "description", "img", "status", "service_price") VALUES
('Room Cleaning', 'Daily Cleaning', 'Daily room cleaning service', 'cleaning.jpg', 'Active', 20.00),
('Breakfast', 'Morning Breakfast', 'Complimentary breakfast service', 'breakfast.jpg', 'Active', 10.00),
('Spa', 'Relaxation Spa', 'Full body spa service', 'spa.jpg', 'Inactive', 50.00),
('Gym', 'Gym Access', 'Access to hotel gym facilities', 'gym.jpg', 'Active', 15.00),
('Laundry', 'Laundry Service', 'Laundry and dry cleaning', 'laundry.jpg', 'Active', 25.00),
('Parking', 'Valet Parking', 'Valet parking service', 'parking.jpg', 'Active', 5.00),
('WiFi', 'High-Speed WiFi', 'High-speed internet access', 'wifi.jpg', 'Active', 0.00),
('Shuttle', 'Airport Shuttle', 'Shuttle service to and from airport', 'shuttle.jpg', 'Active', 30.00),
('Swimming Pool', 'Pool Access', 'Access to swimming pool', 'pool.jpg', 'Active', 10.00),
('Restaurant', 'Dining Service', 'In-house restaurant service', 'restaurant.jpg', 'Inactive', 40.00);
-- Insert data into Event_id
INSERT INTO "Event_id" ("title_event", "img", "start_date", "end_date", "detail", "discount_percent", "description", "status") VALUES
('Summer Sale', 'summer.jpg', '2023-06-01', '2023-06-30', 'Summer sale details', 10.0, 'Summer sale description', 'Active'),
('Christmas Special', 'christmas.jpg', '2023-12-01', '2023-12-25', 'Christmas special details', 20.0, 'Christmas special description', 'Active'),
('New Year Bash', 'newyear.jpg', '2023-12-31', '2024-01-01', 'New Year bash details', 15.0, 'New Year bash description', 'Active'),
('Black Friday', 'blackfriday.jpg', '2023-11-24', '2023-11-24', 'Black Friday details', 25.0, 'Black Friday description', 'Active'),
('Easter Celebration', 'easter.jpg', '2024-04-01', '2024-04-02', 'Easter celebration details', 10.0, 'Easter celebration description', 'Active'),
('Independence', 'independence.jpg', '2024-07-04', '2024-07-04', 'Independence Day details', 15.0, 'Independence Day description', 'Active')
-- Insert data into News
INSERT INTO "News" ("staff_id", "img", "title", "create_date", "desccription", "status") VALUES
(1, 'news1.jpg', 'Hotel Renovation', '2023-01-15', 'Details about hotel renovation', 'Published'),
(2, 'news2.jpg', 'New Chef', '2023-02-20', 'Introducing our new chef', 'Published'),
(3, 'news3.jpg', 'Summer Activities', '2023-06-10', 'Upcoming summer activities', 'Published'),
(4, 'news4.jpg', 'Holiday Discounts', '2023-12-05', 'Special holiday discounts', 'Draft'),
(5, 'news5.jpg', 'Fitness Center', '2023-03-25', 'New fitness center opening', 'Published'),
(6, 'news6.jpg', 'Guest Testimonials', '2023-05-18', 'Read our guest testimonials', 'Draft'),
(7, 'news7.jpg', 'COVID-19 Measures', '2023-07-30', 'Our COVID-19 safety measures', 'Published'),
(8, 'news8.jpg', 'Environmental Initiatives', '2023-09-12', 'Our green initiatives', 'Published'),
(9, 'news9.jpg', 'Room Upgrades', '2023-11-07', 'Details on room upgrades', 'Draft'),
(10, 'news10.jpg', 'Holiday Events', '2023-12-20', 'Upcoming holiday events', 'Published');
SELECT service_id FROM Room_service WHERE room_type_id = 2