from flask import Flask, render_template
from flask import request
app = Flask(__name__)
@app.route('/')
def index():
    return render_template('index.html',title='Home',name='Misha')

@app.route('/leaf')
def leaf():
    return render_template('leaf.html')

@app.route('/ctrl_flow')
def ctrl_flow():
    # return render_template('ctrl_flow.html',user="Zhangsan")
    # return render_template('ctrl_flow.html')
    return render_template('ctrl_flow.html',user="Zhangsan",items=['apple','banana','orange'])

@app.route('/filter')
def filter():
    return render_template('filter.html',name='wangwu',price=2.999)

@app.route('/macros')
def macros():
    # return render_template('macros_demo.html',items=['apple','banana','orange'])
    return render_template('macros_demo.html',items=[{"title":"apple","description":"苹果"},{"title":"banana","description":"香蕉"},{"title":"orange","description":"橘子"}])

@app.route('/xss')
def xss():
    return render_template('security.html',user_input='<script> alert(1) </script>')

@app.route('/profile/<username>')
def profile(username):
    user = {'name': username, 'age': 25}
    return render_template('profile.html', user=user)

@app.route('/form')
def form():
    return render_template('form.html')

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form.get('name')
    email = request.form.get('email')
    return f'Name: {name}, Email: {email}'

if __name__ == '__main__':
    app.run(debug=True)