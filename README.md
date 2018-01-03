# ZHIK #

Zeinu Hizkuntza Interpreteen Kudeaketa - Gestión de Intérpretes de Lengua de Signos. Esta plataforma realizada en Ruby On Rails está diseñada para la Federación de Asociaciones de Personas Sordas del País Vasco - Euskalgorrak (http://euskal-gorrak.org).

## Instalación ##

### Requisitos ###

* OS: GNU/Linux, actualmente funcionando en Ubuntu GNU/Linux 16.04 - 64bits.
* Ruby: funcionando con 2.3.4 (utilizamos RBenv para controlar la versión de Ruby, pero cualquiera de tu gusto servirá).
* Rails 4.2.9, Hobo 2.2.6 y sus dependencias correspondientes (ver Gemfile).
* NGINX: 1.12 de los repositorios oficiales Ubuntu.
* Percona: 5.6 de los repositorios oficiales Ubuntu.
* ImageMagick: 6.8.9 de los repositorios oficiales Ubuntu.

### Instalación ###

Clona este repositorio en tu servidor de producción:
~~~~
git clone https://github.com/arkaitzz/sg_ils.git
~~~~

Instalar gemas necesarias, crear la estructura tmp y establecer tareas cron:
~~~~
cd sg_ils
bundle install --without development test

# Copia environment (ojo con default_url_options):
cp config/environment.rb.example config/environment.rb
vim config/environment.rb

# Copia application (establece la configuración del mailer):
cp config/application.rb.example config/application.rb
vim config/application.rb

# Copia static configuration (por defecto debería estar listo para usar):
cp config/initializers/static_configuration.rb.example config/initializers/static_configuration.rb
vim config/initializers/static_configuration.rb

# Copia database (por defecto debería estar listo para usar):
cp config/database.yml.example config/database.yml
vim config/database.yml

# Copia puma.rb (por defecto debería estar listo para usar):
cp config/puma.rb.example config/puma.rb

export RAILS_ENV=production
bundle exec rake tmp:create
bundle exec rake tmp:extra_tmp_directories
bundle exec whenever --update-crontab --set environment='production'
~~~~

¡Instalación completada!

### Configuración ###

Configura database y compila assets:
~~~~
bundle exec rake db:setup
bundle exec rake assets:precompile
~~~~

¡Y listo!

~~~~
bundle exec rails s -e production
~~~~

## Ejecutar los Test ##

** TO-DO! **

## Servicios ##

** TO-DO! **

#### Tareas Cron ####

** TO-DO! **

#### Logrotate ####

** TO-DO! **

#### rc.local ####

** TO-DO! **

## Notes ##

** TO-DO! **

## Licencia y créditos ##

** TO-DO! **


