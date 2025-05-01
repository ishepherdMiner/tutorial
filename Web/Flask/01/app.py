from flask import Flask, render_template

app = Flask(__name__)
@app.route('/')
def index():
    return 'Hello, World!'

@app.route('/router/about')
def about():
    return 'About Page'

@app.route('/router/contact')
def contact():
    return 'Contact Page'

@app.route('/greet/<name>')
def greet(name):
    return f'Hello, {name}!'

@app.route('/render/<name>')
def render(name):
    return render_template('render_name.html', name=name)

@app.errorhandler(404)
def page_not_found(e):
    return 'Page not found', 404
    
if __name__ == '__main__':
    app.run(debug=True)

