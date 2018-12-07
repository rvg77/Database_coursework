create or replace view teacher_info as
  select
    first_name,
    last_name,
    'hidden' as phone_number,
    email,
    qualification,
    work_experience,
    rating
  from teacher;

create or replace view student_info as
  select *
  from student;

create or replace view course_group_info as
  select *
  from course_group;

create or replace view group_info as
  select
    group_name,
    year_of_graduation,
    specialization
  from "group";

create or replace view subject_info as
  select
    title,
    rating,
    description
  from subject;

create or replace view task_info as
  select
    task_name,
    specification
  from task;

create or replace view homework_info as
  select *
  from homework;

create or replace view cute_student_info as
  select
    student.first_name,
    student.last_name,
    "group".group_name,
    'hidden' as phone_number,
    student.email,
    student.characterization
  from student
    inner join "group" on student.group_id = "group".group_id;

select * from cute_student_info;
create or replace view teachers_load as
  select
    teacher.first_name,
    teacher.last_name,
    count(course_group.group_id) as amount
  from teacher
    left join course_group on teacher.teacher_id = course_group.teacher_id
  group by teacher.first_name, teacher.last_name;