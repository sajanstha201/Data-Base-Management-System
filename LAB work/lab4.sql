create database salil
drop database salil
use university
select * from student
select * from takes
select * from instructor
select * from teach
select * from section
14-> 
select * 
from student
where not exists(
select teach.course_id from teach where teach.id in(select instructor.id from instructor where instructor.dept_name='cse')
EXCEPT
select takes.course_id from takes where student.id=takes.id)


insert into teach values(1,1,'A',1,2009)
insert into teach values(1,2,'B',1,2009)
insert into section values(2,'B',1,2009,'B3',400,10)
15->
select course_id,count(*) as n
from teach
where to_char(teach.year,'YYYY')='2009'
group by teach.course_id
having n=1

16->
select takes.id,count(*) as course_taken
from takes 
where takes.course_id in(
select distinct(teach.course_id) from teach
where teach.id in (select instructor.id from instructor 
where instructor.dept_name='cse'))
group by takes.id
having course_taken>=2


select * from department

17->
select t.dept_name
from (select dept_name as dept_name ,avg(salary) as av from instructor group by dept_name) as t
where t.av>42000


18->

create view all_course as
select course_id,building,room_number
from section
where section.course_id in(select course_id from teach where teach.id in (select id from instructor where dept_name='cse'and year='2009'));

select * from all_course


19->
select distinct(title)
from course,all_course
where course.course_id=all_course.course_id

20->
create view department_total_salary as
select dept_name,sum(salary)
from instructor
group by dept_name

select * from department_total_salary














<------------STARTING------------>



1->

select course_id,count(*) as no_of_student
from takes
group by course_id


2->

select dept_name
from student
group by dept_name
having count(*)>2


3->
select dept_name, count(*)as no_of_course
from course
group by dept_name

4->
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg_salary>42000
  


5->
select section_id,count(*) as no_of_enrolment
from takes
where year=2009
group by section_id


6->
select title
from course
order by title asc


7->
select name,salary
from instructor
order by salary desc


8->
select dept_total.dept_name as max_total_salary_dept
from(select dept_name,sum(salary) as total_salary
    from instructor
    group by dept_name) as dept_total
where dept_total.total_salary >=all(select sum(salary) from instructor group by dept_name)

9->
select avg(dept_avg.salary) as avg_salary
from (select avg(salary) as salary from instructor group by dept_name having salary>42000) as dept_avg


10->
select section_enrolment.section_id as max_enrolment_section,section_enrolment.no_of_student
from(select section_id,count(*) as no_of_student
from section
where year='2009'
group by section_id) as section_enrolment
where section_enrolment.no_of_student=(
select max(section_en.no_of_student) 
from (select count(*) as no_of_student
from section 
where year='2009' 
group by section_id) as section_en)



11->

select *
from instructor
where not exists(
select course_id,section_id,semester,year
from takes
where takes.id=instructor.id
EXCEPT
select course_id,section_id,semester,year
from takes
where takes.id in (select id from student where dept_name='cse')
)




12->
select dept_name, avg(salary)
from instructor
where dept_name in
(select dept_name
from instructor
group by dept_name
having avg(salary)>50000 and count(*)>1)
group by dept_name





13->
with max_dept_bud as
(select max(budget) as bud from department)
select dept_name,budget
from department
join max_dept_bud
where department.budget=max_dept_bud.bud


14->

with dept_total as
(select dept_name,sum(salary) as total_salary
from instructor
group by dept_name)
select dept_name
from dept_total
where dept_total.total_salary>(select avg(total_salary) from dept_total)


15->

savepoint s1;
update student set dept_name='cse' where id=4
select * from student
rollback
commit

16->
savepoint s2;
update instructor set salary=1.03*salary where salary>100000
update instructor set salary=1.05*salary where salary<=100000
rollback
commit



select * from department
select * from course
select * from student
select * from takes
select * from instructor
select * from teach
select * from section














