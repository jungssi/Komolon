from setuptools import setup, find_packages

setup(
    name='Komolon',
    version='1.0',
    long_description=__doc__,
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
	'click==7.1.2',
	'Flask==1.1.2',
	'itsdangerous==1.1.0',
	'Jinja2==2.11.3',
	'MarkupSafe==1.1.1',
	'Werkzeug==1.0.1'
	]
)

