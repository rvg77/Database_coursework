create or replace function make_log()
  returns trigger as $$
begin
  if (TG_OP = 'DELETE')
  THEN
    INSERT INTO "log" SELECT
                        'D',
                        now(), old.*;
    RETURN OLD;
  ELSIF (TG_OP = 'UPDATE')
    THEN
      INSERT INTO "log" SELECT
                          'U',
                          now(), old.*;
      RETURN NEW;
  ELSIF (TG_OP = 'INSERT')
    THEN
      INSERT INTO "log" SELECT
                          'I',
                          now(), new.*;
      RETURN NEW;
  END IF;
  RETURN NULL;
end;
$$
language plpgsql;

create trigger logger
  after update or insert or delete
  on
    homework
  for each row execute procedure make_log();


create or replace function check_correct()
  returns trigger as $$
begin
  if new.deadline is not null and new.deadline < now()
  then
    raise exception 'invalid deadline';
  end if;
  if new.task_id not in (select task_id
                         from task)
  then
    raise exception 'invalid task_id';
  end if;
  if new.course_group_id not in (select course_group.course_group_id
                                 from course_group)
  then
    raise exception 'invalid task_id';
  end if;
  return new;
end;
$$
language plpgsql;

create trigger checker
  before insert
  on homework
  for each row execute procedure check_correct();

insert into homework (task_id, course_group_id, deadline, difficulty_level, comment) values
  (5, 30, timestamp '2020-01-01 00:00:00', 'impossible', 'you will die');