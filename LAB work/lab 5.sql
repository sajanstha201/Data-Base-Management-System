
create database employee
use employee

create table depts(
name varchar(50),
dept_number int(3),
manages_ssn int(3),
manages_start_date date,
primary key(name)
);
alter table depts add constraint  foreign key(manages_ssn) references emps(ssn);
alter table depts modify column manages_ssn int(3) default null

insert into depts values('marketing',1,1,'2022-01-01')
insert into depts values('data science',2,2,'2021-01-01')
insert into depts values('computing',3,3,'2020-01-01')
insert into depts (name,dept_number) values('research',4)
update depts set manages_ssn=4,manages_start_date='2000-01-01' where dept_number=4


create table department_location(
name varchar(50),
location varchar(50),
primary key(name,location),
foreign  key(name) references depts(name) on delete cascade);


create table emps(
ssn int(3),
bdate date,
fname varchar(50),
minit varchar(50),
lname varchar(50),
address varchar(50),
salary int(10),
sex varchar(1),
supervisor int(3) default(null),
dept_name varchar(50),
manage_dept_name varchar(50) default(null),
check(sex in('M','F')),
primary key(ssn)
);
alter table emps add constraint fk_snn foreign key(supervisor) references emps(ssn);
alter table emps add constraint fk_manage_dept_name foreign key(manage_dept_name) references depts(name) on delete cascade;
alter table emps add constraint fk_name foreign key(dept_name) references depts(name);


insert into emps values(1,'2000-01-01','sajan','kumar','shrestha','nepal',1000000,'M',null,'data science','data science');
insert into emps values(2,'2000-01-01','deeo','kumar','shrestha','nepal',1000000,'M',null,'marketing','marketing');
insert into emps values(3,'2000-01-01','sssn','kumar','shrestha','nepal',1000000,'M',null,'computing','computing');
insert into emps values(4,'2000-01-01','John','B','Smith','banglore',20000,'M',null,'research','research');

insert into emps values(5,'2000-01-01','devraj','kumar','shrestha','nepal',1000000,'M',null,'data science','data science');

update emps set supervisor=1 where ssn>=2



create table projects(
name varchar(50),
num int(3),
location varchar(50),
dept_name varchar(50),
foreign key(dept_name) references depts(name),
primary key(name,num)
);
insert into projects values('diwali',1,'banglore','marketing')
insert into projects values('company stock prediction',2,'manglore','data science')
insert into projects values('company analysis',3,'banglore','data science')
insert into projects values('lient',5,'Stanford','research')

create table works_on(
ssn int(3),
project_name varchar(50),
project_number int(3),
hours int(3),
primary key(ssn,project_name,project_number),
foreign key(ssn) references emps(ssn),
foreign key(project_name,project_number) references  projects(name,num));

insert into works_on values(1,'diwali',1,24)
insert into works_on values(2,'company analysis',3,20)
insert into works_on values(1,'company stock prediction',2,12)
insert into works_on values(4,'diwali',1,90)
insert into works_on values(5,'diwali',1,2)
insert into works_on values(1,'lient',5,23)

create table dependent(
ssn int(3),
name varchar(50),
sex varchar(1),
birth_date date,
relationship varchar(50),
primary key (ssn,name),
foreign key(ssn) references emps(ssn),
check(sex in('M','F'))
);

insert into dependent values(1,'sajan','M','2000-4-03','friend')
insert into dependent values(2,'devraj','M','2004-01-16','close friend')
insert into dependent values(3,'rahul','M','2000-9-9','family memeber')


select * from emps
select * from depts




1->
select bdate,address 
from emps
where fname='John' and minit='B' and lname='Smith'


select name,address
from emps,depts
where emps.dept_name=depts.name and emps.dept_name='research'



2->

select projects.num,depts.dept_number,emps.lname,emps.address,emps.bdate
from projects
join depts on depts.name=projects.dept_name
join emps on emps.ssn=depts.manages_ssn
where projects.location='Stanford'



3->
select e.fname,e.lname,s.fname,s.lname
from emps as e,emps as s
where e.supervisor=s.ssn



4->
select works_on.project_number
from works_on,emps
where works_on.ssn=emps.ssn and emps.lname='Smith'

5->
select emps.fname,emps.salary
from emps,works_on
where emps.ssn=works_on.ssn and works_on.project_name='diwali'

with s (ssn) as(
select emps.ssn
from works_on,emps
where works_on.project_name='diwali' and works_on.ssn=emps.ssn)
update emps 
set salary=salary*1.1 
where emps.ssn in (select * from s)

select emps.fname,emps.salary
from emps,works_on
where emps.ssn=works_on.ssn and works_on.project_name='diwali'




6->
select emps.fname,emps.lname,works_on.project_name,emps.dept_name
from emps,works_on
where emps.ssn=works_on.ssn
order by emps.dept_name asc,emps.lname asc


7->
select emps.fname
from emps
join dependent on emps.ssn=dependent.ssn
where emps.fname=dependent.name and emps.sex=dependent.sex


8->
select emps.fname
from emps 
where not exists(select * from dependent where dependent.ssn=emps.ssn)

9->
select * 
from emps
where emps.manage_dept_name is not null and exists(select * from dependent where dependent.ssn=emps.ssn)

10->
select sum(salary) as sum,max(salary) as max,min(salary) as min, avg(salary) as avg
from emps

11->
select projects.name,projects.num,count(*) as number_of_emp
from emps
join works_on on emps.ssn=works_on.ssn
join projects on works_on.project_number=projects.num
group by projects.name,projects.num

12->
select projects.name,projects.num,count(*) as number_of_emp
from emps
join works_on on emps.ssn=works_on.ssn
join projects on works_on.project_number=projects.num
group by projects.name,projects.num
having count(*) >2


13->

select depts.name,depts.dept_number
from emps
join depts on emps.dept_name=depts.name
where emps.salary>40000
group by depts.name,depts.dept_number
having count(*)>1


additional question
1->

select *
from emps
where not exists(
select projects.name from projects where projects.dept_name='research'
EXCEPT
select works_on.project_name from works_on where works_on.ssn=emps.ssn)

2->
select * 
from emps
where emps.salary>some(select salary from emps where emps.dept_name='research')


3->
select works_on.project_name,count(*) as total_emp
from works_on
where works_on.project_name='lient'



describe projects
describe works_on
select * from works_on
select * from emps
select * from works_on
select * from depts
select * from projects







