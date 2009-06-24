# SimpleSEO

## Descripción

El objetivo de este plugin es centralizar la administración del SEO básico (title, keywords y description) en los distintos idiomas de una aplicación en un único fichero yml.

## Getting it

    $ script/plugin install git://github.com/nickel/simple_seo.git
    
## Uso

### Metatag & title

Para poner en funcionamiento el plugin necesitaremos definir en el layout el metodo _metatags_. Este método recibe opcionalmente _title_, _title\_connector_ y _title\_reverse_.

* _title_ define un title global para toda la aplicación independiente al definido el fichero yml.
* _title\_connector_ define el conector entre el title global y el definido en el fichero.
* _title\_reverse_, con este parametro booleano podremos decidir en que orden van los titles antes explicados.

En _nuestro_ application.html.haml (o en _tu_ html.erb :), unos ejemplos:
    
    !!!
  
    %html
      %head
        = metatags
        or
        = metatags(:title => 'My master title', :title_connector => ' :: ')
        or
        = metatags(:title => 'My company', :title_connector => ' - ', :title_reverse => true)
        
      

### YML File

El fichero donde configuraremos el SEO de nuestro site debe estar en _config/seo.yml_.

### Default   

Si no definimos el SEO para un controlador/acción concreto, la información bajo _default_ será la seleccionada por defecto. Esta estrategia nos permite definir el SEO para todas aquellas páginas a las que no deseemos asignarle un SEO específico.

    default:
      keywords: "default keywords"

      en:
        title: I need my seo, dear web developer
        keywords: "more keywords"
      es:
        title: Necesito mi seo, querido desarrollador web
      de:
        title: ...

### Static controller

Bajo _static_ podemos la lógica que utiliza la aplicación para servir contenido estático, en el caso que la aplicación usara este tipo de lógica. Un ejemplo: 

    static:
      controller: pages
      action: show
      view: name  # El parametro que indica el nombre del contenido estático.

    pages_quienes_somos:  # "controller_#{name}"
      keywords: "waps"
      
      en:
        ...
      es:
        ...

### Standard controller/action

Y por cada controlador/action añadiremos la siguiente configuración al fichero:

    welcome_index:
      keywords: "website, web, rails, ruby"

      en:
        title: Home
        keywords: "site, car"
        description: "This is a description"
      es:
        title: Inicio
        keywords: "sitio, coche"
        description: "Esto es una descripción"
      de:
        ...

### Otras opciones

Si tuviesemos que definer keywords de forma dinámica tenemos la posibilidad de definirlo con el método _add\_meta\_for_ en el controlador de la siguiente forma:

    def show
      add_meta_for(:keywords, :en => "yellow submarine", :es => "submarino amarillo")
      add_meta_for(:description, :en => "...", :es => "...")
    end

## License and copyright

This app is MIT licensed, wich basically means you can do whatever you want with it, and there's no warranty of any kind. Read the MIT-LICENSE file to get the details. However, if you like it I would like you to send me an e-mail letting me know, also I'd like to receive your feedback and suggestions.

Thanks!

(c) 2009, Juan Gallego (juan.gallego.iv AT gmail DOT com) [http://juan.gg](http://juan.gg)

