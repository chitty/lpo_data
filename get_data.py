import psycopg2

conn = psycopg2.connect(database="lake_data", user="lpo", 
                        password="mysecurepassword", host="localhost")
cur = conn.cursor()
q = ("SELECT avg(wind_speed) AS avg_wind_speed, median(wind_speed) AS"
     " median_wind_speed, avg(air_temperature) AS avg_air_temperature,"
     " median(air_temperature) AS median_air_temperature,"
     " avg(barometric_pressure) AS avg_barometric_pressure,"
     " median(barometric_pressure) AS median_barometric_pressure"
     " FROM raw_data;")
cur.execute(q)
print cur.fetchone()
cur.close()
conn.close()
