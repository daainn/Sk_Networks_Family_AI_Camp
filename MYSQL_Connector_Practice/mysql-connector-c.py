import mysql.connector

connection = mysql.connector.connect(
    host = "localhost",
    user = "squirrel",
    password = "squirrel",
    database = "menudb"
)

if connection.is_connected():
    print(f"MYSQL에 성공적으로 연결되었습니다.")

cursor = connection.cursor()

# % 는 place holder라고 해서 값이 들어갈 자리를 비워두는 것
sql = "INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status) VALUES (%s,%s,%s,%s)"
values = ("쌀국수", 10000, 4, "Y")

cursor.execute(sql, values)
# commit을 하지 않으면 변경사항이 적용되지 않는다.
connection.commit()

print(f"{cursor.rowcount}개의 행을 삽입하였습니다.")

cursor.close()
connection.close()

if connection.is_connected():
    print(f"MYSQL이 해지되지 않았습니다.")
else:
    print(f"MYSQL에 성공적으로 해지되었습니다.")