ALTER TABLE `courses` ADD COLUMN `teacher_name` VARCHAR(255) NOT NULL;
UPDATE `courses` SET `teacher_name` = (SELECT `name` FROM `users` WHERE `users`.`id` = `teacher_id`);
CREATE INDEX `course_teacher` ON `courses` (`teacher_name`);
