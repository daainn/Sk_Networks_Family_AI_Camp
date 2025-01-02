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

sql = "DELETE FROM tbl_menu WHERE menu_code = 102"

cursor.execute(sql)
# commit을 하지 않으면 변경사항이 적용되지 않는다.
connection.commit()

print(f"{cursor.rowcount}개의 행을 DELETE하였습니다.")

cursor.close()
connection.close()

if connection.is_connected():
    print(f"MYSQL이 해지되지 않았습니다.")
else:
    print(f"MYSQL에 성공적으로 해지되었습니다.")