from flask import Flask, request,render_template,jsonify,Response

app = Flask(__name__)

from flask import request

@app.route('/')
def index():
    return 'Hello, World!'

# 接收 - URL参数
@app.route('/greet/<name>')  
def greet(name):
    return f'Hello, {name}!'

# 接收 - 表单数据
@app.route('/submit', methods=['POST'])  
def submit():
    username = request.form.get('username')  
    return f'Form submitted by {username}!'

# 接收 - GET请求中query
@app.route('/search')
def search():
    query = request.args.get('query')
    return f'Search results for: {query}'
    
# 返回 - 字符串
@app.route('/message')
def message():
    return 'This is a simple message.'

# 返回 - HTML模板
@app.route('/hello/<name>')
def html_hello(name):
    return render_template('hello.html', name=name)

# 返回 - JSON
@app.route('/api/data')
def api_data():
    data = {'key': 'value'}
    return jsonify(data)

# 返回 - 自定义响应对象
@app.route('/custom')
def custom_response():
    response = Response('Custom response with headers', status=200)
    response.headers['X-Custom-Header'] = 'Value'
    return response

# 处理请求和响应
@app.route('/info')
def info():
    user_agent = request.headers.get('User-Agent')
    return f'Your user agent is {user_agent}'

@app.route('/divide/<int:x>/<int:y>')
def divide(x, y):
    try:
        result = x / y
        return f'Result: {result}'
    except ZeroDivisionError:
        return 'Error: Division by zero', 400

# 全局错误
@app.errorhandler(404)
def not_found(error):
    return '消失了', 404

@app.before_request
def before_request():
    print('请求前')

@app.after_request
def after_request(response):
    print('请求后')
    return response

@app.teardown_request
def teardown_request(exception):
    print('请求结束，清理')

@app.route('/status')
def status():
    return 'Everything is OK', 200

@app.route('/error')
def error():
    return Response('An error occurred', status=500)

if __name__ == '__main__':
    app.run(debug=True)