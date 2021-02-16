import sys
from Komolon import create_app

sys.path.insert(0, '/var/www/Komolon/venv/lib/python3.6/site-packages')
sys.path.insert(0, '/var/www/Komolon')

application = create_app()

