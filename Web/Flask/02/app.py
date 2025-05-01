from flask import Flask

app = Flask(__name__)

@app.route('/') # 装饰器，用于定义路由。/ 表示根 URL
def home(): 
    return 'Welcome to the Home Page!'

@app.route('/greet/<name>') # 动态路由，<name> 是一个变量
def greet(name):
    return f'Hello, {name}!'

@app.route('/user/<int:user_id>')
def user_profile(user_id):
    return f'User ID: {user_id}'

@app.route('/user/<user_id>')
def user_profile2(user_id):
    return f'User ID2: {user_id}'

@app.route('/files/<path:filename>')
def serve_file(filename):
    return f'Serving file: {filename}'

@app.route('/submit', methods=['POST'])
def submit():
    return 'Form submitted!'

from flask import jsonify, Response
from flask import render_template

@app.route('/json')
def json_response():
    data = {'key': 'value'}
    return jsonify(data)

@app.route('/custom')
def custom_response():
    response = Response('Custom response with headers', status=200)
    response.headers['X-Custom-Header'] = 'Value'
    return response

@app.route('/tutorial02/<name>')
def hello(name):
    return render_template('02.html', name=name)

if __name__ == '__main__':
    app.run(debug=True)