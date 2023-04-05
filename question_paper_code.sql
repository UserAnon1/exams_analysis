DROP TABLE IF EXISTS question_paper_code;

CREATE TABLE question_paper_code(
    id INT PRIMARY KEY AUTO_INCREMENT,
    paper_code INT NOT NULL,
    class INT NOT NULL,
    subject VARCHAR(128) NOT NULL
);
INSERT INTO question_paper_code (paper_code,class,subject) VALUES (101,6,'Math');
INSERT INTO question_paper_code (paper_code,class,subject) VALUES (102,7,'Math');
INSERT INTO question_paper_code (paper_code,class,subject) VALUES (103,8,'Math');
INSERT INTO question_paper_code (paper_code,class,subject) VALUES (501,6,'Science');
INSERT INTO question_paper_code (paper_code,class,subject) VALUES (502,7,'Science');
INSERT INTO question_paper_code (paper_code,class,subject) VALUES (503,8,'Science');
