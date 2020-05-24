import os
import pymysql
from dotenv import load_dotenv

load_dotenv(os.getcwd() + "../.env")

def polaczenie():
    connection = pymysql.connect(
        host='localhost',
        # user=os.getenv("DB_USERNAME"),
        user="admin",
        # password=os.getenv("DB_PASSWORD"),
        password="123",
        database="muzeum",
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection
