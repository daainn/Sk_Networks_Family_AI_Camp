USE menudb;
-- 실습 1

SELECT category_code, category_name
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL
 ORDER
	BY category_name DESC;
    
-- 실습 2

SELECT menu_name, menu_price
  FROM tbl_menu
 WHERE menu_name LIKE "%밥%"
   AND 20000 <= menu_price 
   AND menu_price <= 30000;
    
-- 실습 3

SELECT *
  FROM tbl_menu
 WHERE menu_price < 10000
	OR menu_name LIKE "%김치%"
 ORDER
	BY menu_price ASC, menu_name DESC;
   

-- 실습 4

-- SELECT menu_code, menu_name, menu_price, category_code, orderable_status
--   FROM tbl_category
--  INNER 
--   JOIN tbl_menu
--     ON tbl_category.category_code = tbl_menu.category_code 
--  WHERE ref_category_code IS NOT NULL
--    AND category_name NOT IN ("기타", "쥬스", "커피")
--    AND menu_price = 13000
--    AND orderable_status = "Y"
--  ORDER
-- 	BY category_name DESC;
--     
SELECT *
  FROM tbl_menu
 WHERE category_code IN (4,7,5,6,12,11)
   AND menu_price = 13000
   AND orderable_status = 'Y';
   
-- 실습 5

USE employeedb;

SELECT EMP_NO, EMP_NAME, PHONE, HIRE_DATE, ENT_YN
  FROM employee
 WHERE ENT_YN = "N"
   AND PHONE LIKE "%2"
 ORDER
	BY HIRE_DATE DESC
 LIMIT 3;

-- 실습 6
use infodb;

INSERT INTO team_info
VALUES
(null, "음악감상부", "클래식 및 재즈 음악을 감상하는 사람들의 모임","Y"),
(null, "맛집탐방부", "맛집을 찾아다니는 사람들의 모임", "N"),
(null, "행복찾기부", NULL, "Y");


INSERT INTO  member_info
VALUES
(null, "송가인", "1990-01-30", 1, "안녕하세요 송가인입니다~", "010-9494-9494", 1, "H"),
(null, "임영웅", "1992-05-03", NULL, "국민아들 임영웅입니다~", "hero@trot.com", 1, "Y"),
(null, "태진아", NULL, NULL, NULL, "(1급 기밀)", 3, "Y");

SELECT * 
  FROM team_info;
SELECT *
  FROM member_info;
