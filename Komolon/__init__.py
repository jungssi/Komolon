import os

from flask import Flask


def create_app(test_config=None):
	app = Flask(__name__, instance_relative_config=True)
	app.config.from_mapping(
		SECRET_KEY="dev",
		# store the database in the instance folder
		#DATABASE=os.path.join(app.instance_path, "komolon.sqlite"),
	)

	if test_config is None:
		app.config.from_pyfile("config.py", silent=True)
	else:
		app.config.update(test_config)

	try:
		os.makedirs(app.instance_path)
	except OSError:
		pass


	@app.route("/")
	def hello():
		return "Hello, Komolon!"


	app.add_url_rule("/", endpoint="index")

	return app

