import pandas as pd
import os
from sqlalchemy import create_engine

path2data = "E:\\0.OneDrive\OneDrive - Dezhkeda\\0.Data\separated_txt"

dsn = 'mssql+pymssql://%s:%s@%s:%s/%s' % ("sa", "XCXOK9925", "127.0.0.1", "1433", "")
db_engine = create_engine(dsn + "US")

for root, dirs, files in os.walk(path2data):
    for file in files:
        temp = pd.read_json(os.path.join(root, file), encoding="utf-8")
        temp["ID"] = file
        temp.to_sql("Qishi_10K10Q_Raw", db_engine, if_exists='append', index=False, index_label='ID')
        print(file + " Insert OK!")