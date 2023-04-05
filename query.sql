
SELECT
    sl.roll_number,
    sl.student_name,
    sl.class,
    sl.section,
    sl.school_name,
    tabla_final.math_correct,
    tabla_final.math_wrong,
    tabla_final.math_yet_to_learn,
    tabla_final.math_porcentage,
    tabla_final.science_correct,
    tabla_final.science_wrong,
    tabla_final.science_yet_to_learn,
    tabla_final.science_porcentage
FROM student_list AS sl
    RIGHT JOIN (
        SELECT
            math_tab.roll_number,
            math_tab.math_correct,
            math_tab.math_wrong,
            math_tab.math_yet_to_learn,
            math_tab.math_porcentage,
            science_tab.science_correct,
            science_tab.science_wrong,
            science_tab.science_yet_to_learn,
            science_tab.science_porcentage
        FROM (
                SELECT
                    tab.roll_number,
                    SUM(tab.correcta) AS math_correct,
                    SUM(tab.incorrecta) AS math_wrong,
                    SUM(tab.no_sabe) AS math_yet_to_learn,
                    SUM(tab.correcta) * 100 / 40 AS math_porcentage
                FROM (
                        SELECT
                            sr.roll_number,
                            sr.question_paper_code,
                            sr.question_number,
                            sr.option_marked,
                            ca.correct_option,
                            CASE
                                WHEN sr.option_marked = ca.correct_option THEN 1
                                ELSE 0
                            END AS correcta,
                            CASE
                                WHEN sr.option_marked = 'e' THEN 1
                                ELSE 0
                            END AS no_sabe,
                            CASE
                                WHEN sr.option_marked <> ca.correct_option
                                and sr.option_marked <> 'e' THEN 1
                                ELSE 0
                            END AS incorrecta
                        FROM student_response AS sr
                            LEFT JOIN correct_answer AS ca ON sr.question_paper_code = ca.question_paper_code AND sr.question_number = ca.question_number
                    ) AS tab
                WHERE
                    tab.question_paper_code = 101
                    OR tab.question_paper_code = 102
                    OR tab.question_paper_code = 103
                GROUP BY
                    tab.roll_number,
                    tab.question_paper_code
            ) AS math_tab
            JOIN (
                SELECT
                    tab.roll_number,
                    SUM(tab.correcta) AS science_correct,
                    SUM(tab.incorrecta) AS science_wrong,
                    SUM(tab.no_sabe) AS science_yet_to_learn,
                    SUM(tab.correcta) * 100 / 60 AS science_porcentage
                FROM (
                        SELECT
                            sr.roll_number,
                            sr.question_paper_code,
                            sr.question_number,
                            sr.option_marked,
                            ca.correct_option,
                            CASE
                                WHEN sr.option_marked = ca.correct_option THEN 1
                                ELSE 0
                            END AS correcta,
                            CASE
                                WHEN sr.option_marked = 'e' THEN 1
                                ELSE 0
                            END AS no_sabe,
                            CASE
                                WHEN sr.option_marked <> ca.correct_option
                                and sr.option_marked <> 'e' THEN 1
                                ELSE 0
                            END AS incorrecta
                        FROM student_response AS sr
                            LEFT JOIN correct_answer AS ca ON sr.question_paper_code = ca.question_paper_code AND sr.question_number = ca.question_number
                    ) AS tab
                WHERE
                    tab.question_paper_code = 501
                    OR tab.question_paper_code = 502
                    OR tab.question_paper_code = 503
                GROUP BY
                    tab.roll_number,
                    tab.question_paper_code
            ) AS science_tab ON math_tab.roll_number = science_tab.roll_number
    ) as tabla_final ON sl.roll_number = tabla_final.roll_number;
