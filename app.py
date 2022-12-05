"""
export FLASK_APP=app.py
export FLASK_DEBUG=1
flask run
flask --help

from flask import:
    render_template - looks in "templates" for code to return

    request - basic request context for making information from HTTP available

    current_app - app context useful for storing data etc. When a Flask
    application begins handling a request, it pushes an application context and
    a request context. When the request ends it pops the request context then
    the application context.

    g - variable available in current app context which can store data. The data
    on g is lost after the context ends, and it is not an appropriate place to
    store data between requests. Use the session or a database to store data
    across requests.

    session - variable for storing data that persists between request
    
    make_response - for making response object (see example below)
    
    redirect - gives browser new url to navigate to
"""
# import ipdb


from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, PasswordField, BooleanField, FileField
from wtforms.validators import DataRequired, Length
from flask_bootstrap import Bootstrap5
import os

from flask import (
    Flask,
    render_template,
    request,
    current_app,
    g,
    session,
    make_response,
    redirect,
    url_for,
    flash,
)

###import numpy as np
###from fastai.vision import *
###from fastbook import *
###
###from fastai.vision.widgets import *
###
###import pickle
###import io
###
app = Flask(__name__)
app.config.from_pyfile("config.py")
bootstrap = Bootstrap5(app)


# extension is initialised by passing the application instance as an argument to
# the constructor Once bootstrap is inititialised, a base template that includes
# all the Bootstrap files and general structure is available to the application.
# App uses Jinja2 inheritance to extend the base template.
# bootstrap = Bootstrap(app)
###cwd = os.getcwd()
###path = cwd + "/model"
###address = path + "/model.pkl"
###
#### Loading  saved model
###model = load_learner(address)


class LoginForm(FlaskForm):
    username = StringField("Username", validators=[DataRequired(), Length(1, 20)])
    password = PasswordField("Password", validators=[DataRequired(), Length(8, 150)])
    remember = BooleanField("Remember me")
    submit = SubmitField()


class PictureForm(FlaskForm):
    file = FileField("", validators=[DataRequired()])
    submit = SubmitField()


@app.route("/", methods=["GET", "POST"])
def index():
    """
    Home Page
    """
    return render_template("index.html")


@app.route("/projects", methods=["GET", "POST"])
def projects():
    """
    Projects Page
    """
    form = PictureForm()
    if form.validate_on_submit():
        static_files = app.root_path + "/static/"
        file_path = static_files + "picture"
        form.file.data.save(file_path)

        file = form.file.data
        # Resizing img to 224 X 224 , This is the size on which model was
        # trained
        img = PILImage.create(file)
        # Prediction using model
        ###prediction = model.predict(img)[0]
        prediction = "bumper"
        session["prediction"] = str(prediction)

        return redirect(url_for("projects"))
    return render_template(
        "projects.html", form=form, prediction=session.get("prediction")
    )


@app.route("/about")
def about():
    """
    About Page
    """
    return render_template("about.html")
