import os
import pymysql


def execute():
    connection = pymysql.connect(
        host='localhost',
        #user=os.getenv("DB_USERNAME"),
        user="admin",
        #password=os.getenv("DB_PASSWORD"),
        password="123",
        database="muzeum",
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    print("rzeczy")
    try:
        # with connection.cursor() as cursor:
        #     sql = "INSERT INTO t VALUES(%s)"
        #     cursor.execute(sql, 35)
        # connection.commit()

        with connection.cursor() as cursor:
            sql = "SELECT * FROM t"
            cursor.execute(sql)
            result = cursor.fetchall()
            for f in result:
                print(f.get("p"))
    finally:
        connection.close()
