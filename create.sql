CREATE SCHEMA company;

USE company;

CREATE TABLE warehouse
(
	wcode varchar(15) NOT NULL,
	wname varchar(30),
	PRIMARY KEY (wcode)
);

CREATE TABLE bin
(
	wcode varchar(15) NOT NULL,
	binno int NOT NULL,
	capacity int,
	PRIMARY KEY (wcode, binno)
);

CREATE TABLE part
(
	partno int NOT NULL,
	pname varchar(20),
	bdate datetime,
	bqty int,
	PRIMARY KEY (partno)
);

CREATE TABLE manager
(
	empno int NOT NULL,
	mname varchar(20),
	PRIMARY KEY (empno)
);

CREATE TABLE comprises
(
	itemno int NOT NULL,
	partno int NOT NULL,
	batchno int NOT NULL,
	assemblyno int NOT NULL,
	PRIMARY KEY (itemno, partno, batchno, assemblyno)
);

CREATE TABLE batch
(
	batchno int NOT NULL,
	datein datetime NOT NULL,
	size int,
	binno int,
	wcode varchar(9) NOT NULL,
	PRIMARY KEY (batchno)
);


CREATE TABLE instances
(
	itemno int NOT NULL,
	partno int NOT NULL,
	batchno int NOT NULL,
	PRIMARY KEY (itemno, partno, batchno)
);

CREATE TABLE item
(
	itemno int NOT NULL,
	batchno int NOT NULL,
	partno int NOT NULL,
	idateout datetime,
	PRIMARY KEY (itemno, batchno, partno)
);

CREATE TABLE assembly
(
	assemblyno int NOT NULL,
	adateout datetime NOT NULL,
	PRIMARY KEY (assemblyno)
);


INSERT INTO warehouse
	(wcode, w-name)
VALUES
	('warehouse0001','Warehouse 1'),
	('warehouse0002','Warehouse 2'),
	('warehouse0003','Warehouse 3');

INSERT INTO bin
	(binno, wcode, capacity)
VALUES
	(10001,'warehouse0001', 50),
	(10002,'warehouse0001', 40),
	();

INSERT INTO part
	(partno, pname, bdate, bqty)
VALUES
	(),
	(),
	('),
	('),
	();

INSERT INTO manager
	(empno, mname)
VALUES
	(),
	(),
	('),
	('),
	();

INSERT INTO comprises
	(itemno, partno, batchno, assemblyno)
VALUES
	(),
	(),
	('),
	('),
	();



INSERT INTO batch
	(batchno, datein, size, binno, wcode)
VALUES
	(),
	(),
	('),
	('),
	();

INSERT INTO instances
	(itemno, partno, size, batchno)
VALUES
	(),
	(),
	(),
	(),
	();

INSERT INTO item
	(itemno, batchno, partno, idateno)
VALUES
	(),
	(),
	(),
	(),
	();

INSERT INTO assembly
	(assemblyno, adateout)
VALUES
	(),
	(),
	(),
	(),
	();

ALTER TABLE bin
	ADD FOREIGN KEY (wcode) REFERENCES warehouse(wcode);

ALTER TABLE comprises
	ADD FOREIGN KEY (itemno) REFERENCES item(itemno),
	ADD FOREIGN KEY (partno) REFERENCES part(partno),
	ADD FOREIGN KEY (batchno) REFERENCES batch(batchno),
	ADD FOREIGN KEY (assemblyno) REFERENCES assembly(assemblyno);


ALTER TABLE batch
	ADD FOREIGN KEY (binno) REFERENCES bin(binno),
	ADD FOREIGN KEY (wcode) REFERENCES warehouse(wcode);

ALTER TABLE instances
	ADD FOREIGN KEY (itemno) REFERENCES item(itemno),
	ADD FOREIGN KEY (partno) REFERENCES part(partno),
	ADD FOREIGN KEY (batchno) REFERENCES batch(batchno);

ALTER TABLE item
	ADD FOREIGN KEY (batchno) REFERENCES batch(batchno),
	ADD FOREIGN KEY (partno) REFERENCES part(partno);

ALTER TABLE dependent
	ADD FOREIGN KEY (essn) REFERENCES employee(ssn);
