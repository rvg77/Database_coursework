create table if not exists teacher
(
  teacher_id      serial primary key,
  first_name      varchar(30) not null,
  last_name       varchar(30) not null,
  phone_number    varchar(16),
  email           varchar(30),
  qualification   varchar(100),
  work_experience integer,
  rating          integer
);

create table if not exists subject
(
  subject_id  serial primary key,
  title       varchar(30) not null,
  rating      integer,
  description varchar(200)
);

create table if not exists task
(
  task_id       serial primary key,
  task_name     varchar(30)   not null default 'NO NAME',
  specification varchar(1000) not null default 'NO NAME'
);

create table if not exists "group"
(
  group_id           serial primary key,
  group_name         varchar(30) not null,
  year_of_graduation integer     not null,
  specialization     varchar(30)
);

create table if not exists student
(
  student_id       serial primary key,
  group_id         integer     not null references "group" (group_id),
  first_name       varchar(30) not null,
  last_name        varchar(30) not null,
  phone_number     varchar(16),
  email            varchar(30),
  characterization varchar(200)
);

create table if not exists course_group
(
  course_group_id      serial primary key,
  teacher_id           integer not null references teacher (teacher_id),
  group_id             integer not null references "group" (group_id),
  subject_id           integer not null references subject (subject_id),
  academic_performance varchar(30),
  unique (teacher_id, group_id, subject_id)
);

create table if not exists homework
(
  task_id          integer references task (task_id),
  course_group_id  integer references course_group (course_group_id),
  max_size_of_team integer default 1,
  deadline         timestamp(0),
  difficulty_level varchar(30),
  "comment"        varchar(200),
  primary key (task_id, course_group_id)
);

create table if not exists log (
  operation char(1) not null,
  stamp timestamp not null,
  task_id          integer references task (task_id),
  course_group_id  integer references course_group (course_group_id),
  max_size_of_team integer default 1,
  deadline         timestamp(0),
  difficulty_level varchar(30),
  "comment"        varchar(200)
)