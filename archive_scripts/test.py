activate_this = '/var/www/Komolon/active_venv.py'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))
