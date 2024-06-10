from ninja import NinjaAPI


app = NinjaAPI()

@app.get('/users')
def get_users(request):
    return {'data': [], 'message': 'Users fetched success'}