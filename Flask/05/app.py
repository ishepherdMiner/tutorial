from flask import Flask, render_template, redirect, url_for,request
from flask_wtf import FlaskForm
from wtforms import StringField, EmailField, SubmitField
from wtforms.validators import DataRequired, Email,Length
import sys

app = Flask(__name__)
app.secret_key = '6a31ad17a15b0d887049fcfd478aedeb8da2d40049f1413ca4add757379d4237'  # Required for form protection

class MyForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    email = EmailField('Email', validators=[DataRequired(), Email()])
    submit = SubmitField('Submit')

class MyForm2(FlaskForm):
    name = StringField('Name', validators=[
        DataRequired(), Length(min=1, max=8)
    ])
    email = EmailField('Email', validators=[
        DataRequired(), Email()
    ])
    submit = SubmitField('Submit')

@app.route('/', methods=['GET', 'POST'])
def form():
    form = MyForm()
    # Call validate only if the form is submitted. This is a shortcut for form.is_submitted() and form.validate().
    # print(form.is_submitted())
    # print(form.validate())
    if form.validate_on_submit():
        name = form.name.data
        email = form.email.data
        return f'Name: {name}, Email: {email}'
    else:
        print(form.errors)  # Print form validation errors if any
        print(form.name.errors)  # Print name field validation errors if any
    return render_template('form.html', form=form)

@app.route('/form2', methods=['GET', 'POST'])
def form2():
    form = MyForm2()
    if form.validate_on_submit():
        name = form.name.data
        email = form.email.data
        return redirect(url_for('form'))
    return render_template('form.html', form=form)

@app.route('/upload_file', methods=['GET'])
def upload_form():
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files.get('file')
    print(f"file: {file}")
    if file:
        filename = file.filename
        print(filename)
        file.save(f'uploads/{filename}')
        return f'File uploaded successfully: {filename}'
    return 'No file uploaded'

if __name__ == '__main__':
    port = sys.argv[1] if len(sys.argv) > 1 else 5001
    app.run(port=int(port),debug=True)