-- CREATE TABLES

CREATE DATABASE testDB;
USE testDB;

CREATE TABLE product(
Pid CHAR(8) NOT NULL, # Pid = Product_ID
Pname VARCHAR(100) NOT NULL, # Pname = Product_Name
Pdesc VARCHAR(100) NOT NULL, # Pdesc = Product_Description
Pprice DECIMAL(10,2) NOT NULL, # Pprice = Product_Price
CONSTRAINT product_pk PRIMARY KEY (Pid));

CREATE TABLE supplier(
Sid CHAR(8) NOT NULL, # Sid = Supplier_ID
Sname VARCHAR(45) NOT NULL, # Sname = Supplier_Name
Slocation VARCHAR(25) NOT NULL, #Slocation = Supplier_Location
CONSTRAINT supplier_pk PRIMARY KEY (Sid));

CREATE TABLE warehouse (
Wid CHAR(8) NOT NULL, 
Wname VARCHAR(25) NOT NULL, # Wname = Warehouse_Name
Wlocation VARCHAR(25) NOT NULL, # Wlocation = Warehouse_location
Wsize DECIMAL (10,2) NOT NULL, # Wsize = Warehouse_Size
CONSTRAINT warehouse_pk PRIMARY KEY (Wid)
);

CREATE TABLE employee (
Eid CHAR(8) NOT NULL, # Eid = Employee_ID
Ename VARCHAR(25) NOT NULL, # Ename = Employee_Name
Age INT NOT NULL,
Hdate DATE NOT NULL, # Hdate = Hire_Date
Salary INT NOT NULL,
Etype CHAR(25) NOT NULL, # Etype = Employee_Type
CONSTRAINT employee_pk PRIMARY KEY (Eid)
);


CREATE TABLE supply(
Wid CHAR(8) NOT NULL, # Wid = Warehouse_ID
Sid CHAR(8) NOT NULL, 
Pid CHAR(8) NOT NULL,
Pcost DECIMAL(10,2) NOT NULL, # Pcost = Product_Cost
Smode CHAR(30) NOT NULL, # Smode = Shipping_Mode
CONSTRAINT supply_pk PRIMARY KEY (Wid, Sid, Pid),
CONSTRAINT supply_fk1 FOREIGN KEY(Sid) REFERENCES supplier(Sid),
CONSTRAINT supply_fk2 FOREIGN KEY(Pid) REFERENCES product(Pid),
CONSTRAINT supply_fk3 FOREIGN KEY(Wid) REFERENCES warehouse(Wid)
);

    
CREATE TABLE delivery (
Tid CHAR(8) NOT NULL, # Tid = Tracking_ID
Sdate DATE NOT NULL, # Sdate = Ship_Date
Ddate DATE NOT NULL, # Ddate = Delivery_Date
Tmethod VARCHAR(25), # Tmethod = Transport_Method
Wid CHAR(8),
CONSTRAINT delivery_pk PRIMARY KEY (Tid),
CONSTRAINT delivery_fk FOREIGN KEY (Wid) REFERENCES warehouse(Wid)
);
  
CREATE TABLE customer(
 Cid CHAR(8) NOT NULL, #Cid = Customer_ID
 Cname VARCHAR(25) NOT NULL, #Cname = Customer_Name
 Clocation VARCHAR(25) NOT NULL, # Clocation = Customer_Location
 CONSTRAINT customer_pk PRIMARY KEY(Cid)
 );
 
CREATE TABLE orders(
Oid CHAR(8) NOT NULL, # Oid = Order_ID
Oprice INT NOT NULL, # Oprice = Order_Price
Cid CHAR(8) NOT NULL, # CID = Customer_=ID
CONSTRAINT orders_pk PRIMARY KEY (Oid),
CONSTRAINT orders_fk FOREIGN KEY(Cid) REFERENCES customer(Cid)
);

CREATE TABLE order_item(
Tid CHAR(8) NOT NULL, # Tid = Tracking_ID
Pid CHAR(8) NOT NULL, # Pid = Product_ID
Oid CHAR(8) NOT NULL, # Oid = Order_ID
order_quantity INT NOT NULL,
CONSTRAINT orders_pk PRIMARY KEY (Tid, Pid, Oid),
CONSTRAINT order_item_fk1 FOREIGN KEY(Tid) REFERENCES delivery(Tid),
CONSTRAINT order_item_fk2 FOREIGN KEY(Pid) REFERENCES product(Pid),
CONSTRAINT order_item_fk3 FOREIGN KEY(Oid) REFERENCES orders(Oid)
);

CREATE TABLE warehouse_employee (
Weid CHAR(8) NOT NULL, # Weid = W_Employee_ID
Sschedule CHAR(10) NOT NULL, # Sschedule = Shift_Schedule
Sclearance CHAR(8) NOT NULL, # Sclearance = Security_Clearance
Cert CHAR (3) NOT NULL,
CertName VARCHAR(25) NOT NULL, # CertName = Certification_EC_Name
CertNumber CHAR(8) NOT NULL, # CertNumber = Certification_EC_Number
Wid CHAR(8) NOT NULL,
CONSTRAINT warehouse_employee_pk PRIMARY KEY (Weid),
CONSTRAINT warehouse_employee_fk1 FOREIGN KEY (Weid) REFERENCES employee(Eid), # Eid = Employee_ID
CONSTRAINT warehouse_employee_fk2 FOREIGN KEY (Wid) REFERENCES warehouse(Wid)
);

CREATE TABLE admins (
Aeid CHAR(8) NOT NULL, # Aeid = A_Employee_ID
Desig VARCHAR(25) NOT NULL, # Desig = Designation
Spec VARCHAR(25) NOT NULL, # Spec = Specialization
CONSTRAINT admins_pk PRIMARY KEY (Aeid),
CONSTRAINT admins_fk FOREIGN KEY (Aeid) REFERENCES employee(Eid)
);

CREATE TABLE admins_skills (
Aeid CHAR(8) NOT NULL, # Aeid = A_Employee_ID
Skills VARCHAR(25) NOT NULL,
CONSTRAINT admins_skills_pk PRIMARY KEY (Aeid,Skills),
CONSTRAINT admins_skills_fk FOREIGN KEY (Aeid) REFERENCES admins(Aeid)
);

CREATE TABLE customer_support (
Ceid CHAR(8) NOT NULL, # Ceid = C_Employee_ID
Dept VARCHAR(25) NOT NULL, # Dept = Department
Stat VARCHAR(25) NOT NULL, # Stat = Status
Eqp VARCHAR(25) NOT NULL, # Eqp = Equipment
Frating INT NOT NULL, # Frating = feedback_rating
CONSTRAINT customer_support_pk PRIMARY KEY (Ceid),
CONSTRAINT customer_support_fk FOREIGN KEY (Ceid) REFERENCES employee(Eid)
);

CREATE TABLE employee_language (
Ceid CHAR(8) NOT NULL, # Ceid = C_Employee_ID
Lang VARCHAR(25) NOT NULL, # Lang = Languages
CONSTRAINT employee_language_pk PRIMARY KEY (Ceid, Lang),
CONSTRAINT employee_language_fk FOREIGN KEY (Ceid) REFERENCES customer_support(Ceid)
);

CREATE TABLE customer_call (
Ceid CHAR(8) NOT NULL, # Ceid = C_Employee_ID
Cid CHAR(8) NOT NULL, # Cid = Customer_ID
CONSTRAINT customer_call_pk PRIMARY KEY (Ceid, Cid),
CONSTRAINT customer_call_fk1 FOREIGN KEY (Ceid) REFERENCES customer_support(Ceid),
CONSTRAINT customer_call_fk2 FOREIGN KEY (Cid) REFERENCES customer(Cid)
);


-- INSERT DATA INTO TABLES 

INSERT INTO product (Pid, Pname, Pdesc, Pprice) VALUES
('93130471', 'Stainless Steel Water Bottle', 'Durable and eco-friendly water bottle perfect for on-the-go hydration', 19.99),
('96743045', 'Wireless Bluetooth Earbuds', 'Sleek and lightweight earbuds with crystal-clear sound quality', 39.99),
('99701181', 'Portable Power Bank', 'Compact power bank to keep your devices charged anywhere, anytime', 29.99),
('90928462', 'Bamboo Cutting Board Set', 'Set of versatile and sustainable bamboo cutting boards for all your kitchen needs', 24.99),
('99965115', 'Aromatherapy Essential Oil Diffuser', 'Relaxing diffuser that fills your space with soothing scents and soft light', 34.99),
('91439690', 'Fitness Resistance Bands Set', 'Versatile set of resistance bands for a full-body workout at home or on the go', 14.99),
('94305831', 'Reusable Silicone Food Storage Bags', 'Eco-friendly alternative to plastic bags for storing food items', 12.99),
('91445130', 'LED Desk Lamp with USB Charging Port', 'Adjustable and energy-efficient desk lamp with built-in USB charging port', 29.99),
('99514413', 'Insulated Lunch Box', 'Stylish and practical lunch box to keep your meals fresh on the move', 17.99),
('95286757', 'Digital Kitchen Scale', 'Precise and compact scale for accurate measurements in cooking and baking', 19.99),
('97980685', 'Travel Neck Pillow', 'Comfortable memory foam neck pillow for restful travel experiences', 16.99),
('97560383', 'Cable Management Organizer Box', 'Neatly organize and conceal cables and power strips for a clutter-free space', 22.99),
('90323713', 'Collapsible Silicone Food Containers', 'Space-saving food containers that collapse for easy storage when not in use', 15.99),
('95110531', 'Smartphone Tripod with Remote', 'Adjustable tripod stand with remote control for capturing perfect selfies and group photos', 18.99),
('90159913', 'Non-Stick Silicone Baking Mats', 'Set of durable and reusable baking mats for effortless baking and easy cleanup', 10.99),
('97919294', 'Memory Foam Mattress Topper', 'Upgrade your sleep with this plush memory foam mattress topper for added comfort and support', 89.99),
('91000888', 'Resistance Loop Bands Set', 'Versatile set of resistance bands to target different muscle groups for effective home workouts', 15.99),
('92927788', 'Digital Meat Thermometer', 'Ensure perfectly cooked meals every time with this easy-to-use digital meat thermometer', 12.99),
('93235067', 'Eco-Friendly Bamboo Toothbrush Set', 'Sustainable toothbrushes made from bamboo, perfect for reducing plastic waste', 9.99),
('93350164', 'Magnetic Refrigerator Organizer Rack', 'Maximize storage space in your kitchen with this magnetic organizer rack for your fridge', 19.99),
('98435396', 'Bluetooth Smart Body Scale', 'Track your fitness progress with precision using this Bluetooth-enabled smart body scale', 29.99),
('99134772', 'Handheld Milk Frother', 'Create cafe-quality frothed milk at home with this handheld frother', 8.99),
('95539338', 'Portable Foldable Solar Charger', 'Stay powered up on your outdoor adventures with this portable solar charger for your devices', 49.99),
('99287718', 'Set of Stainless Steel Mixing Bowls', 'Durable and versatile set of stainless steel mixing bowls for all your cooking and baking needs', 24.99),
('99987810', 'Electric Wine Bottle Opener', 'Effortlessly uncork your favorite wines with this sleek and convenient electric wine bottle opener', 19.99),
('96974436', 'Himalayan Salt Lamp', 'Create a relaxing ambiance in any room with the warm glow of a Himalayan salt lamp', 17.99),
('90938537', 'Yoga Mat with Carrying Strap', 'Practice yoga comfortably anywhere with this non-slip yoga mat with a carrying strap', 21.99),
('95110101', 'Rechargeable Handheld Vacuum Cleaner', 'Keep your home clean and tidy with this lightweight and portable handheld vacuum cleaner', 39.99),
('90969695', 'Collapsible Silicone Colander Set', 'Space-saving and easy to clean collapsible silicone colanders ', 11.99),
('95776174', 'LED Lighted Makeup Mirror', 'LED lighted makeup mirror featuring adjustable brightness settings', 29.99),
('97076222', 'Electric Tea Kettle', 'Boil water quickly and efficiently with this stylish electric tea kettle, perfect for tea lovers', 34.99),
('96775488', 'Adjustable Laptop Stand', 'Improve ergonomics and comfort while working with this adjustable laptop stand for your desk', 27.99);


INSERT INTO supplier (Sid, Sname, Slocation) VALUES
('44328079', 'BrightBargains', 'Portugal'),
('49103348', 'TrendyTreasures', 'Denmark'),
('49177137', 'SwiftSupplyCo', 'Belgium'),
('45303590', 'PrimePicks', 'Canada'),
('44571275', 'GlobalGoodsHub', 'Austria'),
('48174822', 'EliteEssentials', 'Russia'),
('44048626', 'ValueVista', 'Malaysia'),
('42780580', 'LuxeLane', 'Brunei'),
('47034393', 'CraftyCorner', 'Indonesia'),
('42095500', 'MegaMartOnline', 'Singapore'),
('49857142', 'UrbanUtopia', 'Taiwan'),
('45259485', 'PeakProvisions', 'Thailand'),
('44664798', 'FreshFindsMarket', 'Philippines'),
('40710241', 'SmartSolutionsOutlet', 'Germany'),
('48837368', 'ChicChoiceEmporium', 'Vietnam'),
('40302407', 'EverlastingElegance', 'France'),
('48403366', 'HandyHelpersHQ', 'Netherlands'),
('45457664', 'SereneSelections', 'Korea'),
('43683571', 'EcoEdgeEmporium', 'Japan'),
('46348863', 'GalaxyGoodsGlobal', 'China'),
('45286151', 'PoshPurchases', 'Poland'),
('49682573', 'AuroraAccessories', 'Italy'),
('44569527', 'ZenithZone', 'Cambodia'),
('40169773', 'NexusNecessities', 'Myanmar'),
('47713008', 'EnigmaEmporium', 'India'),
('48906337', 'StellarSupplies', 'Hong Kong'),
('44061013', 'SparkleSpot', 'Turkey'),
('48047244', 'GrandGizmos', 'USA'),
('41936477', 'InfiniteItemsInc', 'Australia'),
('43056227', 'SupremeSelections', 'Mexico'),
('42686084', 'DreamyDealsDepot', 'Brazil'),
('49932149', 'TerraTreasuresTrading', 'Argentina');



INSERT INTO warehouse (Wid, Wname, Wlocation, Wsize) VALUES 
('81371812', 'A Logistics Pte. Ltd.', 'Malaysia', 48),
('86461788', 'B Logistics Pte. Ltd.', 'Brunei', 50),
('87447642', 'C Logistics Pte. Ltd.', 'Indonesia', 44),
('86292120', 'D Logistics Pte. Ltd.', 'Singapore', 19),
('86044506', 'E Logistics Pte. Ltd.', 'Taiwan', 36),
('81296683', 'F Logistics Pte. Ltd.', 'Thailand', 81),
('86172204', 'G Logistics Pte. Ltd.', 'Philippines', 61),
('87281245', 'H Logistics Pte. Ltd.', 'Germany', 98),
('86489235', 'I Logistics Pte. Ltd.', 'Vietnam', 27),
('86912002', 'J Logistics Pte. Ltd', 'Hong Kong', 32);

INSERT INTO employee (Eid, Ename, Age, Hdate, Salary, Etype) VALUES
('37678533', 'James Smith', 31, '2017-01-23', 69000, 'Warehouse_Employee'),
('34083249', 'Mary Johnson', 26, '2018-05-11', 53000, 'Warehouse_Employee'),
('38355120', 'John Williams', 46, '2016-10-05', 51000, 'Warehouse_Employee'),
('31980400', 'Patricia Brown', 52, '2020-12-08', 243000, 'Warehouse_Employee'),
('39609243', 'Robert Jones', 41, '2019-03-29', 102000, 'Warehouse_Employee'),
('33491484', 'Jennifer Davis', 31, '2015-06-17', 126000, 'Warehouse_Employee'),
('30925511', 'Michael Miller', 37, '2022-09-06', 196000, 'Warehouse_Employee'),
('34183332', 'Linda Wilson', 59, '2017-11-20', 95000, 'Warehouse_Employee'),
('31318978', 'William Moore', 39, '2016-04-03', 244000, 'Warehouse_Employee'),
('36707325', 'Elizabeth Taylor', 53, '2023-08-15', 220000, 'Warehouse_Employee'),
('18229198', 'David Anderson', 32, '2021-02-09', 203000, 'Admins'),
('16424182', 'Barbara Martinez', 37, '2015-07-28', 146000, 'Admins'),
('13359638', 'Richard Thomas', 44, '2018-10-12', 179000, 'Admins'),
('16658230', 'Susan Garcia', 42, '2020-05-01', 285000, 'Admins'),
('14946940', 'Joseph Hernandez', 30, '2017-09-22', 159000, 'Admins'),
('18377036', 'Jessica Young', 37, '2016-03-08', 286000, 'Admins'),
('15490490', 'Thomas Allen', 32, '2019-06-05', 268000, 'Admins'),
('13186670', 'Sarah Clark', 30, '2022-01-14', 255000, 'Admins'),
('11262651', 'Charles Lewis', 57, '2016-11-03', 61000, 'Admins'),
('12840018', 'Karen Hall', 58, '2018-04-26', 234000, 'Admins'),
('13983492', 'Christopher Scott', 36, '2021-08-10', 240000, 'Admins'),
('21438886', 'Angela King', 53, '2015-12-30', 290000, 'customer_support'),
('29527129', 'Daniel Wright', 56, '2023-07-07', 208000, 'customer_support'),
('29030340', 'Ashley Lopez', 40, '2020-10-18', 284000, 'customer_support'),
('28238983', 'Matthew Hill', 40, '2017-02-28', 61000, 'customer_support'),
('24258153', 'Kimberly Green', 40, '2022-06-21', 118000, 'customer_support'),
('23442580', 'Mark Adams', 32, '2015-09-13', 172000, 'customer_support'),
('28553691', 'Emily Baker', 32, '2019-12-04', 241000, 'customer_support'),
('26688862', 'Paul Gonzalez', 53, '2021-05-17', 174000, 'customer_support'),
('22942442', 'Michelle Carter', 55, '2018-01-05', 231000, 'customer_support'),
('20641545', 'Ryan Rodriguez', 43, '2016-03-26', 250000, 'customer_support'),
('27976671', 'Amanda Martinez', 59, '2020-08-07', 66000, 'customer_support'),
('34868105', 'Emily Patel', 36, '2019-09-23', 80000, 'Warehouse_Employee'),
('36766814', 'Benjamin Smith', 50, '2022-02-12', 97000, 'Warehouse_Employee'),
('37453792', 'Sofia Garcia', 30, '2020-07-06', 198000, 'Warehouse_Employee'),
('37909760', 'Lucas Johnson', 50, '2018-11-17', 120000, 'Warehouse_Employee'),
('34917897', 'Mia Brown', 40, '2021-03-09', 139000, 'Warehouse_Employee'),
('38975487', 'Ethan Martinez', 48, '2022-05-30', 135000, 'Warehouse_Employee'),
('31608557', 'Olivia Taylor', 34, '2019-01-08', 192000, 'Warehouse_Employee'),
('37042258', 'Alexander Anderson', 39, '2020-08-14', 112000, 'Warehouse_Employee'),
('30796276', 'Ava Thomas', 30, '2018-11-05', 130000, 'Warehouse_Employee'),
('35648529', 'William Wilson', 45, '2021-10-28', 179000, 'Warehouse_Employee'),
('36648052', 'Harper Lee', 50, '2019-06-21', 95000, 'Warehouse_Employee'),
('39897188', 'James Rodriguez', 45, '2022-12-11', 80000, 'Warehouse_Employee'),
('31541882', 'Charlotte Harris', 47, '2020-02-05', 83000, 'Warehouse_Employee'),
('33332000', 'Michael Martinez', 40, '2021-09-02', 136000, 'Warehouse_Employee'),
('33477046', 'Amelia Davis', 49, '2018-03-26', 143000, 'Warehouse_Employee'),
('34763303', 'Daniel Miller', 47, '2019-07-19', 80000, 'Warehouse_Employee'),
('30454307', 'Evelyn Thompson', 40, '2020-11-09', 142000, 'Warehouse_Employee'),
('39611525', 'Alexander Scott', 42, '2022-05-01', 89000, 'Warehouse_Employee'),
('32013346', 'Isabella Young', 50, '2018-01-28', 73000, 'Warehouse_Employee'),
('39959136', 'Ethan Lopez', 31, '2021-08-23', 114000, 'Warehouse_Employee'),
('30952452', 'Sophia Clark', 30, '2019-04-15', 165000, 'Warehouse_Employee'),
('30012543', 'Liam Hall', 39, '2020-10-05', 162000, 'Warehouse_Employee');


INSERT INTO supply (Wid, Sid, Pid, Pcost, Smode) VALUES
('81371812', '44328079', '93130471', 19.99, 'Land'),
('86461788', '49103348', '96743045', 39.99, 'Land'),
('87447642', '49177137', '99701181', 29.99, 'Sea'),
('86292120', '45303590', '90928462', 24.99, 'Land'),
('86044506', '44571275', '99965115', 34.99, 'Sea'),
('81296683', '48174822', '91439690', 14.99, 'Land'),
('86172204', '44048626', '94305831', 12.99, 'Air Frieght'),
('87281245', '42780580', '91445130', 29.99, 'Land'),
('86489235', '47034393', '99514413', 17.99, 'Sea'),
('86912002', '42095500', '95286757', 19.99, 'Land'),
('81371812', '49857142', '97980685', 16.99, 'Land'),
('86461788', '45259485', '97560383', 22.99, 'Sea'),
('87447642', '44664798', '90323713', 15.99, 'Land'),
('86292120', '40710241', '95110531', 18.99, 'Land'),
('86044506', '48837368', '90159913', 10.99, 'Land'),
('81296683', '40302407', '97919294', 89.99, 'Air Frieght'),
('86172204', '48403366', '91000888', 15.99, 'Land'),
('87281245', '45457664', '92927788', 12.99, 'Land'),
('86489235', '43683571', '93235067', 9.99, 'Land'),
('86912002', '46348863', '93350164', 19.99, 'Land'),
('81371812', '45286151', '98435396', 29.99, 'Sea'),
('86461788', '49682573', '99134772', 8.99, 'Land'),
('87447642', '44569527', '95539338', 49.99, 'Sea'),
('86292120', '40169773', '99287718', 24.99, 'Land'),
('86044506', '47713008', '99987810', 19.99, 'Land'),
('81296683', '48906337', '96974436', 17.99, 'Land'),
('86172204', '44061013', '90938537', 21.99, 'Land'),
('87281245', '48047244', '95110101', 39.99, 'Sea'),
('86489235', '41936477', '90969695', 11.99, 'Sea'),
('86912002', '43056227', '95776174', 29.99, 'Sea'),
('81371812', '42686084', '97076222', 34.99, 'Air Frieght'),
('86461788', '49932149', '96775488', 27.99, 'Land');


INSERT INTO delivery (Tid, Sdate, Ddate, Tmethod, Wid) VALUES
('77060938', '2023-01-15', '2024-04-18', 'Land', '81371812'),
('76732111', '2023-02-15', '2024-04-12', 'Land', '86461788'),
('77280252', '2023-03-15', '2024-03-21', 'Sea', '87447642'),
('72242908', '2023-04-15', '2024-03-30', 'Land', '86292120'),
('77307224', '2023-05-15', '2024-03-29', 'Sea', '86044506'),
('71716027', '2023-06-15', '2024-04-03', 'Land', '81296683'),
('77063833', '2023-07-15', '2024-03-20', 'Air Frieght', '86172204'),
('75688353', '2023-08-15', '2024-03-30', 'Land', '87281245'),
('78146835', '2023-09-15', '2024-03-27', 'Sea', '86489235'),
('75263082', '2023-10-15', '2024-04-11', 'Land', '86912002'),
('73055524', '2023-11-15', '2024-04-15', 'Land', '81371812'),
('75939321', '2023-12-15', '2024-03-19', 'Sea', '86461788'),
('75912356', '2023-01-31', '2024-03-24', 'Land', '87447642'),
('74635698', '2023-02-28', '2024-04-11', 'Land', '86292120'),
('77381818', '2023-03-31', '2024-04-29', 'Land', '86044506'),
('74684568', '2023-04-30', '2024-03-06', 'Air Frieght', '81296683'),
('78437639', '2023-05-31', '2024-03-27', 'Land', '86172204'),
('76387650', '2023-06-30', '2024-04-16', 'Land', '87281245'),
('77515774', '2023-07-31', '2024-03-27', 'Land', '86489235'),
('70313637', '2023-08-31', '2024-04-07', 'Land', '86912002'),
('72219158', '2023-09-30', '2024-03-20', 'Sea', '81371812'),
('75760521', '2023-10-31', '2024-04-28', 'Land', '86461788'),
('77190266', '2023-11-30', '2024-03-12', 'Sea', '87447642'),
('76108262', '2023-12-31', '2024-04-18', 'Land', '86292120'),
('71900268', '2023-01-14', '2024-04-06', 'Land', '86044506'),
('76590369', '2023-02-14', '2024-04-20', 'Land', '81296683'),
('77061653', '2023-03-14', '2024-04-03', 'Land', '86172204'),
('73286815', '2023-04-14', '2024-03-26', 'Sea', '87281245'),
('73078404', '2023-12-14', '2024-04-01', 'Sea', '86489235'),
('76887291', '2023-12-14', '2024-04-04', 'Sea', '86912002'),
('73609265', '2023-12-14', '2024-03-25', 'Air Frieght', '81371812'),
('72526340', '2023-12-14', '2024-04-04', 'Land', '86461788');



INSERT INTO customer (Cid, Cname, Clocation) VALUES
('53515080', 'Fatima Nguyen', 'Japan'),
('50018245', 'Diego Patel', 'Germany'),
('53217266', 'Aisha Khan', 'India'),
('56891456', 'Javier Martinez', 'France'),
('57588258', 'Mei Wong', 'China'),
('57223896', 'Henrik Johansson', 'Italy'),
('58045094', 'Priya Gupta', 'South Korea'),
('50445501', 'Jamal Al-Farsi', 'United Kingdom'),
('51171712', 'Isabella Costa', 'Russia'),
('51632994', 'Malik Abadi', 'Singapore'),
('58192661', 'Li Wei', 'Spain'),
('55321530', 'Jasmine Tan', 'Singapore'),
('53609601', 'Grace Lim', 'Thailand'),
('55359121', 'Daniel Seah', 'Japan'),
('52551035', 'Rachel Lee', 'Indonesia'),
('57701874', 'Kelvin Wong', 'Indonesia'),
('55044034', 'Michelle Ng', 'Netherlands'),
('57505009', 'Farhan Abdullah', 'Vietnam'),
('53262665', 'Valerie Goh', 'Belgium'),
('51334469', 'Marcus Tan', 'Philippines'),
('54812142', 'Jocelyn Lim', 'Thailand'),
('51730333', 'Wei Jie', 'Sweden'),
('58272224', 'Amanda Tan', 'Switzerland'),
('54901434', 'Rajesh Kumar', 'Malaysia'),
('53081493', 'Sharon Lim', 'Austria'),
('54006785', 'Ahmad bin Ismail', 'Norway'),
('52960059', 'Chloe Tan', 'Singapore'),
('54551273', 'Jason Lee', 'Singapore'),
('53537877', 'Patricia Wee', 'Indonesia'),
('54939378', 'Benjamin Tay', 'Singapore'),
('50806079', 'Jin Kazama', 'Japan'),
('52521514', 'Jackson Wang', 'Vietnam');

INSERT INTO orders (Oid, Oprice, Cid) VALUES
('64326363', 179.91, '53515080'),
('69926703', 319.92, '50018245'),
('61035101', 179.94, '53217266'),
('63418365', 124.95, '56891456'),
('63840448', 104.97, '57588258'),
('64644314', 29.98, '57223896'),
('64728246', 25.98, '58045094'),
('68639724', 269.91, '50445501'),
('69861162', 143.92, '51171712'),
('68817284', 59.97, '51632994'),
('65794078', 135.92, '58192661'),
('66829862', 114.95, '55321530'),
('66669304', 111.93, '53609601'),
('62079974', 170.91, '55359121'),
('66057813', 54.95, '52551035'),
('66332505', 449.95, '57701874'),
('69936549', 31.98, '55044034'),
('64393194', 116.91, '57505009'),
('60834061', 29.97, '53262665'),
('61814174', 159.92, '51334469'),
('60025211', 29.99, '54812142'),
('61807999', 44.95, '51730333'),
('66304588', 449.91, '58272224'),
('67877832', 199.92, '54901434'),
('69218006', 59.97, '53081493'),
('65644707', 161.91, '54006785'),
('68488572', 65.97, '52960059'),
('66670521', 79.98, '54551273'),
('62951342', 35.97, '53537877'),
('61090879', 59.98, '54939378'),
('63727532', 314.91, '50806079'),
('62095165', 223.92, '52521514');


INSERT INTO order_item (Tid, Pid, Oid, order_quantity) VALUES
('77060938', '93130471', '64326363', 9),
('76732111', '96743045', '69926703', 8),
('77280252', '99701181', '61035101', 6),
('72242908', '90928462', '63418365', 5),
('77307224', '99965115', '63840448', 3),
('71716027', '91439690', '64644314', 2),
('77063833', '94305831', '64728246', 2),
('75688353', '91445130', '68639724', 9),
('78146835', '99514413', '69861162', 8),
('75263082', '95286757', '68817284', 3),
('73055524', '97980685', '65794078', 8),
('75939321', '97560383', '66829862', 5),
('75912356', '90323713', '66669304', 7),
('74635698', '95110531', '62079974', 9),
('77381818', '90159913', '66057813', 5),
('74684568', '97919294', '66332505', 5),
('78437639', '91000888', '69936549', 2),
('76387650', '92927788', '64393194', 9),
('77515774', '93235067', '60834061', 3),
('70313637', '93350164', '61814174', 8),
('72219158', '98435396', '60025211', 1),
('75760521', '99134772', '61807999', 5),
('77190266', '95539338', '66304588', 9),
('76108262', '99287718', '67877832', 8),
('71900268', '99987810', '69218006', 3),
('76590369', '96974436', '65644707', 9),
('77061653', '90938537', '68488572', 3),
('73286815', '95110101', '66670521', 2),
('73078404', '90969695', '62951342', 3),
('76887291', '95776174', '61090879', 2),
('73609265', '97076222', '63727532', 9),
('72526340', '96775488', '62095165', 8);



INSERT INTO warehouse_employee (Weid, Sschedule, Sclearance, Cert, CertName, CertNumber, Wid) VALUES 
('37678533', 'Morning', 'Clear', 'Yes', 'Safety', '31274789', '81371812'),
('34083249', 'Afternoon', 'Clear', 'Yes', 'Management', '31249625', '86461788'),
('38355120', 'Night', 'Clear', 'Yes', 'Risk Control', '31281454', '87447642'),
('31980400', 'Morning', 'Clear', 'Yes', 'Logistics', '31280702', '86292120'),
('39609243', 'Afternoon', 'Pending', 'No', 'Safety', '31222349', '86044506'),
('33491484', 'Night', 'Clear', 'Yes', 'Management', '31230186', '81296683'),
('30925511', 'Morning', 'Pending', 'No', 'Risk Control', '31247092', '86172204'),
('34183332', 'Afternoon', 'Clear', 'Yes', 'Logistics', '31275397', '87281245'),
('31318978', 'Night', 'Clear', 'Yes', 'Safety', '31279273', '86489235'),
('36707325', 'Morning', 'Pending', 'No', 'Management', '31263255', '86912002'),
('34868105', 'Afternoon', 'Clear', 'Yes', 'Risk Control', '31272963', '81371812'),
('36766814', 'Night', 'Clear', 'Yes', 'Safety', '31205317', '86461788'),
('37453792', 'Morning', 'Clear', 'Yes', 'Management', '31276583', '87447642'),
('37909760', 'Afternoon', 'Clear', 'Yes', 'Risk Control', '31225064', '86292120'),
('34917897', 'Night', 'Pending', 'No', 'Safety', '31268811', '86044506'),
('38975487', 'Morning', 'Clear', 'Yes', 'Management', '31255072', '81296683'),
('31608557', 'Afternoon', 'Pending', 'No', 'Risk Control', '31277967', '86172204'),
('37042258', 'Night', 'Clear', 'Yes', 'Safety', '31268714', '87281245'),
('30796276', 'Morning', 'Clear', 'Yes', 'Management', '31248668', '86489235'),
('35648529', 'Afternoon', 'Pending', 'No', 'Risk Control', '31238706', '86912002'),
('36648052', 'Night', 'Clear', 'Yes', 'Safety', '31201652', '81371812'),
('39897188', 'Morning', 'Clear', 'Yes', 'Management', '31246286', '86461788'),
('31541882', 'Afternoon', 'Clear', 'Yes', 'Risk Control', '31233073', '87447642'),
('33332000', 'Night', 'Clear', 'Yes', 'Safety', '31249907', '86292120'),
('33477046', 'Morning', 'Pending', 'No', 'Management', '31295573', '86044506'),
('34763303', 'Afternoon', 'Clear', 'Yes', 'Risk Control', '31242417', '81296683'),
('30454307', 'Night', 'Pending', 'No', 'Safety', '31286659', '86172204'),
('39611525', 'Morning', 'Clear', 'Yes', 'Management', '31238617', '87281245'),
('32013346', 'Afternoon', 'Clear', 'Yes', 'Risk Control', '31270808', '86489235'),
('39959136', 'Night', 'Pending', 'No', 'Safety', '31200409', '86912002'),
('30952452', 'Morning', 'Pending', 'No', 'Management', '31275031', '81371812'),
('30012543', 'Afternoon', 'Clear', 'Yes', 'Risk Control', '31210407', '86461788');

INSERT INTO customer_support (Ceid, Dept, Stat, Eqp, Frating) VALUES
('21438886', 'Live Chat', 'Ongoing', 'laptop', 4),
('29527129', 'Account Management', 'Ongoing', 'phone', 3),
('29030340', 'Technical Support', 'Ongoing', 'headset', 5),
('28238983', 'Live Chat', 'Ongoing', 'laptop', 4),
('24258153', 'Live Chat', 'Ongoing', 'laptop', 1),
('23442580', 'Technical Support', 'Ongoing', 'headset', 5),
('28553691', 'Live Chat', 'Ongoing', 'laptop', 4),
('26688862', 'Account Management', 'Ongoing', 'phone', 3),
('22942442', 'Technical Support', 'Ongoing', 'headset', 4),
('20641545', 'Account Management', 'Ongoing', 'phone', 5),
('27976671', 'Technical Support', 'Ongoing', 'headset', 2);

INSERT INTO employee_language (Ceid, Lang) VALUES 
('21438886', 'English'),
('29527129', 'English'),
('29030340', 'English'),
('28238983', 'English'),
('24258153', 'English'),
('23442580', 'English'),
('28553691', 'English'),
('26688862', 'English'),
('22942442', 'English'),
('20641545', 'English'),
('27976671', 'English'),
('21438886', 'Mandarin'),
('29527129', 'Mandarin'),
('29030340', 'Mandarin'),
('28238983', 'Mandarin'),
('24258153', 'Mandarin'),
('23442580', 'Mandarin'),
('28553691', 'Mandarin'),
('26688862', 'Mandarin'),
('24258153', 'Malay'),
('23442580', 'Malay'),
('28553691', 'Malay'),
('26688862', 'Malay'),
('22942442', 'Malay'),
('20641545', 'Malay'),
('27976671', 'Malay');




INSERT INTO customer_call (Ceid, Cid) VALUES
('21438886', '53515080'),
('29527129', '50018245'),
('29030340', '53217266'),
('28238983', '56891456'),
('24258153', '57588258'),
('23442580', '57223896'),
('28553691', '58045094'),
('26688862', '50445501'),
('22942442', '51171712'),
('20641545', '51632994'),
('27976671', '58192661'),
('28553691', '55321530'),
('26688862', '53609601'),
('22942442', '55359121'),
('20641545', '52551035'),
('27976671', '57701874'),
('26688862', '55044034'),
('22942442', '57505009'),
('20641545', '53262665'),
('21438886', '51334469'),
('21438886', '54812142');
