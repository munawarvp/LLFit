import requests

from decouple import config

class ApiNinja:
    def __init__(self):
        self.base_url = 'https://api.api-ninjas.com'
        self.api_key = config('API_NINJA')

    def get_muscle_based_excerise(self, muscle):
        try:
            url = f"{self.base_url}/v1/exercises?muscle={muscle}"
            headers = {'X-Api-Key': self.api_key}
            response = requests.get(url, headers=headers)
            return response.json()
        except Exception as e:
            return {"success": False, "message": f"Error --- {e}"}