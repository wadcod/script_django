#!/bin/bash

read -p "Veuillez entrer le nom du dossier : " fichier_name
mkdir $fichier_name
cd $fichier_name
deactivate
# Demande à l'utilisateur s'il souhaite installer MySQL
read -p "Souhaitez-vous installer MySQL (y/n)? " install_mysql

read -p "Souhaitez-vous installer seed (y/n)? " install_seed

# Demande à l'utilisateur de saisir le nom du projet Django
read -p "Veuillez entrer le nom du projet Django : " project_name

# Demande à l'utilisateur de saisir le nom de l'application Django
read -p "Veuillez entrer le nom de l'application Django : " app_name

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

# MàJ de Pip
python.exe -m pip install --upgrade pip

# Installation de Django et sauvegarde des dépendances dans requirements.txt
pip install django



# Création du projet Django
django-admin startproject $project_name
cd $project_name



# Création de l'application Django
python manage.py startapp $app_name



# Obtenez le chemin complet du fichier settings.py
settings_file="$project_name/settings.py"

# Obtenez le nom du répertoire de l'application (nom de l'application en minuscules)
app_directory="$(echo "$app_name" | tr '[:upper:]' '[:lower:]')"

# Ajouter "import os" à la ligne 14 du fichier settings.py
sed -i "14i\\
import os" "$settings_file"

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
echo "MEDIA_URL = '/media/'" >> "$settings_file"
echo "MEDIA_ROOT = os.path.join(BASE_DIR, 'media')" >> "$settings_file"



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
a{
    text-decoration: none;
    color: inherit;
    font-weight: inherit;
}

.inputform{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: cneter;
    flex-wrap: wrap;
}
.inputbtn{
    outline: none;
    border: none;
    font-weight: bold;

}

.inputbtn:hover {
    color: rgb(255, 255, 255);    
    background-color: rgb(7, 155, 155);
}
.inputform label{
    display: flex;
    flex-direction: column;
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

# Créer le fichier index.html
index_html_file="$app_templates_directory/index.html"
touch "$index_html_file"
cat <<EOF > $index_html_file
{% extends "base.html" %}
{% block content %}

<p><i><b> <a href="https://wallpapercave.com/wp/wp4092746.jpg" target="_blank">&copy; WADCORP </a></b></i> </p>
    <p><i><b> <a href="https://wallpapercave.com/wp/wp4092767.png" target="_blank">&copy; KWISSYCORP </a></b></i> </p>
    <p><i><b> <a href="https://wallpapercave.com/wp/7zHcRhs.jpg" target="_blank">&copy; JIHEFELCORP </a></b></i> </p>
    <p><i><b> <a href="https://wallpapercave.com/wp/wp3948114.jpg" target="_blank">&copy; LECHESHIRECORP (MAC) </a></b></i> </p>
    <p><i><b> <a href="https://pbs.twimg.com/media/EyhJuqFWUAE4KFs?format=jpg&name=900x900" target="_blank">&copy; MOHACORP </a></b></i> </p>
    <p><i><b> <a href="https://wallpapercave.com/dwp2x/wp10583826.jpg" target="_blank">&copy; NICORP (MAC)</a></b></i> </p>
    <p><i><b> <a href="https://ih1.redbubble.net/image.2281622048.4930/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg" target="_blank">&copy; RYADCORP</a></b></i> </p>
    <p><i><b> <a href="https://i.ytimg.com/vi/jcPrnWNX3Ck/maxresdefault.jpg" target="_blank">&copy; SOUFCORP</a></b></i> </p>

    
    <!-- pays -->
    <h1>CRUD Pays</h1>
    <div class="allForm">
        <form method="post" class="inputform">
            {% csrf_token %}
            {{ pays_form.as_p }}
            <button class="inputbtn" type="submit">Ajouter</button>
        </form>
    </div>
    <ul>
    {% for p in pays %}
        <li>{{ p.nom }} - Population : {{ p.population }}</li>
    {% empty %}
        <li>Aucun pays enregistré.</li>
    {% endfor %}
    </ul>


<br>
<!-- president -->
    <h1>CRUD Président</h1>
    <div class="allForm">
        <form class="inputform" method="post" enctype="multipart/form-data">
        {% csrf_token %}
        {{ president_form.as_p }}
        <button class="inputbtn" type="submit">Ajouter</button>
        </form>
    </div>
    
    <ul>
    {% for p in presidents %}
    <li>
        <img src="{{ p.image.url }}" alt="" class="w-25 mt-5 {% if p.genre == 'M' %}
        border border-5 border-danger
        {% elif p.genre == 'F' %}
        border border-5 border-primary
        {% else %}
        border rounded-circle {{p.genre}}
        {% endif %}">
        {{ p.nom }} - {{ p.pays.nom }} - Age : {{ p.age }} - Genre : {{p.genre}}</li>
    {% empty %}
        <li>Aucun président enregistré.</li>
    {% endfor %}
    </ul>

    
{% endblock content %} 

EOF

# fichier views
views="$app_name/views.py"
    cat <<EOF > $views
from django.shortcuts import render
from django.shortcuts import render, redirect
from .models import Pays, President
from .forms import PaysForm, PresidentForm


def index(request):
    if request.method == 'POST':
        pays_form = PaysForm(request.POST)
        president_form = PresidentForm(request.POST, request.FILES)

        if pays_form.is_valid():
            pays_form.save()
            return redirect('index')

        if president_form.is_valid():
            president_form.save()
            return redirect('index')
    else:
        pays_form = PaysForm()
        president_form = PresidentForm()

    pays = Pays.objects.all()
    presidents = President.objects.all()
    context = {
        'pays_form': pays_form,
        'president_form': president_form,
        'pays': pays,
        'presidents': presidents
    }
    return render(request, '$app_name/index.html', context)

EOF
# fichier forms
forms="$app_name/forms.py"
    cat <<EOF > $forms
from django import forms
from .models import Pays, President

class PaysForm(forms.ModelForm):
    class Meta:
        model = Pays
        fields = ('nom', 'population')


class PresidentForm(forms.ModelForm):
    class Meta:
        model = President
        fields = ('nom', 'age', 'image', 'genre', 'pays')

EOF


# fichier models
models="$app_name/models.py"
    cat <<EOF > $models
from django.db import models

class Pays(models.Model):
    nom = models.CharField(max_length=255)
    population = models.IntegerField()

    def __str__(self):
        return self.nom


class President(models.Model):
    GENRE_CHOICES = (
        ('M', 'Homme'),
        ('F', 'Femme'),
    )

    nom = models.CharField(max_length=255)
    age = models.IntegerField()
    image = models.ImageField(upload_to='presidents/')
    genre = models.CharField(max_length=1, choices=GENRE_CHOICES)
    pays = models.ForeignKey(Pays, on_delete=models.CASCADE)

    def __str__(self):
        return self.nom
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
from django.conf import settings
from django.conf.urls.static import static
from $app_name import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.index ,name='index'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

EOF



if [ "$install_mysql" == "y" ]; then
    # Installation de mysqlclient
    pip install mysqlclient
fi


if [ "$install_seed" == "y" ]; then
    export DJANGO_SETTINGS_MODULE=$project_name.settings

    seed="$app_name/seed.py"
    touch "$seed"
    cat <<EOF > $seed
# from django_seed import Seed    
# from $app_name.models import Pays, President
# import random

# def run():
#     seeder = Seed.seeder()
    
#     # Seed pour le modèle Pays
#     seeder.add_entity(Pays, 5, {
#         'nom': lambda x: seeder.faker.country(),
#         'population': lambda x: seeder.faker.random_int(min=1000, max=1000000)
#     })

#     # Seed pour le modèle President
#     seeder.add_entity(President, 5, {
#         'nom': lambda x: seeder.faker.name(),
#         'age': lambda x: seeder.faker.random_int(min=30, max=80),
#         'genre': lambda x: seeder.faker.random_element(['M', 'F']),
#         'pays': lambda x: seeder.faker.random_element(Pays.objects.all())
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

# Installation de Pillow
python -m pip install Pillow

python manage.py makemigrations
python manage.py migrate
cd ../ 
pip freeze > requirements.txt
cd ./$project_name
# Lancement du serveur Django
python manage.py runserver
