# SimpleSEO

## Descripción

El objetivo de este plugin es centralizar la administración del SEO básico (title, keywords y description) en los distintos idiomas de nuestro site en un único fichero yml.

## Getting it

    $ script/plugin install git://github.com/nickel/simple_seo.git
    
## Uso

### Metatag & title

Para poner en funcionamiento el plugin necesitaremos definir en el layout el metodo _metatags_. Este método recibe opcionalmente un _title_ global que formará parte siempre del title de todo el site. Además definir el _title\_connector_ para enlazar ambos titles, el global y el definido en el yml o alterar el orden de los mismos con _title\_reverse_ a **true**.

En _nuestro_ application.html.haml (o en _tu_ html.erb :)
    
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

Si no definimos el SEO para un controlador/acción concreto, la información bajo _default_ será la seleccionada. Esta estrategia nos permite definir el SEO para todas aquellas páginas a las que no deseemos asignarle un SEO específico.

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

Bajo _static_ podemos definir el controlador, la acción y el parámetro (view: name) que la aplicación utiliza para servir contenido estático, en el caso que la aplicación usara este tipo de lógica. Un ejemplo: 

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

Y por cada controlador/action estandar añadiremos la siguiente configuración al fichero:

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

Si tuviesemos que definer keywords de forma dinámica tenemos la posibilidad de definirlo con el método _add\_meta\_for_ en el controlador  de la siguiente forma:

    def index
      add_meta_for(:keywords, :en => "yellow submarine", :es => "submarino amarillo")
      add_meta_for(:description, :en => "...", :es => "...")
    end

## License and copyright

This app is MIT licensed, wich basically means you can do whatever you want with it, and there's no warranty of any kind. Read the MIT-LICENSE file to get the details.

However, if you like it I would like you to send me an e-mail letting me know, also I'd like to receive your feedback and suggestions.

Thanks!

(c) 2009, Juan Gallego (juan.gallego.iv AT gmail DOT com) http://juan.gg

