--script 1--
DECLARE year INT = 2022;

CREATE VIEW lessons_per_month AS 
	SELECT EXTRACT(YEAR FROM time_slot) AS year, EXTRACT(MONTH FROM time_slot) AS month, 
	COUNT(*) AS total_lessons,
    COUNT(lesson_type) FILTER (WHERE lesson_type = 'individual') AS individual_lessons,
    COUNT(lesson_type) FILTER (WHERE lesson_type = 'group') AS group_lessons,
    COUNT(lesson_type) FILTER (WHERE lesson_type = 'ensemble') AS ensemble
    FROM instructor_lesson
    GROUP BY year, month ORDER BY year, month;

--WHERE EXTRACT(YEAR FROM time_slot)=year

SELECT * FROM lessons_per_month;
EXPLAIN ANALYZE(SELECT * FROM lessons_per_month);

--script 2--
CREATE VIEW number_of_siblings AS 
	SELECT 
	CASE
	    WHEN sibling1 IS NOT NULL AND sibling2 IS NULL THEN 1
	    WHEN sibling1 IS NULL AND sibling2 IS NOT NULL THEN 1
	    WHEN sibling1 IS NOT NULL AND sibling2 IS NOT NULL THEN 2
	    ELSE 0
	END AS number_of_siblings,
	COUNT(*) as students
	FROM student
	GROUP BY number_of_siblings

SELECT * FROM number_of_siblings;
EXPLAIN ANALYZE(SELECT * FROM number_of_siblings);

--script 3--
CREATE VIEW given_lessons AS
	SELECT DISTINCT employment_id,
	COUNT(*) AS given_lessons_this_month
	FROM instructor_lesson
	WHERE EXTRACT(MONTH FROM time_slot)=EXTRACT(MONTH FROM CURRENT_TIMESTAMP)
	GROUP BY employment_id;

SELECT * FROM given_lessons;
EXPLAIN ANALYZE(SELECT * FROM given_lessons);

--script 4--
CREATE VIEW upcoming_ensembles AS
	SELECT ensemble.genre, EXTRACT(DAY FROM ensemble_schedule.start_time) AS day,
		CASE
			WHEN(ensemble.max_students-ensemble.registered_students=0) THEN 'Ensemble is full'
			WHEN(ensemble.max_students-ensemble.registered_students=1) THEN 'Only one spot left'
			WHEN(ensemble.max_students-ensemble.registered_students=2) THEN 'Two spots left'
			ELSE 'Many spots left'
		END AS capacity
	FROM ensemble, ensemble_schedule 
	WHERE ensemble.ensemble_id=ensemble_schedule.ensemble_id AND DATE_TRUNC('WEEK', CURRENT_TIMESTAMP + INTERVAL '7 days')=DATE_TRUNC('WEEK', start_time)
	GROUP BY ensemble.genre, ensemble_schedule.start_time, ensemble.max_students, ensemble.registered_students;

SELECT * FROM upcoming_ensembles;
EXPLAIN ANALYZE(SELECT * FROM upcoming_ensembles);












