from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import sys
import time
from sqlalchemy import or_
from flask_migrate import Migrate
from sqlalchemy import text

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///mydatabase.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# OMR
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'

@app.route('/')
def index():
    return 'Hello, World!'

@app.route('/add_user')
def add_user():
    timestamp = time.time()
    username = f'john_doe_{timestamp}'
    email = f'john_{timestamp}@example.com'
    new_user = User()
    new_user.username = username
    new_user.email = email
    db.session.add(new_user)
    db.session.commit()
    return 'User added!'

@app.route('/get_users')
def get_users():
    users = User.query.all()  # 获取所有用户
    return '<br>'.join([f'{user.username} ({user.email})' for user in users])

@app.route('/update_user/<int:user_id>')
def update_user(user_id):
    user = User.query.get(user_id)
    if user:
        user.username = '新名字'
        db.session.commit()
        return 'User updated!'
    return 'User not found!'

@app.route('/delete_user/<int:user_id>')
def delete_user(user_id):
    user = User.query.get(user_id)
    if user:
        db.session.delete(user)
        db.session.commit()
        return 'User deleted!'
    return 'User not found!'

@app.route('/query/<username>')
def query(username):
    print(f"username: {username}")
    user = User.query.filter_by(username=username).first()
    if user:
        return f"User:{user.username} ({user.email})"
    return 'User not found!'

@app.route('/query2/<username>/<email>')
def query2(username,email):
    print(f"username: {username}")
    print(f"email: {email}")
    # 为了避免通过类访问泛型实例变量的问题，这里直接使用变量名
    user = User.query.filter(or_(User.username == username, User.email == email)).first()
    if user:
        return f"User:{user.username} ({user.email})"
    return 'User not found!'

@app.route('/query3')
def query3():
    users = User.query.order_by(User.username).paginate(page=1, per_page=10)
    if users:
        return '<br>'.join([f'{user.username} ({user.email})' for user in users.items])
    return 'Users not found!'

@app.route('/table')
def table():
    # 检查是否有对应的数据表
    result = ""
    connection = db.engine.connect()
    if not db.engine.dialect.has_table(connection, 'user'):
        with app.app_context():
            db.create_all()
            result = "Table 'user' created successfully."
    else:
        result = "Table 'user' already exists."
    connection.close()
    return result

@app.route('/raw_sql')
def raw_sql():
    result = db.session.execute(text('SELECT * FROM user'))
    return '<br>'.join([str(row) for row in result])

migrate = Migrate(app, db)
if __name__ == '__main__':
    port = sys.argv[1] if len(sys.argv) > 1 else 5001
    app.run(port=int(port),debug=True)