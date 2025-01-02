import mysql.connector

connection = mysql.connector.connect(
    host = "localhost",
    user = "squirrel",
    password = "squirrel",
    database = "menudb"
)

if connection.is_connected():
    print(f"MYSQL에 성공적으로 연결되었습니다.")

# cursor를 통해 데이터 추출, 리스트 형태 안에 조회한 로우대로 튜플에 담겨져있는 상태로 추출된다.
cursor = connection.cursor()

# execute를 사용해 쿼리문 작성
cursor.execute("SELECT menu_code, menu_name, menu_price FROM tbl_menu")
result = cursor.fetchall()

for row in result: # row = 한 행의 결과과
    print('menucode:', row[0], '/' ,'menuname:', row[1], '/', 'menuprice:', row[2])

# print(result)


cursor.close()
connection.close()

if connection.is_connected():
    print(f"MYSQL이 해지되지 않았습니다.")
else:
    print(f"MYSQL에 성공적으로 해지되었습니다.")