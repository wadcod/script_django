#!/bin/bash

read -p "Veuillez entrer le nom du dossier : " fichier_name
mkdir $fichier_name
cd $fichier_name

# création gitignore
touch .gitignore
cat <<EOF > .gitignore
# Created by https://www.toptal.com/developers/gitignore/api/django
# Edit at https://www.toptal.com/developers/gitignore?templates=django

### Django ###
*.log
*.pot
*.pyc
__pycache__/
local_settings.py
db.sqlite3
db.sqlite3-journal
media

# If your build process includes running collectstatic, then you probably don't need or want to include staticfiles/
# in your Git repository. Update and uncomment the following line accordingly.
# <django-project-name>/staticfiles/

### Django.Python Stack ###
# Byte-compiled / optimized / DLL files
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
#  Usually these files are written by a python script from a template
#  before PyInstaller builds the exe, so as to inject date/other infos into it.
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/

# Translations
*.mo

# Django stuff:

# Flask stuff:
instance/
.webassets-cache

# Scrapy stuff:
.scrapy

# Sphinx documentation
docs/_build/

# PyBuilder
.pybuilder/
target/

# Jupyter Notebook
.ipynb_checkpoints

# IPython
profile_default/
ipython_config.py

# pyenv
#   For a library or package, you might want to ignore these files since the code is
#   intended to run in multiple environments; otherwise, check them in:
# .python-version

# pipenv
#   According to pypa/pipenv#598, it is recommended to include Pipfile.lock in version control.
#   However, in case of collaboration, if having platform-specific dependencies or dependencies
#   having no cross-platform support, pipenv may install dependencies that don't work, or not
#   install all needed dependencies.
#Pipfile.lock

# poetry
#   Similar to Pipfile.lock, it is generally recommended to include poetry.lock in version control.
#   This is especially recommended for binary packages to ensure reproducibility, and is more
#   commonly ignored for libraries.
#   https://python-poetry.org/docs/basic-usage/#commit-your-poetrylock-file-to-version-control
#poetry.lock

# pdm
#   Similar to Pipfile.lock, it is generally recommended to include pdm.lock in version control.
#pdm.lock
#   pdm stores project-wide configurations in .pdm.toml, but it is recommended to not include it
#   in version control.
#   https://pdm.fming.dev/#use-with-ide
.pdm.toml

# PEP 582; used by e.g. github.com/David-OConnor/pyflow and github.com/pdm-project/pdm
__pypackages__/

# Celery stuff
celerybeat-schedule
celerybeat.pid

# SageMath parsed files
*.sage.py

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# Spyder project settings
.spyderproject
.spyproject

# Rope project settings
.ropeproject

# mkdocs documentation
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre type checker
.pyre/

# pytype static type analyzer
.pytype/

# Cython debug symbols
cython_debug/

# PyCharm
#  JetBrains specific template is maintained in a separate JetBrains.gitignore that can
#  be found at https://github.com/github/gitignore/blob/main/Global/JetBrains.gitignore
#  and can be added to the global gitignore or merged into this file.  For a more nuclear
#  option (not recommended) you can uncomment the following to ignore the entire idea folder.
#.idea/

# End of https://www.toptal.com/developers/gitignore/api/django
EOF


# Création de l virtual environment
python -m venv env
source env/Scripts/activate

# Installation de Django et sauvegarde des dépendances dans requirements.txt
pip install django
pip freeze > requirements.txt

# Demande à l'utilisateur de saisir le nom du projet Django
read -p "Veuillez entrer le nom du projet Django : " project_name

# Création du projet Django
django-admin startproject $project_name
cd $project_name

# Demande à l'utilisateur de saisir le nom de l'application Django
read -p "Veuillez entrer le nom de l'application Django : " app_name

# Création de l'application Django
python manage.py startapp $app_name



# Obtenez le chemin complet du fichier settings.py
settings_file="$project_name/settings.py"

# Obtenez le nom du répertoire de l'application (nom de l'application en minuscules)
app_directory="$(echo "$app_name" | tr '[:upper:]' '[:lower:]')"

# Ajouter le nom de l'application à la ligne 40 du fichier settings.py
sed -i "40i\\
    '$app_directory'," "$settings_file"

# Ajouter "bootstrap5" à la ligne 41 du fichier settings.py
sed -i "41i\\
    'bootstrap5'," "$settings_file"

# Chemin du répertoire statique de l'application
static_dir="    BASE_DIR / \"$app_name/static/\","

# Ajouter les lignes STATICFILES_DIRS dans le fichier settings.py
echo "" >> "$settings_file"
echo "STATICFILES_DIRS = [" >> "$settings_file"
echo "$static_dir" >> "$settings_file"
echo "]" >> "$settings_file"

mkdir -p "$app_name/static/$app_name/css" "$app_name/static/$app_name/img" "$app_name/static/$app_name/js"
fichier_css="$app_name/static/$app_name/css/style.css"
touch "$fichier_css"
cat <<EOF > $fichier_css
* {
    margin: 0;
    padding: 0;
    outline: 0;
    box-sizing: border-box;
}
button {
    cursor: pointer;
}
body {
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    min-height: 100vh;
    background-color: #4A968C;
    color: #F5CB45;
    font-size: 50px;
    text-shadow: 3px 3px 3px rgb(255, 0, 0), 3px 3px 3px rgb(247, 0, 255);
    background-image: linear-gradient(#4a968cc1, #4a968ce1), url('https://wallpapercave.com/wp/wp4092768.jpg');
    background-attachment: fixed;
    background-position: top;
    background-repeat: no-repeat;
    background-size: cover;
    object-fit: cover;
}
EOF

# Créer le répertoire "templates" s'il n'existe pas déjà
templates_directory="$app_name/templates"
mkdir -p "$templates_directory"

# Créer le répertoire avec le nom de l'application
app_templates_directory="$templates_directory/$app_name"
mkdir -p "$app_templates_directory"

# Créer le fichier base.html
base_html_file="$templates_directory/base.html"
touch "$base_html_file"
cat <<EOF > $base_html_file
{% load static %}
<!DOCTYPE html>
<html lang="fr">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>QDB PROD</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  {% load bootstrap5 %}
  {% bootstrap_css %}
  {% bootstrap_javascript %}
  
  <link href={% static '$app_name/css/style.css' %} rel="stylesheet">

</head>

<body>
  {% block content %}
  {% endblock content %}

</body>

</html>
EOF

# Créer le fichier home.html
home_html_file="$app_templates_directory/home.html"
touch "$home_html_file"
cat <<EOF > $home_html_file
{% extends "base.html" %}
{% block content %}
    <h1>Home</h1>
    <p><i><b> &copy; WADCORP </b></i> </p>
    <p><i><b> &copy; CHRISCORP </b></i> </p>
    <p><i><b> &copy; JEREMCORP </b></i> </p>

{% endblock content %} 
EOF

# fichier views
views="$app_name/views.py"
    cat <<EOF > $views
from django.shortcuts import render

# Create your views here.
def home(request):
    return render(request, '$app_name/home.html')
EOF


# fichier urls
urls="$project_name/urls.py"
    rm -rf $urls
    touch "$urls"
    cat <<EOF > $urls
"""
URL configuration for azz project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from $app_name import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home),
]
EOF


# Demande à l'utilisateur s'il souhaite installer MySQL
read -p "Souhaitez-vous installer MySQL (y/n)? " install_mysql

if [ "$install_mysql" == "y" ]; then
    # Installation de mysqlclient
    pip install mysqlclient
fi
read -p "Souhaitez-vous installer seed (y/n)? " install_seed

if [ "$install_seed" == "y" ]; then
    export DJANGO_SETTINGS_MODULE=$project_name.settings

    seed="$app_name/seed.py"
    touch "$seed"
    cat <<EOF > $seed
# from django_seed import Seed    
# from $app_name.models import Member
# import random

# def run():
#     seeder = Seed.seeder()
#     genders = ['male','female','autre']
#     seeder.add_entity(Member, 60, {
#         'age' : lambda x: random.randint(0,100),
#         'name' : lambda x: seeder.faker.name(),
#         'gender' : lambda x: genders[random.randint(0,2)],
#     })
#     inserted_pks = seeder.execute()
#     print(inserted_pks)
EOF
    touch "run_seed.py"
    cat <<EOF > run_seed.py
import django
django.setup()

from $app_name.seed import run

if __name__== '__main__':
    run()
EOF
pip install django-seed
pip install psycopg2
python run_seed.py
fi

# Installation de django-bootstrap-v5
pip install django-bootstrap-v5

python manage.py makemigrations
python manage.py migrate
# Lancement du serveur Django
python manage.py runserver
