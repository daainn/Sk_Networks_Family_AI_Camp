import mysql.connector
import naver_book

connection = mysql.connector.connect(
    host = 'localhost',
    user = '직접입력',
    password = '직접입력',
    database = 'bookdb'
)

cursor = connection.cursor()

sql = "INSERT INTO naver_book (book_title, book_image, author,  publisher, isbn, book_description, pub_date) VALUES (%s, %s, %s, %s, %s, %s, %s)"

for book_info in naver_book.book_list:
    values = (book_info['title'], book_info['image'],  book_info['author'],
              book_info['publisher'], str(book_info['isbn']), book_info['description'], book_info['pubdate'])
    cursor.execute(sql, values)

connection.commit()

cursor.close()
connection.close()
