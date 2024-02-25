import random
from datetime import datetime, timedelta

from faker import Faker
fake = Faker()

file = open(f"data_{datetime.utcnow().strftime('%Y-%m-%d')}.csv","w")

header = "item;order_date;amount"
file.write(header + '\n')
for i in range(1,25):
    row = []
    item = ["A","B","C","D","E"]
    row.append(random.choice(item))

    date1 = fake.date_time_between(start_date='-2y', end_date='-1y')
    order_date = date1.strftime("%d-%m-%Y")

    row.append(str(order_date))

    val1 = random.randint(10,101)

    row.append(str(val1))

    line = ";".join(v for v in row) 

    file.write(line + '\n')

file.close