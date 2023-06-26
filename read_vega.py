import requests
from time import sleep

IP="192.168.4.1"
PORT="80"
count = 0

while True:
    #print(count, end=" ")
    try:
        a = requests.get("http://"+IP+":"+PORT)
        print(a.text)
    except Exception as e:
        print(e)
    count += 1
    sleep(0.05)
