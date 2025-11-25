import re
import json
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(r'mssql+pyodbc://.\SQLEXPRESS/Task1DB?driver=ODBC+Driver+18+for+SQL+Server&trusted_connection=yes&TrustServerCertificate=yes')

with open('task1_d.json', 'r', encoding='utf-8') as f:
    raw_content = f.read()
    fixed_json = re.sub(r':(\w+)=>', r'"\1":', raw_content)
    df = pd.DataFrame(json.loads(fixed_json))

df['id'] = df['id'].astype(str)

df.to_sql('RawBooks', con=engine, if_exists='replace', index=False)