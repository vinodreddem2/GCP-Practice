import requests

def get_data():
    api_url = "https://the-rosary-api.vercel.app/v1/today"
    response = requests.get(api_url)
    res = response.json()
    print(f"res : {res}")

get_data()