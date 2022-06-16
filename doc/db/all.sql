drop table if exists `chapter`;
create table `chapter` (
   `id` char(8) not null comment 'ID',
   `course_id` char(8) comment 'CourseID',
   `name` varchar(50) comment 'Name',
   primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='Chapter';

insert into `chapter` (id, course_id, name) values ('00000000', '00000000', 'Chapter-Test1');
insert into `chapter` (id, course_id, name) values ('00000001', '00000001', 'Chapter-Test2');
insert into `chapter` (id, course_id, name) values ('00000002', '00000002', 'Chapter-Test3');
insert into `chapter` (id, course_id, name) values ('00000003', '00000003', 'Chapter-Test4');
insert into `chapter` (id, course_id, name) values ('00000004', '00000004', 'Chapter-Test5');
insert into `chapter` (id, course_id, name) values ('00000005', '00000005', 'Chapter-Test6');
insert into `chapter` (id, course_id, name) values ('00000006', '00000006', 'Chapter-Test7');
insert into `chapter` (id, course_id, name) values ('00000007', '00000007', 'Chapter-Test8');
insert into `chapter` (id, course_id, name) values ('00000008', '00000008', 'Chapter-Test9');
insert into `chapter` (id, course_id, name) values ('00000009', '00000009', 'Chapter-Test10');
insert into `chapter` (id, course_id, name) values ('00000010', '00000010', 'Chapter-Test11');

# ---------------------- 测试

drop table if exists `test`;
create table `test` (
    `id` char(8) not null default '' comment 'id',
    `name` varchar(50) comment '名称',
     primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='测试';

insert into `test` (id, name) values (1, '测试');
insert into `test` (id, name) values (2, '测试2');