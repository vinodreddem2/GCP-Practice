import pyodbc
import pandas as pd

server="IBM-2S6YGY3\SQLEXPRESS"
database="gcp_practice"
username="mssqlserver"
password = "admin1234567890"


conn= pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = conn.cursor()
query = "select id,firstname,city from dbo.persons "
df = pd.read_sql(query, conn)
print(df.head())

# cursor.execute("select trim(id),trim(name),trim(city) from dbo.person_tbl ")
#
# for row in cursor.fetchall():
#     print('row = %r' % (row,))