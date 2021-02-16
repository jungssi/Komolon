# Komolon
<hr/>

**K-Omolon Destiny2 Assistant**

Komolon is a assistant for destinty2 game play   

1. Weapon sorting and search for K-Guardian.
2. Weapon evaluator for K-Guardian.
3. Clan planner & manager.


# Getting Started
<hr/>

-Require Python 3.x
-Open port 5000 for dev    
-MacOS & CentOS tested.

1. Run run_komolon_dev.sh
2. Connect to http://localhost:5000/


# Shell Scripts
<hr/>

## run_komolon_dev.sh 
- run Komolon flask develop server to http://localhost:5000/

## build_komolon.sh
- (LIVE ONLY) Build komolon flask to whl

## deploy_komolon.sh 
- (LIVE ONLY) Copy komolon whl and wsgi to deploy path and install to product server venv 

## rm_temp_files.sh 
- Remove temp files in this path for ready to commit
