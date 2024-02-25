import random
from datetime import datetime, timedelta

from faker import Faker
fake = Faker()

file = open(f"data_{datetime.utcnow().strftime('%Y%m%d')}.csv","w")

header = "id;status_code;invoice_number;item_category;channel;order_date;delivery_date;amount"
file.write(header + '\n')
for i in range(1001,2001):
    row = []
    row.append(str(i))
    row.append(str(random.randint(1,20)))
    row.append(str(random.randint(7000000000,9999999999)))

    item_category = f"Category_{random.randint(1,5)}"
    row.append(item_category)

    channel = ['WEB','APP','Offline']
    row.append(random.choice(channel))

    date1 = fake.date_time_between(start_date='-2y', end_date='-1y')
    order_date = date1.strftime("%d-%m-%Y %H:%M")
    
    days_l = [3,2,1,4,6,5] 
    date2 = date1 + timedelta(days=random.choice(days_l))

    delivery_date = date2.strftime("%d-%m-%Y %H:%M")

    row.append(str(order_date))

    row.append(str(delivery_date))

    val1 = random.randint(10,999)
    val2 = random.randint(10,99)

    val = str(val1) + ',' + str(val2)

    row.append(str(val))

    line = ";".join(v for v in row) 

    file.write(line + '\n')

file.close