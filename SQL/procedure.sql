create or replace function number_of_deadlines(st_id int, date timestamp) --deadlines for student before date
  returns table(task varchar(1000), deadline timestamp) as
$$
  select
    task.specification,
    homework.deadline
  from "group"
    inner join student on student.group_id = "group".group_id
    inner join course_group on "group".group_id = course_group.group_id
    inner join homework on homework.course_group_id = course_group.course_group_id
    inner join task on task.task_id = homework.task_id
  where homework.deadline < date and student.student_id = st_id;
$$
language sql;

--task specification
select *
from number_of_deadlines(1, timestamp '2018-02-08 00:00:00') as nd;
