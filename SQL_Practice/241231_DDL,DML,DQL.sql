use menudb;


# SELECT FROM---------------------------------------------

SELECT menu_name
  FROM tbl_menu;

SELECT menu_code, menu_name, menu_price, category_code, orderable_status
  FROM tbl_menu;
  
SELECT *
  FROM tbl_menu;
  
SELECT 12 + 31;
SELECT 12 - 31;
SELECT 12 * 31;
SELECT 12 / 31;
SELECT 12 % 31;

# ORDER BY------------------------------------------------------------
  SELECT menu_code, menu_name, menu_price
    FROM tbl_menu
ORDER BY menu_name, menu_name; #먼저 앞에 기준을 통해 정렬하고 중복값에 한해서는 뒤에 기준을 참조

SELECT menu_code, menu_name, menu_price, menu_code * menu_price
  FROM tbl_menu;
  
  SELECT menu_code, menu_name, menu_price, menu_code * menu_price
    FROM tbl_menu
ORDER BY menu_code * menu_price; # 조회 순서는 SELECT, FROM, ORDER BY순

  SELECT category_code, category_name, ref_category_code
	FROM tbl_category
ORDER BY ref_category_code; # null값이 맨 처음으로 오고 DSEC사용하면 NULL값이 맨 끝으로 

    
  SELECT category_code, category_name, ref_category_code
	FROM tbl_category
ORDER BY ref_category_code IS NULL DESC, ref_category_code DESC; 


# WHERE----------------------------------------------------------

-- 1)비교 연산자
  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE orderable_status = 'Y'; # Y인 것만 추출
   
  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE orderable_status <> 'Y'; # Y가 아닌 것만 추출 (<>를 써도 되고 !=써도 된다.)
   
  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE menu_price <= 10000;


-- 2)AND
   
--   SELECT menu_name, menu_price, orderable_status
-- 	FROM tbl_menu
--    WHERE 10000 < menu_price <= 20000; => 이렇게 쓰면 오류남 and를 통해 써주기

  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE 10000 < menu_price
     AND menu_price <= 20000;

-- 3)OR
  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE menu_price > 30000
	  OR menu_name = "열무김치라떼";

-- 4)BETWEEN
  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE menu_price BETWEEN 10000 AND 20000;


-- 5)LIKE
  SELECT menu_name, menu_price, orderable_status
	FROM tbl_menu
   WHERE menu_name LIKE "%김치%";
   

-- 6)IN
  SELECT menu_name, menu_price, orderable_status, category_code
	FROM tbl_menu
   WHERE category_code = 4
      OR category_code = 5
      OR category_code = 6;

  SELECT menu_name, menu_price, orderable_status, category_code
	FROM tbl_menu
   WHERE category_code IN (4,5,6);

-- 7) IS NULL------------------------------------------------------

  SELECT category_code, category_name, ref_category_code
	FROM tbl_category
   WHERE ref_category_code IS NULL; # NULL값을 가지는 것만 조회
   
  SELECT category_code, category_name, ref_category_code
	FROM tbl_category
   WHERE ref_category_code IS NOT NULL;
   
   
-- GROUP BY----------------------------------------------------------

SELECT category_code
  FROM tbl_menu
 GROUP
	BY category_code;
    
SELECT category_code, COUNT(*)
  FROM tbl_menu
 GROUP
	BY category_code;
    
SELECT category_cdoe, SUM(menu_price)
  FROM tbl_menu
 GROUP
	BY category_code;

SELECT category_code, AVG(menu_price)
  FROM tbl_menu
 GROUP 
    BY category_code;

SELECT category_code, menu_price, COUNT(*)
  FROM tbl_menu
 GROUP
	BY category_code, menu_price
 ORDER
	BY category_code, menu_price;
    
-- HAVING ----------------------------------------------------------------
# GROUP BY에 대한 조건 명시

SELECT category_code, COUNT(*)
  FROM tbl_menu
 GROUP
	BY category_code
HAVING category_code BETWEEN 5 AND 8;

# ROLLUP---------------------------------------------------------------

-- 컬럼 한 개를 활용해 GROUP BY 후 ROLLUP => 총계(합계)
SELECT category_code, SUM(menu_price)
  FROM tbl_menu
 GROUP
	BY category_code;
 
 -- 컬럼 두 개를 활용해 GROUP BY 후 ROLLUP => 중계 + 총계
 SELECT category_code, menu_price, COUNT(menu_price)
  FROM tbl_menu
 GROUP
	BY category_code, menu_price
  WITH ROLLUP;
  
# DISTINCT-------------------------------------------------------------

SELECT DISTINCT category_code
  FROM tbl_menu
 ORDER
	BY category_code;

SELECT DISTINCT ref_category_code
  FROM tbl_category;

SELECT DISTINCT category_code, orderable_status
  FROM tbl_menu
 ORDER
	BY category_code, orderable_status;
    
# LIMIT-----------------------------------------------------

SELECT menu_code, menu_name, menu_price
  FROM tbl_menu
 ORDER
	BY menu_price DESC;
    
SELECT menu_code, menu_name, menu_price
  FROM tbl_menu
 ORDER
	BY menu_price DESC
 LIMIT 2, 5; # 2번째 로우 부터 5번째 로우까지 조회
 
 SELECT menu_code, menu_name, menu_price
  FROM tbl_menu
 ORDER
	BY menu_price DESC
 LIMIT 7; # 2번째 로우 부터 5번째 로우까지 조회
  
  # DML-----------------------------------------------------------------
  
  
  
  # INSERT
  # 1)INSERT INTO 테이블명 VALUES (컬럼순으로, 삽입할, 데이터, 나열, ...)

SELECT menu_code, 
	   menu_name, 
       menu_price,
       category_code,
       orderable_status
  FROM tbl_menu;
  
USE menudb;
INSERT INTO tbl_menu VALUES (null, "고기짬뽕", 9500,  6, "Y");

-- 2)INSERT INTO 테이블명 (컬럼명1, 컬럼명2, 컬럼명 3, ...)
-- VALUES (데이터1, 데이터2, 데이터3)

INSERT INTO tbl_menu(menu_code, menu_name, menu_price,
					  category_code, orderable_status)
VALUES (NULL, "탕수육", 2000,  6, "Y");

INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
values ("카페라떼", 4500, 7, 'Y');

-- 3)MULTI INSERT
INSERT INTO tbl_menu
VALUES
(null, "콰트로치즈햄버거", 10500, 12, "Y"),
(null, "프렌치프라이", 8900, 12, "Y"),
(null, "코울슬로", 3000, 12, "Y");

INSERT INTO tbl_menu
VALUES (100, "100번음식", 100, 10, "N")
INSERT INTO tbl_menu
VALUES (NULL, "100번음식", 100, 10, "N") -- 이렇게 하면 MENU_CODE가 101로 지정됨 (기존의 순번을 따라가지 않고 100이후로 바뀜)

SELECT menu_code, 
	   menu_name, 
       menu_price,
       category_code,
       orderable_status
  FROM tbl_menu;
  
  
# UPDATE----------------------------------------------------------------
-- UPDATE 테이블명
-- 	SET 컬러명1 = 수정할 데이터,
--      컬럼명2 = 수정할 데이터,
--   	...
-- [WHERE 수정 대상 데이터 조건];

UPDATE tbl_menu
   SET menu_name = "100번이었던 음식"
	   , menu_price = 19000
 WHERE menu_code = 100;
 
# DELETE -----------------------------------------------------------------
-- DELETE FROM 테이블명 [WHERE 삭제 조건];
-- 일반적으로 PK키를 잡아서 삭제한다.
use menudb;

DELETE
  FROM tbl_menu
 WHERE menu_code = 101;
 
DELETE 
  FROM tbl_menu
 ORDER
	BY menu_code DESC
 LIMIT 3;
 
# REPLACE -----------------------------------------------------------------

INSERT INTO tbl_menu
VALUES (100, "100번음식", 100, 10, "N"); # 두번을 돌리면 PK가 중복되는 값으로 들어와서 에러 발생

REPLACE INTO tbl_menu
VALUES (100, "100번 음식 리플레이스~", 100, 10, "Y"); # 중복되는 값이 있으면 replace하고 없으면 insert

# into 는 생략도 가능

SELECT menu_code, menu_name, menu_price, category_code, orderable_status
  FROM tbl_menu;


  