-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Account` (
  `email_address` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `display_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`email_address`),
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  UNIQUE INDEX `display_name_UNIQUE` (`display_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student` (
  `student_id` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE,
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  CONSTRAINT `studentmail`
    FOREIGN KEY (`email_address`)
    REFERENCES `mydb`.`Account` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Department` (
  `dept_num` INT NOT NULL,
  PRIMARY KEY (`dept_num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `Professor_id` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `hired_by` INT NOT NULL,
  PRIMARY KEY (`Professor_id`),
  UNIQUE INDEX `Professor_id_UNIQUE` (`Professor_id` ASC) VISIBLE,
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  INDEX `prohireby_idx` (`hired_by` ASC) VISIBLE,
  CONSTRAINT `professormail`
    FOREIGN KEY (`email_address`)
    REFERENCES `mydb`.`Account` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prohireby`
    FOREIGN KEY (`hired_by`)
    REFERENCES `mydb`.`Department` (`dept_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `Staff_id` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `hired_by` INT NOT NULL,
  PRIMARY KEY (`Staff_id`),
  UNIQUE INDEX `Staff_id_UNIQUE` (`Staff_id` ASC) VISIBLE,
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  INDEX `staffhireby_idx` (`hired_by` ASC) VISIBLE,
  CONSTRAINT `staffmail`
    FOREIGN KEY (`email_address`)
    REFERENCES `mydb`.`Account` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staffhireby`
    FOREIGN KEY (`hired_by`)
    REFERENCES `mydb`.`Department` (`dept_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Program`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Program` (
  `program_id` VARCHAR(45) NOT NULL,
  `belong to` INT NULL,
  PRIMARY KEY (`program_id`),
  INDEX `programbelongto_idx` (`belong to` ASC) VISIBLE,
  CONSTRAINT `programbelongto`
    FOREIGN KEY (`belong to`)
    REFERENCES `mydb`.`Department` (`dept_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Major` (
  `Major_id` VARCHAR(45) NOT NULL,
  `stu_id` VARCHAR(45) NOT NULL,
  `dep_id` INT NOT NULL,
  PRIMARY KEY (`Major_id`),
  INDEX `majorstuid_idx` (`stu_id` ASC) VISIBLE,
  INDEX `majordeptnum_idx` (`dep_id` ASC) VISIBLE,
  CONSTRAINT `majorstuid`
    FOREIGN KEY (`stu_id`)
    REFERENCES `mydb`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `majordeptnum`
    FOREIGN KEY (`dep_id`)
    REFERENCES `mydb`.`Department` (`dept_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pursue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pursue` (
  `pursue_id` VARCHAR(45) NOT NULL,
  `major_id` VARCHAR(45) NOT NULL,
  `program_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pursue_id`),
  INDEX `pursuemajorid_idx` (`major_id` ASC) VISIBLE,
  INDEX `pursueprogramid_idx` (`program_id` ASC) VISIBLE,
  CONSTRAINT `pursuemajorid`
    FOREIGN KEY (`major_id`)
    REFERENCES `mydb`.`Major` (`Major_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pursueprogramid`
    FOREIGN KEY (`program_id`)
    REFERENCES `mydb`.`Program` (`program_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Course` (
  `Course_id` VARCHAR(45) NOT NULL,
  `dept_num` INT NOT NULL,
  PRIMARY KEY (`Course_id`),
  INDEX `coursedeptnum_idx` (`dept_num` ASC) VISIBLE,
  CONSTRAINT `coursedeptnum`
    FOREIGN KEY (`dept_num`)
    REFERENCES `mydb`.`Department` (`dept_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Semester` (
  `year_season` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`year_season`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Open`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Open` (
  `open_id` VARCHAR(45) NOT NULL,
  `year_season` VARCHAR(45) NOT NULL,
  `course_id` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  `Instructor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`open_id`),
  INDEX `opencourseid_idx` (`course_id` ASC) VISIBLE,
  INDEX `openyear_idx` (`year_season` ASC) VISIBLE,
  INDEX `openinstructor_idx` (`Instructor` ASC) VISIBLE,
  CONSTRAINT `opencourseid`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`Course` (`Course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `openyear`
    FOREIGN KEY (`year_season`)
    REFERENCES `mydb`.`Semester` (`year_season`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `openinstructor`
    FOREIGN KEY (`Instructor`)
    REFERENCES `mydb`.`Professor` (`Professor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TA` (
  `ta_id` VARCHAR(45) NOT NULL,
  `open_courseid` VARCHAR(45) NOT NULL,
  `student_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ta_id`),
  INDEX `tacourse_idx` (`open_courseid` ASC) VISIBLE,
  INDEX `tastuid_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `tacourse`
    FOREIGN KEY (`open_courseid`)
    REFERENCES `mydb`.`Open` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tastuid`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prerequisite` (
  `pre_id` VARCHAR(45) NOT NULL,
  `course_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pre_id`),
  INDEX `prerequisitecourseid_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `prerequisitecourseid`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`Course` (`Course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Register`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Register` (
  `register_id` VARCHAR(45) NOT NULL,
  `student_id` VARCHAR(45) NOT NULL,
  `year_season` VARCHAR(45) NOT NULL,
  `dept_num` INT NOT NULL,
  PRIMARY KEY (`register_id`),
  INDEX `registuid_idx` (`student_id` ASC) VISIBLE,
  INDEX `regiyear_idx` (`year_season` ASC) VISIBLE,
  INDEX `regideptnum_idx` (`dept_num` ASC) VISIBLE,
  CONSTRAINT `registuid`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`Student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `regiyear`
    FOREIGN KEY (`year_season`)
    REFERENCES `mydb`.`Semester` (`year_season`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `regideptnum`
    FOREIGN KEY (`dept_num`)
    REFERENCES `mydb`.`Department` (`dept_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Enroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Enroll` (
  `Enroll_id` VARCHAR(45) NOT NULL,
  `register_id` VARCHAR(45) NOT NULL,
  `open_id` VARCHAR(45) NOT NULL,
  `Grade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Enroll_id`),
  INDEX `enrollregiid_idx` (`register_id` ASC) VISIBLE,
  INDEX `emrollopenid_idx` (`open_id` ASC) VISIBLE,
  CONSTRAINT `enrollregiid`
    FOREIGN KEY (`register_id`)
    REFERENCES `mydb`.`Register` (`register_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `emrollopenid`
    FOREIGN KEY (`open_id`)
    REFERENCES `mydb`.`Open` (`open_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Post` (
  `post_id` VARCHAR(45) NOT NULL,
  `enroll_id` VARCHAR(45) NOT NULL,
  `feedback` VARCHAR(45) NOT NULL,
  `open_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `postenrollid_idx` (`enroll_id` ASC) VISIBLE,
  INDEX `postopenid_idx` (`open_id` ASC) VISIBLE,
  CONSTRAINT `postenrollid`
    FOREIGN KEY (`enroll_id`)
    REFERENCES `mydb`.`Enroll` (`Enroll_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `postopenid`
    FOREIGN KEY (`open_id`)
    REFERENCES `mydb`.`Open` (`open_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exam` (
  `Exam_id` VARCHAR(45) NOT NULL,
  `open_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Exam_id`),
  INDEX `examopenid_idx` (`open_id` ASC) VISIBLE,
  CONSTRAINT `examopenid`
    FOREIGN KEY (`open_id`)
    REFERENCES `mydb`.`Open` (`open_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Take`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Take` (
  `take_exam_id` VARCHAR(45) NOT NULL,
  `enroll_id` VARCHAR(45) NOT NULL,
  `exam_id` VARCHAR(45) NOT NULL,
  `letter_grade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`take_exam_id`),
  INDEX `takeexamenroll_idx` (`enroll_id` ASC) VISIBLE,
  INDEX `takeexamexamid_idx` (`exam_id` ASC) VISIBLE,
  CONSTRAINT `takeexamenroll`
    FOREIGN KEY (`enroll_id`)
    REFERENCES `mydb`.`Enroll` (`Enroll_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `takeexamexamid`
    FOREIGN KEY (`exam_id`)
    REFERENCES `mydb`.`Exam` (`Exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Problems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Problems` (
  `problem_id` VARCHAR(45) NOT NULL,
  `exam_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`problem_id`),
  INDEX `problemexamid_idx` (`exam_id` ASC) VISIBLE,
  CONSTRAINT `problemexamid`
    FOREIGN KEY (`exam_id`)
    REFERENCES `mydb`.`Exam` (`Exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Answer` (
  `ans_id` VARCHAR(45) NOT NULL,
  `take_exam_id` VARCHAR(45) NOT NULL,
  `problem_id` VARCHAR(45) NOT NULL,
  `score` INT NOT NULL,
  PRIMARY KEY (`ans_id`),
  INDEX `anstakeexamid_idx` (`take_exam_id` ASC) VISIBLE,
  INDEX `ansprobid_idx` (`problem_id` ASC) VISIBLE,
  CONSTRAINT `anstakeexamid`
    FOREIGN KEY (`take_exam_id`)
    REFERENCES `mydb`.`Take` (`take_exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ansprobid`
    FOREIGN KEY (`problem_id`)
    REFERENCES `mydb`.`Problems` (`problem_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book` (
  `ISBN` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `num of pages` INT NOT NULL,
  `public date` VARCHAR(45) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Author` (
  `Author_id` VARCHAR(45) NOT NULL,
  `author_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Write`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Write` (
  `write_id` VARCHAR(45) NOT NULL,
  `ISBN` VARCHAR(45) NOT NULL,
  `author_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`write_id`),
  INDEX `writeISBN_idx` (`ISBN` ASC) VISIBLE,
  INDEX `writeauthor_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `writeISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `writeauthor`
    FOREIGN KEY (`author_id`)
    REFERENCES `mydb`.`Author` (`Author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Library` (
  `Library_id` VARCHAR(45) NOT NULL,
  `physical_site` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Library_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Copies` (
  `copy_id` VARCHAR(45) NOT NULL,
  `ISBN` VARCHAR(45) NOT NULL,
  `library_id` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `purchase_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`copy_id`),
  INDEX `copylibraryid_idx` (`library_id` ASC) VISIBLE,
  CONSTRAINT `copyisbn`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `copylibraryid`
    FOREIGN KEY (`library_id`)
    REFERENCES `mydb`.`Library` (`Library_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Borrow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Borrow` (
  `Borrow_id` VARCHAR(45) NOT NULL,
  `copy_id` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `return_date` VARCHAR(45) NOT NULL,
  `request_ext` VARCHAR(45) NOT NULL,
  `allowed` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Borrow_id`),
  INDEX `borrowusermail_idx` (`user_email` ASC) VISIBLE,
  INDEX `borrowcopyid_idx` (`copy_id` ASC) VISIBLE,
  CONSTRAINT `borrowusermail`
    FOREIGN KEY (`user_email`)
    REFERENCES `mydb`.`Account` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `borrowcopyid`
    FOREIGN KEY (`copy_id`)
    REFERENCES `mydb`.`Copies` (`copy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;