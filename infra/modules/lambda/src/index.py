import base64
import json
import os
import pymysql

ENDPOINT=os.environ["db_host"]
PORT="3306"
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
        cur.commit()
    except pymysql.Error as e:
        print(f"エラーが発生しました: {e}")
        cur.rollback()

conn =  pymysql.connect(host=ENDPOINT, user=USER, passwd=PASS, port=PORT, database=DBNAME)
cur = conn.cursor()


def lambda_handler(event, context):
    execute_sql(cur)
    try:
        body = event['body']
        if event['isBase64Encoded']:
            body = base64.b64decode(body)
        decoded = json.loads(body)
        username = decoded['username']
        email = decoded['email']
        password = decoded['password']

        sql = "INSERT INTO user (username, email, password) VALUES (%s, %s, %s)"
        cur.execute(sql, (username, email, password,))
        return json.dumps({})
    except:
        #エラーメッセージを返す
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
