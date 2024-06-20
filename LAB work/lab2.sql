create database university
use university;

9->
create table Department(
dept_name varchar(50) primary key,
building varchar(1),
budget int(10)
);
insert into Department values('cse','A',50000);
insert into Department values('ai','B',10000);


create table Student(
ID int(3) primary key,
name varchar(50),
dept_name varchar(50),
totcred int(3)
);
alter table Student add constraint Student_dept_name_fk foreign key(dept_name) references Department(dept_name) on delete cascade;
insert into Student values(001,'sajan shrestha','cse',22);
insert into Student values(002,'devraj silwal','ai',22);
insert into Student values(003,'abhishek khadka','cse',22);
insert into student values(004,'rahul dhakal','cse',24);
select name,dept_name from Student;


10->
create table Instructor(
ID int(3) primary key,
name varchar(50),
dept_name varchar(50),
salary int(10)
);
alter table Instructor add constraint Instructor_dept_name_fk foreign key(dept_name) references Department(dept_name) on delete cascade;
insert into Instructor values(001,'napalaxmi','cse',100000);
insert into Instructor values(002,'gururaj','ai',100000);
insert into Instructor values(003,'sajan','cse',50000);
insert into Instructor values(004,'chiran','ai',1000);

select * from Instructor where dept_name='cse'




11->
create table Course(
Course_id int(3) primary key,
title varchar(50),
dept_name varchar(50),
credits int(3)
);
alter table Course add constraint Course_dept_name_fk foreign key(dept_name) references Department(dept_name) on delete cascade;
insert into Course values(001,'daa','cse',4);
insert into Course values(002,'coa','cse',3);
insert into Course values(003,'math','ai',4);
insert into course values(004,'opted','cse',5);
select title from Course where credits=3;


12->
create table Section(
course_id int(3),
section_id varchar(1),
semester int(1),
year int(4),
building varchar(2),
room_number int(3),
time_slot_id varchar(5)
);
alter table Section add constraint Section_pk primary key(course_id,section_id,semester,year);
alter table Section add constraint Section_course_id_fk foreign key(course_id) references Course(course_id) on delete cascade;
insert into Section values(001,'A',1,2023,'A1',204,100)
insert into section values(002,'B',2,2022,'A2',203,101)
insert into section values(003,'C',3,2024,'A3',206,102)
insert into section values(004,'D',4,2015,'A4',303,103)
create table Takes(
ID int(3),
course_id int(3),
section_id varchar(1),
semester int(1),
year int(4),
grade int(2)
);
alter table Takes add constraint Takes_pk primary key(ID,course_id,section_id,semester,year);
alter table Takes add constraint Takes_id_fk foreign key (ID) references Student(ID) on delete cascade;
alter table Takes add constraint Takes__course_id_fk foreign key(course_id) references Course(course_id) on delete cascade;
alter table Takes add constraint Takes_section_id foreign key(course_id,section_id,semester,year) references Section(course_id,section_id,semester,year) on delete cascade;
insert into Takes values (001,001,'A',1,2023,9);
insert into Takes values(001,002,'B',2,2022,9.0);
insert into Takes values(001,003,'C',3,2024,8.0);
insert into Takes values(004,004,'D',4,2015,9.0);
select Takes.course_id,Course.title from Takes join Course on Takes.course_id=Course.course_id where id=1;



13->
select * from Instructor where salary>40000 and salary<90000;


14->
CREATE TABLE Teach (
    id int(3),
    course_id int(3),
    section_id VARCHAR(1),
    semester int(1),
    year int(4)
);

alter table Teach add constraint Teaches_pk primary key(id,course_id,section_id,semester,year);
alter table Teach add constraint Teaches_id_fk foreign key(id) references Instructor(id) on delete cascade;
alter table teach add constraint Teaches_section_id_fk foreign key(course_id,section_id,semester,year) references section(course_id,section_id,semester,year) on delete cascade;
insert into teach values(1,1,'A',1,2023);
insert into teach values(2,2,'B',2,2022);


select instructor.id from instructor EXCEPT select instructor.id from instructor join teach on instructor.id=teach.id;


15->
select student.name,course.title,takes.year
from takes
join student on takes.id=student.id
join course on course.course_id=takes.course_id
join section on section.course_id=takes.course_id and section.section_id=takes.section_id and section.semester=takes.semester and section.year=takes.year
where section.room_number=203;


16->

select student.name,course.course_id,course.title as c_name
from takes
join student on takes.id=student.id
join course on takes.course_id=course.course_id
where course.title='opted' and takes.year=2015


17->
select name,salary as inst_salary 
from instructor
where instructor.salary >(select MIN(instructor.salary) from instructor where instructor.dept_name='cse')




18->
select * 
from instructor as ins
where ins.name like 'ch%'




19->
select student.name ,length(student.name)
from student




20->
select dept_name,substring(dept_name,3,4) from department



21->
select upper(name) as name from instructor




22->

insert into student values(5,'ashim','ai',NULL)
update student set totcred=coalesce(totcred,0)



23->
select salary,round(salary/3) from instructor
select salary,round(salary/3,-2) from instructor

24->
alter table instructor add column DOB date
update instructor set DOB='2000-04-15' where id=2
update instructor set DOB='1999-01-20' where id=3
update instructor set DOB='2010-04-23' where id=4
select concat(date_format(DOB,'%d-'),monthname(DOB),date_format(DOB,'-%Y')) as DOB from instructor;
select concat(date_format(DOB,'%d-'),monthname(DOB),date_format(DOB,'-%y')) as DOB from instructor;
select date_format(DOB,'%d-%m-%y') as date_of_bith from instructor



25->
select name,date_format(DOB,'%D-%M-%Y') as DOB from instructor


26->

select name,DAYNAME(DOB) as DOB_day from instructor


27->
select name,monthname(DOB) as DOB_month from instructor


28->
select name,dayname(DOB) as DOB_day,dayname(last_day(DOB)) as last_day_of_month from instructor




29->
select name,round(datediff(now(),DOB)/365) as age from instructor



30->
select name,date_add(date_add(DOB,interval 60 year), interval (7-dayofweek(date_add(DOB, interval 60 year))) day ) as 60th_birthday_saturday from instructor



31->
select * from instructor where year(DOB)=&x


32->
select * from instructor where &x<year(DOB) and year(DOB)<&y




33->
select * from instructor where (year(DOB)+60)<&x




select * from student
select * from course
select * from instructor
select * from section
select * from instructor


























































