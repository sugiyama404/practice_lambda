import base64
import json
import os
import pymysql

ENDPOINT=os.environ["db_host"]
PORT=3306
USER=os.environ["db_user"]
PASS=os.environ["db_pass"]
DBNAME=os.environ["db_name"]
os.environ['LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN'] = '1'

def execute_sql(cur):
    try:
        sql = """
        CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) DEFAULT NULL,
        email VARCHAR(255) DEFAULT NULL,
        password VARCHAR(255) DEFAULT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        );
        """
        cur.execute(sql)
    except pymysql.Error as e:
        print(f"エラーが発生しました: {e}")
        cur.rollback()

conn =  pymysql.connect(host=ENDPOINT, user=USER, passwd=PASS, port=PORT, database=DBNAME)
cur = conn.cursor()

def lambda_handler(event, context):
    execute_sql(cur)
    try:
        username = event.get('username')
        email = event.get('email')
        password = event.get('password')

        sql = "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)"
        cur.execute(sql, (username, email, password,))
        return  {
        'statusCode': 200,
        'body': json.dumps({}),
        'headers': {
            'Access-Control-Allow-Origin': '*',
        },
        }
    except:
        import traceback
        err = traceback.format_exc()
        print(err)
        return {
          'statusCode' : 500,
          'headers' : {
            'context-type' : 'text/json'
          },
          'body' : json.dumps({
            'error' : '内部エラーが発生しました'
            })
          }
