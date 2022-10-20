#!/usr/bin/python3
"""import flask"""
from flask import Flask, render_template
from models import storage

app = Flask(__name__)


@app.route("/states_list", strict_slashes=False)
def fetchStates():
    """ displays html of all states"""
    states = storage.all("State")
    return render_template('7-states_list.html', states=states)


@app.teardown_appcontext
def removeSession(exception):
    """ teardown current sql session"""
    storage.close()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
