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

CREATE TABLE abin
(
	binno int NOT NULL,
    wcode varchar(15) NOT NULL,
	capacity int,
	PRIMARY KEY (binno, wcode)
);

CREATE TABLE batch
(
	batchno int NOT NULL,
	datein varchar(10) NOT NULL,
	size int,
    binno int NOT NULL,
	wcode varchar(15) NOT NULL,
	PRIMARY KEY (batchno)
);

ALTER TABLE part
	ADD FOREIGN KEY (empno) REFERENCES manager(empno);

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

ALTER TABLE abin
	ADD FOREIGN KEY (wcode) REFERENCES warehouse(wcode);

ALTER TABLE batch
	ADD FOREIGN KEY (binno,wcode) REFERENCES abin(binno,wcode);
