CREATE DATABASE ATTENDANCE;
USE ATTENDANCE;
CREATE TABLE INSTITUTE(
	ID INT PRIMARY KEY,
    INAME VARCHAR(20)
);
CREATE TABLE BRANCH(
	BID INT PRIMARY KEY,
    BNAME VARCHAR(20),
    HOD VARCHAR(20),
    ID INT,
    foreign key (ID) references INSTITUTE (ID)
);
CREATE TABLE BATCH(
	BAID INT PRIMARY KEY,
    BANAME VARCHAR(20),
    YEAR INT,
    BID INT,
    foreign key (BID) references BRANCH (BID)  
);
CREATE TABLE SECTION(
	SECID INT PRIMARY KEY,
    SECNAME VARCHAR(1),
    BAID INT,
    foreign key (BAID) references BATCH (BAID)  
);
CREATE TABLE FACULTY(
	FID INT PRIMARY KEY,
    FNAME VARCHAR(20),
    FREP VARCHAR(5),
    FPASS INT,
    BID INT,
    foreign key (BID) references BRANCH (BID)  
);
CREATE TABLE SUBJECT(
	SID INT PRIMARY KEY,
    SNAME VARCHAR(20),
    CREDIT INT,
    BAID INT,
    foreign key (BAID) references BATCH (BAID)  
);
CREATE TABLE TEACH(
	SID INT,
    foreign key (SID) references SUBJECT (SID),
    FID INT,
    foreign key (FID) references FACULTY (FID)
);
CREATE TABLE CLASS(
	CID INT PRIMARY KEY,
    SID INT,
    foreign key (SID) references SUBJECT (SID),
    FID INT,
    foreign key (FID) references FACULTY (FID),
    TIMESTAMP VARCHAR(30),
    STATUS BOOLEAN,
    secid INT,
	FOREIGN KEY (secid) REFERENCES section(secid)
);
CREATE TABLE STUDENT(
	PRN BIGINT PRIMARY KEY,
    SNAME VARCHAR(30),
    BID INT,
    foreign key (BID) references BRANCH (BID),
    BAID INT,
    foreign key (BAID) references BATCH (BAID)
);
CREATE TABLE ATTENDANCE(
	PRN BIGINT,
    foreign key (PRN) references STUDENT (PRN),
    CID INT,
    foreign key (CID) references CLASS (CID)
);
CREATE TABLE COURSE(
	SECID INT,
    foreign key (SECID) references SECTION (SECID),
    SID INT,
    foreign key (SID) references SUBJECT (SID),
    FID INT,
    foreign key (FID) references FACULTY (FID)
);

INSERT INTO INSTITUTE (ID,INAME) VALUE(1,'SIT');

INSERT INTO BRANCH (BID,BNAME,HOD,ID) VALUE (1,'CSE','DEEPALI VORA',1);

INSERT INTO BATCH (BAID, BANAME, YEAR, BID) VALUE (1,'SY',2, 1);

INSERT INTO SECTION (SECID, SECNAME, BAID) VALUES
(1, 'A', 1),
(2, 'B', 1),
(3, 'C', 1);

INSERT INTO FACULTY (FID, FNAME, FREP, FPASS, BID) VALUES
(1, 'SONALI KOTHARI', 'SNK',1234,1);

INSERT INTO SUBJECT (SID, SNAME, CREDIT, BAID) VALUES
(1,'OOPS',4,1);

INSERT INTO STUDENT (PRN, SNAME, BID, BAID) VALUES
(22070122085, 'Jahnvi Nair', 1, 1),
(22070122086, 'Janmejay Pandya', 1, 1),
(22070122087, 'Jay Trivedi', 1, 1),
(22070122088, 'Jay Gondaliya', 1, 1),
(22070122089, 'Josh Dagla', 1, 1),
(22070122091, 'K Rishik Kumar Reddy', 1, 1),
(22070122092, 'Kacho Muneeb Khan', 1, 1),
(22070122093, 'Ayushi Kapgate', 1, 1),
(22070122094, 'Kashish Kabra', 1, 1),
(22070122095, 'Kasibhatta Suprabhat', 1, 1),
(22070122096, 'Kasturi Sangale', 1, 1),
(22070122097, 'Kshitij Gurbaxani', 1, 1),
(22070122098, 'Kevin Tandon', 1, 1),
(22070122099, 'Kewal Nanavati', 1, 1),
(22070122101, 'Aryan Kore', 1, 1),
(22070122102, 'Krish Panchal', 1, 1),
(22070122103, 'Kush Deo Shukla', 1, 1),
(22070122104, 'Lahitanshu Das', 1, 1),
(22070122105, 'Mahika Mathur', 1, 1),
(22070122106, 'Malvika Bhadoriya', 1, 1),
(22070122107, 'Manan Bhimjiyani', 1, 1),
(22070122108, 'Manas Dhanpawde', 1, 1),
(22070122109, 'Manas Jain', 1, 1),
(22070122112, 'Manya Khullar', 1, 1),
(22070122113, 'Manya Lamba', 1, 1),
(22070122114, 'Manraj Gandhi', 1, 1),
(22070122115, 'Mayank Sahai', 1, 1),
(22070122116, 'Maryam Bahlooli', 1, 1),
(22070122117, 'Megha Beria', 1, 1),
(22070122118, 'Dhairya Mehra', 1, 1),
(22070122119, 'Sachin Mhetre', 1, 1),
(22070122120, 'Mihir Hebalkar', 1, 1),
(22070122121, 'Mishka Gupta', 1, 1),
(22070122123, 'Mayank Mohabey', 1, 1),
(22070122125, 'Mohd Hamza Abbasi', 1, 1),
(22070122126, 'Moksh Oswal', 1, 1),
(22070122128, 'Mradul Shukla', 1, 1),
(22070122130, 'Nakul Kushwaha', 1, 1),
(22070122131, 'Navani Pendse', 1, 1),
(22070122132, 'Nikunj Maheshwari', 1, 1),
(22070122133, 'Netra Jain', 1, 1),
(22070122135, 'Omkar Prabhakar', 1, 1),
(22070122136, 'Onkar Mendhapurkar', 1, 1),
(22070122138, 'Parimal Kulkarni', 1, 1),
(22070122140, 'Aarya Patil', 1, 1),
(22070122141, 'Patoliya Shyam Gopal', 1, 1),
(22070122142, 'Pema Rinchen', 1, 1),
(22070122143, 'Piyush Maan', 1, 1),
(22070122144, 'Piyush Pareek', 1, 1),
(22070122145, 'Peeyush Kumar', 1, 1),
(22070122147, 'Prabhat Shankar', 1, 1),
(22070122148, 'Pramit Sharma', 1, 1),
(22070122151, 'Pranav Jadhav', 1, 1),
(22070122152, 'Pranav Suri', 1, 1),
(22070122153, 'Pranav Mahajan', 1, 1),
(22070122154, 'Pranay Vasoya', 1, 1),
(22070122155, 'Praneet Mahendrakar', 1, 1),
(22070122156, 'Pranshu Gupta', 1, 1),
(22070122157, 'Priyanka Gupta', 1, 1),
(22070122159, 'Priyanshi Bhargava', 1, 1),
(22070122160, 'Prishita Rayapura', 1, 1),
(22070122162, 'Atharv Raje', 1, 1),
(22070122164, 'Rish Dias', 1, 1),
(22070122165, 'Ritam Mishra', 1, 1),
(22070122166, 'Ritvik Reddy', 1, 1),
(22070122167, 'Ruhani Rai Dhamija', 1, 1),
(22070122168, 'Rutu Bhanderi', 1, 1),
(22070122171, 'R Yogesh', 1, 1),
(22070122173, 'Devvrat Saini', 1, 1),
(22070122176, 'Samidha Manjrekar', 1, 1),
(22070122177, 'Samruddhi Borhade', 1, 1),
(23070122507, 'Madhura Aher', 1, 1),
(23070122508, 'Mayank Verma', 1, 1),
(23070122509, 'Pavin R', 1, 1),
(23070122510, 'Riya Mude', 1, 1),
(23070122515, 'Het Shah', 1, 1),
(23070122516, 'Anushka Hegade', 1, 1);

INSERT INTO COURSE (SECID,SID,FID) VALUE
(2,1,1);
select * from attendance;
select * from class;