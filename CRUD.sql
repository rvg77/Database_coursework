select distinct task_id
from homework
where difficulty_level = 'easy';

insert into homework (task_id, course_group_id, max_size_of_team, deadline, difficulty_level, comment)
values (3, 10, 1, timestamp '2018-04-07 00:00:00', 'hard', 'you can cheat');

update homework
set deadline = timestamp '2018-03-07 00:00:00'
where task_id = 5;

DELETE FROM homework
WHERE difficulty_level <> 'easy';
