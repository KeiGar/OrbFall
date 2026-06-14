import requests

BASE_URL = "https://api.keigartner.com"

def test_api_health():
    response = requests.get(f"{BASE_URL}/health")
    assert response.status_code == 200
    data = response.json()
    assert data["message"] == "Orbfall API ready!"

def test_api_wrong_method():
    response = requests.delete(f"{BASE_URL}/orbfall/highscore")
    assert response.status_code == 404
    data = response.json()
    assert data["message"] == "Not Found"