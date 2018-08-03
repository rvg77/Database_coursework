--для студента узнать количество уже прошедших дедлайнов
select
  subject.title,
  count(*)
from
  student
  inner join "group" on student.group_id = "group".group_id
  inner join course_group on "group".group_id = course_group.group_id
  inner join homework on course_group.course_group_id = homework.course_group_id
  inner join subject on course_group.subject_id = subject.subject_id
where homework.deadline < now() and student.student_id = 10
group by subject.title;

--вывести группы в порядке везучести с перподавателем по данному предмету(если понимаешь что хочешь перевестись в другую группу)
select
  "group".group_name,
  teacher.first_name,
  teacher.last_name,
  teacher.rating
from teacher
  inner join course_group on course_group.teacher_id = teacher.teacher_id
  inner join "group" on "group".group_id = course_group.group_id
where course_group.subject_id = 2
order by teacher.rating desc;

--вывести среднюю жопу по предмету для студента
select first_name, last_name, avg(number_of_deadlinees)
from (select
        student.first_name as first_name,
        student.last_name as last_name,
        count(*) as number_of_deadlinees
      from student
        inner join "group" on student.group_id = "group".group_id
        inner join course_group on "group".group_id = course_group.group_id
        inner join homework on course_group.course_group_id = homework.course_group_id
        inner join subject on course_group.subject_id = subject.subject_id
        inner join task on homework.task_id = task.task_id
      where student.student_id = 10
      group by student.student_id, student.first_name, student.last_name, subject.subject_id) as q group by first_name, last_name;

--самый близкий дедлайн для студента
neverselect
  student.first_name,
  student.last_name,
  min(deadline)
from student
  inner join "group" on student.group_id = "group".group_id
  inner join course_group on "group".group_id = course_group.group_id
  inner join homework on course_group.course_group_id = homework.course_group_id
  inner join subject on course_group.subject_id = subject.subject_id
  inner join task on homework.task_id = task.task_id
where student.student_id = 10 and deadline > now()
group by student.student_id, student.first_name, student.last_name;

--вывести текущую ситуацию для студента
select
  subject.title,
  student.first_name,
  student.last_name,
  count(*) as number_of_deadlinees
from student
  inner join "group" on student.group_id = "group".group_id
  inner join course_group on "group".group_id = course_group.group_id
  inner join homework on course_group.course_group_id = homework.course_group_id
  inner join subject on course_group.subject_id = subject.subject_id
  inner join task on homework.task_id = task.task_id
where student.student_id = 10
group by student.student_id, student.first_name, student.last_name, subject.subject_id;
