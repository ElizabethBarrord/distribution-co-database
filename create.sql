DROP SCHEMA warehouse;

CREATE SCHEMA warehouse;

USE warehouse;

CREATE TABLE warehouse
(
	wcode varchar(15) NOT NULL,
	wname varchar(30),
	PRIMARY KEY (wcode)
);

CREATE TABLE part
(
	partno int NOT NULL,
	pname varchar(20),
	bdate varchar(10),
	bqty int,
	empno int NOT NULL,
	PRIMARY KEY (partno)
);

CREATE TABLE abin
(
	wcode varchar(15) NOT NULL,
	binno int(11) NOT NULL,
	capacity int,
	PRIMARY KEY (wcode, binno)
);

CREATE TABLE batch
(
	batchno int(11) NOT NULL,
	datein varchar(10) NOT NULL,
	size int,
	wcode varchar(15) NOT NULL,
	binno int(11) NOT NULL,
	PRIMARY KEY (batchno)
);

CREATE TABLE item
(
	itemno int NOT NULL,
	batchno int NOT NULL,
	partno int NOT NULL,
	idateout varchar(10),
	empno int NOT NULL,
	PRIMARY KEY (itemno, batchno, partno)
);

CREATE TABLE manager
(
	empno int NOT NULL,
	mname varchar(20),
	PRIMARY KEY (empno)
);

CREATE TABLE instances
(
	itemno int NOT NULL,
	partno int NOT NULL,
	batchno int NOT NULL,
	PRIMARY KEY (itemno, partno, batchno)
);


CREATE TABLE assembly
(
	assemblyno int NOT NULL,
	adateout varchar(10) NOT NULL,
	empno int NOT NULL,
	PRIMARY KEY (assemblyno)
);

CREATE TABLE comprises
(
	itemno int NOT NULL,
	partno int NOT NULL,
	batchno int NOT NULL,
	assemblyno int NOT NULL,
	PRIMARY KEY (itemno, partno, batchno, assemblyno)
);


INSERT INTO warehouse
	(wcode, wname)
VALUES
	('warehouse0001','Warehouse 1'),
	('warehouse0002','Warehouse 2'),
	('warehouse0003','Warehouse 3'),
	('warehouse0004','Warehouse 4'),
	('warehouse0005','Warehouse 5'),
	('warehouse0006','Warehouse 6');

INSERT INTO abin
	(binno, wcode, capacity)
VALUES
	(0001,'warehouse0001', 50),
	(0002,'warehouse0001', 40),
	(0003,'warehouse0001', 40),
	(0004,'warehouse0003', 50),
	(0005,'warehouse0003', 50);

INSERT INTO part
	(partno, pname, bdate, bqty, empno)
VALUES
	(1114, 'tire', '2018-23-03', 12, 2001),
	(1002, 'mirror', '2018-20-01', 15, 2004),
	(1003, 'side door', '2018-20-01', 35,2005),
	(1004, 'wheel', '2018-10-10', 40, 2001),
	(1005, 'gas pedal', '2018-05-02', 47, 2001);

INSERT INTO manager
	(empno, mname)
VALUES
	(2001, 'Sarah Kelly'),
	(2002, 'Justin Baker'),
	(2003, 'Jacob Back'),
	(2004, 'Edward Cullen'),
	(2005, 'Shauna Weiss');

INSERT INTO comprises
	(itemno, partno, batchno, assemblyno)
VALUES
	(4001, 1114, 3002, 5001),
	(4002, 1003, 3003, 5002),
	(4003, 1004, 3001, 5003),
	(4004, 1004, 3005, 5004),
	(4005, 1005, 3002, 5005);

INSERT INTO batch
	(batchno, datein, size, binno, wcode)
VALUES
	(3001, '2018-01-01', 100, 0002,'warehouse0001'),
	(3002, '2018-03-30', 210, 0004,'warehouse0004'),
	(3003, '2018-05-11', 300, 0001,'warehouse0005'),
	(3004, '2018-15-06', 50, 0003,'warehouse0002'),
	(3005, '2018-01-08', 70, 0001,'warehouse0004');

INSERT INTO instances
	(itemno, partno, batchno)
VALUES
	(4001, 1114, 3002),
	(4002, 1003, 3003),
	(4003, 1004, 3001),
	(4004, 1004, 3005),
	(4005, 1005, 3002);

INSERT INTO item
	(itemno, batchno, partno, idateout, empno)
VALUES
	(4001, 3002, 1114,'2018-01-01', 2005),
	(4002, 3003, 1003,'2018-05-11', 2003),
	(4003, 3001, 1004,'2018-04-12', 2003),
	(4004, 3005, 1004,'2018-04-09', 2002),
	(4005, 3002, 1005,'2018-04-29', 2003);

INSERT INTO assembly
	(assemblyno, adateout, empno)
VALUES
	(5001, '2018-07-13', 2004),
	(5002, '2018-05-03', 2001),
	(5003, '2018-10-10', 2004),
	(5004, '2018-07-13', 2003),
	(5005, '2018-07-13', 2005);


ALTER TABLE part
	ADD FOREIGN KEY (empno) REFERENCES manager(empno);

ALTER TABLE abin
	ADD FOREIGN KEY (wcode) REFERENCES warehouse(wcode);

ALTER TABLE batch
	ADD FOREIGN KEY (binno) REFERENCES abin(binno),
	ADD FOREIGN KEY (wcode) REFERENCES abin(wcode);

ALTER TABLE item
	ADD FOREIGN KEY (batchno) REFERENCES batch(batchno),
	ADD FOREIGN KEY (partno) REFERENCES part(partno),
	ADD FOREIGN KEY (empno) REFERENCES manager(empno);

ALTER TABLE instances
	ADD FOREIGN KEY (itemno) REFERENCES item(itemno),
	ADD FOREIGN KEY (partno) REFERENCES part(partno),
	ADD FOREIGN KEY (batchno) REFERENCES batch(batchno);

ALTER TABLE assembly
	ADD FOREIGN KEY (empno) REFERENCES manager(empno);

ALTER TABLE comprises
	ADD FOREIGN KEY (itemno) REFERENCES item(itemno),
	ADD FOREIGN KEY (partno) REFERENCES item(partno),
	ADD FOREIGN KEY (batchno) REFERENCES item(batchno),
	ADD FOREIGN KEY (assemblyno) REFERENCES assembly(assemblyno);
