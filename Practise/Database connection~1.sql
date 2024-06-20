use mydatabase
drop table main_foreign_person

create table main_foreign_person(
id int primary key,
name varchar(50),
year int(3),
credit int(3));

select * from main_person
select * from main_foreign_person
describe main_person


insert into main_foreign_person values(1,'cse',3,40)
insert into main_foreign_person values(2,'ai',4,50)
insert into main_foreign_person values(3,'cyber',5,20)

insert into main_person (age,level_id,name) values(18,'cse','sajan');
insert into main_person (age,level_id,name) values(18,'ai','devraj');
insert into main_person (age,level_id,name) values(18,'cyber','abhishek');

select * from main_user_model


class user_model(models.Model):
    firstname = models.CharField(max_length=50)
    lastname=models.CharField(max_length=50)
    email=models.EmailField()
    password1=models.CharField(max_length=20)
    password2=models.CharField(max_length=20)
    username=models.CharField(max_length=30,default='')
    
    
    
    
     
drop table main_user_model
create table main_user_model(
    id int auto_increment primary key,
    firstname varchar(50),
    lastname varchar(50),
    password1 varchar(20),
    password2 varchar(20),
    username varchar(30));
    
alter table main_user_model add (password varchar(1000))
    
    
    
select * from main_user_model
    