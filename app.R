# install.packages("shiny")

library(shiny)
claritaUI <- function(id) {
  ns <- NS(id)
  tagList(
    textInput(ns("pregunta"), "Tema o concepto a consultar", ""),
    actionButton(ns("consultar"), "Enviar"),
    uiOutput(ns("respuesta_ui"))
  )
}
# Valores reactivos
pizarra <- reactiveValues(
  tema = "",
  ideas = character()
)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      /* --- Ajustes generales de texto y colores --- */
      body {
        font-size: 18px;
        line-height: 1.45;
        background-color: #f9f9f9;
        margin: 0 !important;
        padding: 0 !important;
      }

      h1, h2, h3, h4 {
        color: #003366;
        font-weight: 700;
        margin-top: 0.6em;
        margin-bottom: 0.4em;
      }

      table, th, td, label, .control-label {
        font-size: 17px;
      }

      /* --- Forzar ancho completo de pantalla (ideal para Zoom) --- */
      .container-fluid {
        max-width: 100% !important;
        width: 100% !important;
        padding-left: 10px !important;
        padding-right: 10px !important;
        margin: 0 auto !important;
      }

      .tab-content, .content {
        padding: 20px 24px;
        margin: 0 !important;
      }

      /* --- Mejoras visuales para iframes y formularios --- */
      iframe {
        border-radius: 12px;
        min-height: 450px;
        width: 100% !important;
      }

      .shiny-input-container input,
      .shiny-input-container textarea {
        font-size: 17px !important;
      }

      /* --- Pestañas más anchas --- */
      .nav-tabs {
        margin-left: 10px;
        margin-right: 10px;
      }
      /* === PALETA VISUAL PARA VIDEOLLASE === */

/* Fondo general: blanco cálido (no puro) */
body {
  background-color: #f5f7fa !important; /* azul muy claro */
  color: #222222;                       /* texto gris oscuro legible */
}

/* Paneles y cajas */
.well, .panel, .card, .sidebar-panel {
  background-color: #ffffffcc;  /* blanco con un poco de transparencia */
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  border: 1px solid #e0e0e0;
  padding: 15px;
}

/* Botones */
.btn {
  background-color: #007bff !important;  /* azul intenso */
  color: white !important;
  border: none !important;
  font-weight: 600;
  transition: 0.3s;
}
.btn:hover {
  background-color: #0056b3 !important;  /* tono más oscuro al pasar el mouse */
}

/* Inputs, selectores, áreas de texto */
input, textarea, select {
  background-color: #ffffff;
  border: 1px solid #cccccc;
  border-radius: 6px;
  padding: 6px 8px;
}

/* Encabezados */
h1, h2, h3, h4 {
  color: #003366; /* azul institucional */
}

/* Pestañas */
.nav-tabs > li > a {
  background-color: #e9eef5;
  color: #003366;
  border-radius: 6px 6px 0 0;
  font-weight: 600;
}
.nav-tabs > li.active > a {
  background-color: #ffffff;
  color: #007bff;
  border-bottom: 2px solid #007bff;
}

/* Tab content */
.tab-content {
  background-color: #ffffff;
  border-radius: 0 0 10px 10px;
  padding: 20px;
  border: 1px solid #e0e0e0;
}

    "))
  ),
  titlePanel("METODOLOGÍA DE LA INVESTIGACIÓN - FCS - Mag. José González"),
  
  tabsetPanel(
    # --- INICIO PIZARRA COLABORATIVA ---
    tabPanel("Pizarra colaborativa",
             sidebarLayout(
               sidebarPanel(
                 textInput("tema", "Tema:"),
                 actionButton("setTema", "Definir tema"),
                 tags$hr(),
                 textInput("idea", "Escribe tu idea:"),
                 actionButton("enviar", "Enviar"),
                 tags$hr(),
                 actionButton("borrar", "🧹 Borrar pizarra"),
                 br(),br(),
                 downloadButton("descargarPizarra", "💾 Descargar pizarra"),br(),br(),br(),
                 tags$hr(),
                 h4("Chatbot"),
                 claritaUI("clarita_pizarra")
                 
               ),
               mainPanel(
                 h3("TEMA DE LA CLASE:"),br(),
                 textOutput("temaActual"),
                 tags$hr(),br(),
                 h3("Ideas de los estudiantes:"),br(),
                 uiOutput("listaIdeas"),
                 br(),
                 br(),
                 br(),
                 # --- Apps embebidas ---
                 # tags$hr(),
                 # h3("📚 TALLER Y RECURSOS COMPLEMENTARIOS"),
                 # br(),
                 # br(),
                 # h4("📉 1. Investigaciones - Herramienta interactiva"),
                 # tags$iframe(
                 #   src = "https://joseclasederecho.shinyapps.io/appley19580/",
                 #   width = "100%",
                 #   height = "500px",
                 #   style = "border:none; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);"
                 # ),
                 # br(), br(),
                 # br(),
                 # h4("📉 2. Asuntos judiciales iniciados en 2024 - Herramienta interactiva"),
                 # tags$iframe(
                 #   src = "https://joseclasederecho.shinyapps.io/3Dplot/",
                 #   width = "100%",
                 #   height = "500px",
                 #   style = "border:none; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);"
                 # ),
                 # br(), br(),
                 # br(),
                 # h4("📉 3. Metodología - Herramienta interactiva"),
                 # tags$iframe(
                 #   src = "https://joseclasederecho.shinyapps.io/metodologia/",
                 #   width = "100%",
                 #   height = "500px",
                 #   style = "border:none; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);"
                 # ),
                 # br(),
                 # br(),
                 # h4("📉 4. Hipótesis - Herramienta interactiva"),
                 # tags$iframe(
                 #   src = "https://joseclasederecho.shinyapps.io/hipotesis/",
                 #   width = "100%",
                 #   height = "500px",
                 #   style = "border:none; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1);"
                 # ),
                 br(), br(),
                 
                 tags$hr(),
                 h4("Recursos complementarios:"),
                 tags$ul(
                   
                   tags$li(
                     tags$a(href = "https://shiny-app-rsks.onrender.com/", 
                            target = "_blank", 
                            "1. Taller Investigaciones - Herramienta interactiva")),           
                   
                   tags$li(
                     tags$a(href = "https://hipocs.onrender.com/", 
                            target = "_blank", 
                            "2. Hipotesis - Herramienta interactiva")),
                   
                   
                   tags$li(
                     tags$a(href = "https://joseclasederecho.shinyapps.io/3Dplot/", 
                            target = "_blank", 
                            "3. Taller Indicadores - Herramienta interactiva")),
                   
                   tags$li(
                     tags$a(href = "https://joseclasederecho.shinyapps.io/appley19580/", 
                            target = "_blank", 
                            "4. Taller Investigaciones  - Herramienta interactiva"))

                   
                   )))
             
             
             
             
    ),
    # --- FIN PIZARRA COLABORATIVA ---nnnnnnnnn
    # --------------------------
    # CAPÍTULO I
    # --------------------------
    tabPanel("Epistemología y Metodología",
             h3("La articulación del campo epistemológico y metodológico"),
             p("La coherencia entre teoría (epistemología) y herramientas (metodología) es esencial en la investigación científica."),
             
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Ciencia: Conjunto de conocimientos obtenidos mediante la observación y el 
razonamiento, sistemáticamente estructurados y de los que se deducen principios y leyes generales."),
               br(),
               tags$li("Método: Procedimiento que se sigue en las ciencias para hallar la verdad y 
enseñarla. 'El «método científico» es utilizado en el proceso de la investigación social para 
obtener nuevos conocimientos en el campo de la realidad social, o bien estudiar una 
situación para diagnosticar necesidades y problemas a efectos de aplicar los conocimientos con fines prácticos' (Batthyány et al., 2011)."),
               br(),
               tags$li("Epistemología: estudio del conocimiento y su validez. 'La epistemología se define como el análisis del conocimiento científico. En términos más específicos, esta disciplina analiza los supuestos 
filosóficos de las ciencias, su objeto de estudio, los valores implicados en la creación 
del conocimiento, la estructura lógica de sus teorías, los métodos empleados en la 
investigación y en la explicación o interpretación de sus resultados' (Batthyány et al., 2011)."),
               br(),
               tags$li("Metodología: estrategias y procedimientos para producir conocimiento. 'La metodología está conformada por procedimientos o métodos para la construcción de la evidencia empírica. Se apoya en los paradigmas, y su función en 
la investigación es discutir los fundamentos epistemológicos del conocimiento. 
Específicamente, reflexiona acerca de los métodos que son utilizados para generar 
conocimiento científico y las implicancias de usar determinados procedimientos (Batthyány et al., 2011)'. "),
               br(),
               tags$li("Proceso de investigación: La investigación social es un proceso de generación de conocimiento, una actividad que nos permite obtener conocimientos científicos. Se inicia con las primeras 
preguntas que nos hacemos, la búsqueda bibliográfica, el análisis de los marcos 
teóricos y los conceptos, hasta llegar a la formulación del problema de investigación 
y el diseño necesario para indagar ese problema (Batthyány et al., 2011)."),
               br(),
               tags$li("Proyecto de investigación: La investigación social implica la formulación de un proyecto en el cual se explicitan todos los elementos involucrados en el proceso de investigación, desde la 
formulación del problema a investigar hasta los caminos que recorrerá para estudiar 
ese problema empíricamente (Batthyány et al., 2011)."),
               br(),
               tags$li("La articulación asegura consistencia entre lo que se investiga y cómo se investiga."),
               br(),
               tags$li("En las Ciencias Sociales: evita incoherencias entre el marco teórico y la técnica de análisis.")
               ),
               br(),
             
             h4("Tipos de conocimiento"),
             br(),
             tags$li("'El conocimiento es un modo más o menos 
organizado de concebir el mundo y de dotarlo de características que resultan en 
primera instancia de la experiencia personal del sujeto que conoce. El conocimiento 
que una persona adquiere de la realidad diferirá en función de cómo aborde dicha 
realidad (Batthyány et al., 2011)'."),
             br(),
             tags$li("'Es posible distinguir al menos dos tipos de conocimiento: el cotidiano, espontáneo o vulgar, y el científico. El primero de ellos se adquiere sin ningún proceso 
planificado y sin la utilización de medios especialmente diseñados. Por su parte, 
el conocimiento científico exige mayor rigor para encontrar regularidades en los 
fenómenos, para describirlos, comprenderlos, explicarlos y/o predecirlos. Se obtiene mediante procedimientos metódicos con pretensión de validez, utilizando la 
reflexión, los razonamientos lógicos y respondiendo a una búsqueda intencionada, 
para lo cual se delimitan los objetos y se prevén los modelos de investigación (Batthyány et al., 2011)'."),
             br(),
             h4("Comparación entre conocimiento cotidiano y conocimiento científico:"),
             # Tabla jurídica
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Características del conocimiento cotidiano:", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Características del conocimiento científico:", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Sensitivo, superficial, subjetivo, dogmático, particular, asistemático,  inexacto, no acumulativo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Crítico (fundamentado),  metódico, verificable, sistemático, unificado, ordenado, universal, objetivo, comunicable, provisorio", style = "border: 1px solid black; padding: 6px;")
                 
               ),
               
             ),
             br(),
             h4("Etapas o momentos de toda investigación empírica"),
             br(),
             tags$li("Ruptura: romper con prejuicios y la ilusión del saber inmediato. Pasar del problema social al problema propio de la disciplina.
"),
             br(),
             
             tags$li("Elección del tema y conformación de bibliografía."),
             
             br(),
             tags$li("Formulación del problema de interés que sea susceptible de estudio científico."),
             br(),
             tags$li("Construcción del marco conceptual (marco teórico, hipótesis y preguntas 
conceptuales o sustantivas)."),
             br(),
             tags$li("Construcción del marco operativo (formulación de las hipótesis de trabajo, 
operacionalización de conceptos en variables e indicadores)."),
             br(),
             tags$li("Elección de la estrategia metodológica: técnicas de recolección y análisis de 
datos."),
             br(),
             tags$li("Relevamiento de la información"),
             br(),
             tags$li("Análisis"),
             br(),
             tags$li("Presentación de resultados y conclusiones"),
             br(),
             
             
             
             h4("Quiz"),
             radioButtons("q1", "1) ¿Qué significa articular epistemología y metodología?",
                          choices = list(
                            "Combinar teorías sin conexión" = "a",
                            "Lograr coherencia entre teoría y método" = "b",
                            "Aplicar técnicas sin marco teórico" = "c"
                          ), selected = character(0)),
             radioButtons("q2", "2) ¿Qué ocurre si no hay coherencia?",
                          choices = list(
                            "Los resultados pueden ser inválidos" = "a",
                            "Aumenta la validez" = "b",
                            "No cambia nada" = "c"
                          ), selected = character(0)),
             actionButton("submit2", "Responder"),
             textOutput("feedback2"),
             br(),
             h4("Actividad práctica"),
             p("Caso: Una investigación sobre corrupción judicial se limita a encuestas de opinión."),
             actionButton("sol2", "Ver respuesta sugerida"),
             textOutput("resp2"),
             br(),
          tags$hr(),
             h4("Recursos complementarios:"),
             tags$ul(
               tags$li(
                 tags$a(href = "https://taller-epi-met-1.onrender.com/", 
                        target = "_blank", 
                        "1. Taller")
               ),
                            
               
             )
    ),

    # --------------------------
    # CAPÍTULO II
    # --------------------------
    tabPanel("Tema y Problema",
             h3("El tema y el problema de investigación"),
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Tema: campo general de estudio. Puede surgir de preocupaciones sociales,
 demandas institucionales o motivaciones personales. Requiere delimitación conceptual."),
               tags$li("Ejemplo Tema en Ciencias Sociales: “La violencia doméstica en Uruguay”."),
               br(),
               tags$li("Problema: pregunta concreta que guía la investigación. El problema es la problematización de un aspecto específico del tema. Se traduce en preguntas de
 investigación u objetivos concretos. Requiere delimitación conceptual, temporal y empírica, y
 disponibilidad de información."),
               tags$li("Ejemplo: ¿Qué factores explican la baja tasa de denuncias en casos de violencia doméstica en
 Montevideo entre 2018 y 2022?"),
               br(),
               tags$li("Esquema de construcción: Tema amplio → Preguntas iniciales → Problematización → Formulación del problema"),
               br(),
               tags$li("Un buen problema debe ser original, factible y verificable."),
               br(),
               tags$li("En Ciencias Sociales: puede surgir de desigualdades estructurales o dinámicas comunitarias."),
               br(),
               tags$li("Ejemplos aplicados a las Ciencias Sociales:"),
               br(),
               tags$li("1. Tema: Desigualdad educativa."),
               tags$li("Problema: Impacto del nivel socioeconómico en el acceso a la educación superior (2015-2023)."),
               br(),
               tags$li("2. Tema: Género y trabajo."),
               tags$li("Problema: Efectos de la brecha salarial en mujeres jóvenes (2012-2022)."),
               br(),
               tags$li("3. Tema: Participación comunitaria."),
               tags$li("Problema: Factores que limitan la participación de jóvenes en organizaciones barriales (2019-2023)."),
               br(),
               tags$li("Recordemos:"),
               tags$li("- El tema es el punto de partida, amplio y general."),
               tags$li("- El problema delimita, hace viable y científico el estudio."),
               tags$li("- No hay problema de investigación sin teoría, preguntas y datos."),
               
             ),
             
             h4("Quiz"),
             radioButtons("q3", "3) ¿Cuál es un problema de investigación?",
                          choices = list(
                            "La violencia doméstica en Uruguay" = "a",
                            "¿Cómo incide la Ley 19.580 en la reducción de casos de violencia de género?" = "b",
                            "Los jueces aplican normas" = "c"
                          ), selected = character(0)),
             radioButtons("q4", "4) ¿Qué característica NO debe tener un problema de investigación?",
                          choices = list(
                            "Ser verificable" = "a",
                            "Ser relevante" = "b",
                            "Ser completamente subjetivo" = "c"
                          ), selected = character(0)),
             actionButton("submit3", "Responder"),
             textOutput("feedback3"),
             
             br(),
             h4("Actividad práctica individual: 'Acceso a la justicia'"),
             p("Ejercicio:  Formula 1 posible problema de investigación vinculados a este tema."),
             p("Pistas:"),
             p("- Población: personas de bajos ingresos, mujeres, migrantes, minorías, etc."),
             p("- Instituciones: defensa pública, juzgados laborales, juzgados de familia, etc."),
             p("- Tiempo: periodo 2018-2023, 2010-2020, etc."),
             actionButton("sol3", "Ver respuesta sugerida"),
             textOutput("resp3"),
             
             br(),
             h4("Actividad grupal"),
             p("Ejercicio: Elegir un tema amplio en Ciencias Sociales, formular 3 problemas de investigación."),
             p("Responder:  ¿Qué quiero saber?"),
             p("Responder:  ¿A quiénes afecta?"),
             p("Responder:  ¿Dónde y cuándo?"),
             p("Responder:  ¿Con qué información puedo responderlo?"),
             
             br(),
             h4("Actividad grupal y/o individual entregable"),
             p("Tema 1: Desigualdad educativa"),
             p("Ejercicio:  formular 2 problemas de investigación abordables desde las ciencias sociales."),
             p("Pistas:"),
             p("- Diferencias en acceso a educación superior."),
             p("- Brechas de género en logros educativos."),
             p("- Impacto del nivel socioeconómico en la permanencia estudiantil."),
             p("Responder:  ¿Qué quiero saber?"),
             p("Responder:  ¿A quiénes afecta?"),
             p("Responder:  ¿Dónde y cuándo?"),
             p("Responder:  ¿Con qué información puedo responderlo?"),
             p("Ejemplo: ¿Cuál ha sido el impacto del nivel socioeconómico en la permanencia de estudiantes en educación secundaria en Uruguay entre 2015 y 2022?"),
             
             br(),
             p("Tema 2: Género y trabajo"),
             p("Ejercicio:  formular 2 problemas de investigación abordables desde las ciencias sociales."),
             p("Pistas:"),
             p("- Brecha salarial entre hombres y mujeres."),
             p("- Acceso de mujeres jóvenes a empleos de calidad."),
             p("- Conciliación entre trabajo y vida familiar."),
             p("Responder:  ¿Qué quiero saber?"),
             p("Responder:  ¿A quiénes afecta?"),
             p("Responder:  ¿Dónde y cuándo?"),
             p("Responder:  ¿Con qué información puedo responderlo?"),
             p("Ejemplo: ¿En qué medida la brecha salarial afecta las oportunidades de inserción laboral de mujeres jóvenes en Montevideo entre 2017 y 2022?"),
             
             br(),
             p("Tema 3: Participación comunitaria"),
             p("Ejercicio:  formular 2 problemas de investigación abordables desde las ciencias sociales."),
             p("Pistas:"),
             p("- Factores que promueven o limitan la participación juvenil."),
             p("- Rol de las organizaciones barriales."),
             p("- Influencia de las redes sociales en la participación."),
             p("Responder:  ¿Qué quiero saber?"),
             p("Responder:  ¿A quiénes afecta?"),
             p("Responder:  ¿Dónde y cuándo?"),
             p("Responder:  ¿Con qué información puedo responderlo?"),
             p("Ejemplo: ¿Qué factores explican la baja participación de jóvenes en organizaciones comunitarias en barrios periféricos de Montevideo entre 2018 y 2023?"),
             
             br(),
             p("Tema 4: Migración y políticas públicas"),
             p("Ejercicio:  formular 2 problemas de investigación abordables desde las ciencias sociales."),
             p("Pistas:"),
             p("- Integración de migrantes en el mercado laboral."),
             p("- Acceso a servicios de salud y educación."),
             p("- Percepción social sobre la migración."),
             p("Responder:  ¿Qué quiero saber?"),
             p("Responder:  ¿A quiénes afecta?"),
             p("Responder:  ¿Dónde y cuándo?"),
             p("Responder:  ¿Con qué información puedo responderlo?"),
             p("Ejemplo: ¿Cómo han impactado las políticas públicas en la integración laboral de migrantes en Uruguay entre 2010 y 2020?"),
             
             br(),
             tags$hr(),
             h4("Recursos complementarios:"),
             tags$ul(
               tags$li(
                 tags$a(href = "https://taller-tema-pro.onrender.com/", 
                        target = "_blank", 
                        "2. Taller")
               ),
               
               
             )
    ),
    
    # --------------------------
    # CAPÍTULO IV
    # --------------------------
    tabPanel("Marco Teórico",
             h3("El marco teórico"),
             h4("Conceptos clave"),
             tags$ul(
               tags$li("El marco teórico constituye un eje central en la investigación. Aporta los
 conceptos, teorías y antecedentes que permiten fundamentar el problema de investigación, diseñar hipótesis y orientar la recolección y análisis de datos. Es una elaboración propia que toma como insumos la teoría y la lectura de otro tipo de documentos, así como la 
propia reflexión. La teoría permite procesar la ruptura epistemológica con el sentido común y estructurar el objeto de estudio. Guía la
 investigación en todas sus etapas."),
               tags$li("Relaciona la investigación con estudios previos. 'Elaborar el marco teórico implica «analizar y exponer las teorías, 
los enfoques teóricos, las investigaciones y los antecedentes en general, que se consideren válidos para el correcto encuadre del estudio» (Rojas, 2001, en Hernández 
Sampieri, 2003).'"),
               tags$li("Evita duplicación y orienta hacia vacíos del conocimiento."),
               tags$li("En Ciencias Sociales: analiza teorías, enfoques y debates académicos sobre fenómenos sociales."),
               tags$li("Ejemplo en Ciencias Sociales: Al investigar sobre desigualdad educativa, 
el marco teórico puede basarse en la teoría del capital cultural de Bourdieu, 
que conceptualiza la educación como un espacio donde se reproducen desigualdades 
sociales más allá de los logros individuales."),
               tags$li("Funciones del M.T. en el proceso de investigación: conduce a la formulación de hipótesis que serán contrastadas empíricamente, proporciona los principales conceptos que luego serán operacionalizados, orienta sobre cómo se realizará la investigación, es decir, sobre la estrategia 
de la investigación, orienta la metodología inndicando variables a observar y medir, provee de un marco interpretativo a los resultados de la investigación (Hernández Sampieri, 2003)."),
               tags$li("Teoría: La idea de teoría o de qué es la teoría cuando se la define en el contexto de una investigación, impregna la totalidad del diseño, incluyendo obviamente la construcción 
del marco y los supuestos teóricos que sostienen la utilización de modelos estadísticos o una estrategia cualitativa de análisis (Sautu, 2005: 42)."),
               br(),
               tags$li("Conceptos: Los conceptos provienen y forman parte de la teoría por lo tanto son abstracciones. En el marco de la elaboración de un proyecto de investigación hay una apropiación de determinados conceptos a partir de los cuales se construye el objeto de 
investigación (Batthyány et al., 2011). Los conceptos son representaciones abstractas de una realidad observable, son 
instrumentos para expresar una representación mental de la realidad (op. cit.)")
             ),
             tags$li("Diferencias entre Marco Teòrico, Marco Conceptual y Antecedentes (ver siguiente tabla)"),
             
             # Tabla en Ciencias Sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Nivel", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Ejemplo en Ciencias Sociales", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Marco Teórico", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Teorías de la reproducción social y del capital cultural (Bourdieu)", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Marco Conceptual", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Conceptos: 'desigualdad educativa', 'capital social'", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Antecedentes", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Investigaciones previas sobre acceso a educación superior y participación comunitaria en Uruguay", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(),br(),
             
             h4("Quiz"),
             radioButtons("q5", "5) ¿Cuál es la función principal del marco teórico?",
                          choices = list(
                            "Justificar y contextualizar el problema" = "a",
                            "Sustituir los resultados" = "b",
                            "Evitar formular hipótesis" = "c"
                          ), selected = character(0)),
             actionButton("submit4", "Responder"),
             textOutput("feedback4"),
             br(),br(),
             h4("Actividad práctica"),
             p("Caso: Estudias sobre el Medio Ambiente. Identifica tres conceptos clave."),
             actionButton("sol4", "Ver respuesta sugerida"),
             textOutput("resp4"),
             br(),
             h4("Actividad práctica grupal 1"),
             p("Identifica tres conceptos clave en temas como: Desigualdad educativa, Género y trabajo, Participación comunitaria, Migración, Políticas sociales u otros de tu interés."),
             br(),
             h4("Actividad práctica grupal domiciliaria entregable"),
             p("Construye un marco teórico para el tema elegido."),
             br(),
             tags$hr(),
             h4("Recursos complementarios:"),
             tags$ul(
               tags$li(
                 tags$a(href = "https://taller-marco.onrender.com/", 
                        target = "_blank", 
                        "3. Taller")
               ),
               
               
             )
    ),
    
    # --------------------------
    # CAPÍTULO IV
    # --------------------------
    tabPanel("Objetivos y Diseño",
             h3("Objetivos y diseño de investigación"),
             br(),
             h4("Objetivos"),
             tags$ul(
               tags$li("Los objetivos constituyen la guía del proceso de investigación. Permiten definir el rumbo
 del estudio, orientar las decisiones metodológicas y evaluar los resultados obtenidos. En
 Ciencias Sociales, los objetivos se relacionan con la
 formulación del problema y con el diseño de investigación."),
               tags$li("Objetivo general: propósito amplio."),
               tags$li("Objetivos específicos: pasos concretos."),
               tags$li("Ejemplo en Ciencias Sociales: Si se investiga la desigualdad educativa, 
un objetivo general puede ser: Analizar el impacto del nivel socioeconómico en el acceso a la educación superior. 
Un objetivo específico: Examinar las diferencias en la tasa de ingreso a la universidad entre estudiantes de distintos estratos sociales en Montevideo entre 2015 y 2023."),
               
               br(),
               
               tags$li("Funciones de los objetivos (Ver siguiente tabla)"),
               
               # Tabla jurídica
               tags$table(
                 style = "width:100%; border-collapse: collapse; margin-top: 10px;",
                 # Encabezado
                 tags$tr(
                   tags$th("Función", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                   tags$th("Descripción", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
                 ),
                 # Fila 1
                 tags$tr(
                   tags$td("Orientar", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("Marcan la dirección de la investigación.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 2
                 tags$tr(
                   tags$td("Precisar", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("Definen el alcance del estudio.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 3
                 tags$tr(
                   tags$td("Operacionalizar", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("Transforman el problema en acciones investigables.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 4
                 tags$tr(
                   tags$td("Evaluar", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("Permiten medir si se alcanzaron los resultados.", style = "border: 1px solid black; padding: 6px;")
                 )
               ),
               br(),
               tags$li("Tipos de objetivos (Ver siguiente tabla)"),
               
               # Tabla jurídica
               tags$table(
                 style = "width:100%; border-collapse: collapse; margin-top: 10px;",
                 # Encabezado
                 tags$tr(
                   tags$th("Tipos", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                   tags$th("Funciòn", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
                 ),
                 # Fila 1
                 tags$tr(
                   tags$td("Objetivo general:", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("expresar la finalidad global de la investigación.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 2
                 tags$tr(
                   tags$td("Objetivos específicos:", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("descomponer el objetivo general en pasos concretos.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 3
                 tags$tr(
                   tags$td("Objetivos exploratorios:", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("orientar a conocer fenómenos poco estudiados.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 4
                 tags$tr(
                   tags$td("Objetivos descriptivos:", style = "border: 1px solid black; padding: 6px;"),
                   tags$td("buscan caracterizar hechos, procesos o instituciones.", style = "border: 1px solid black; padding: 6px;")
                 ),
                 # Fila 5
                 tags$tr(
                   tags$td("Objetivos explicativos:", style = "border: 1px solid black; padding: 6px;"),
                   tags$td(" buscan identificar causas y consecuencias de un fenómeno.", style = "border: 1px solid black; padding: 6px;")
                 )
               ),
               br(),
               tags$li("Ejemplo en Ciencias Sociales: En un estudio sobre desigualdad educativa: - Objetivo general: 
Explicar los factores que inciden en la permanencia de estudiantes en educación secundaria. 
Objetivo específico: Analizar la relación entre nivel socioeconómico y tasa de abandono escolar."),
               br(),
               tags$li("Relación de los objetivos con el diseño de investigación:"),
               tags$li("Los objetivos no son independientes del diseño metodológico: - Definen si la investigación 
será cualitativa, cuantitativa o mixta. - Orientan la selección de técnicas de recolección de 
datos. - Determinan el nivel de profundidad del análisis."),
               br(),
               tags$li("Ejemplo en Ciencias Sociales: En un estudio sobre participación comunitaria: - Si el objetivo 
es describir niveles de participación juvenil, se aplicará un diseño descriptivo con encuestas y 
observación. - Si el objetivo es explicar causas de baja participación, se requerirá un diseño 
explicativo con entrevistas en profundidad y análisis documental."),
               br(),
               tags$li("La definición de objetivos transforma el problema en un plan de acción. Un buen objetivo
 es claro, preciso y viable. Su correcta formulación asegura que la investigación tenga coherencia
 metodológica y relevancia social."),
               br(),
               h4("Diseño"),
               br(),
               tags$ul(
                 tags$li("Diseño: El diseño de la investigación es el plan y la estructura de esta, concebidos de 
manera tal que se puedan obtener respuestas a las preguntas de investigación. Es el plan que guía la contrastación empírica de las hipótesis (Batthyány et al., 2011)."),
                 br(),
                 h4("Tipos de diseño"),
                 br(),
                 tags$li("De acuerdo a los objetivos de la investigación, el diseño puede ser exploratorio, 
descriptivo, explicativo, predictivo y evaluativo. De acuerdo al tipo de estudio de 
que se trate variará la estrategia de investigación. El diseño, los datos que se recolectan, la manera de obtenerlos, el muestreo y otros componentes del proceso 
de investigación son distintos en función del tipo de objetivos de la investigación: 
exploratorios, descriptivos, explicativos, etcétera (Batthyány et al., 2011)."),
                 br(),
                 tags$li("En Ciencias Sociales: definir si se estudiará teoría, prácticas sociales o impacto comunitario.")
               )),
             br(),
             h4("Quiz"),
             radioButtons("q6", "6) ¿Qué diferencia hay entre objetivo general y específicos?",
                          choices = list(
                            "El general es amplio, los específicos son pasos concretos" = "a",
                            "No hay diferencia" = "b",
                            "Los específicos reemplazan al general" = "c"
                          ), selected = character(0)),
             actionButton("submit5", "Responder"),
             textOutput("feedback5"),
             br(),
             h4("Actividad práctica"),
             p("Formula un objetivo general y dos específicos sobre violencia domestica ."),
             p("Identifica cada objetivo de acuerdo a su tipo"),
             actionButton("sol5", "Ver respuesta sugerida"),
             textOutput("resp5"),
             br(),
             h4("Actividad práctica grupal"),
             p("Formula un objetivo general y dos específicos sobre Desigualdad educativa, Género y trabajo, Participación comunitaria, Migración, Políticas sociales u otro tema de tu interés."),
             p("Identifica cada objetivo de acuerdo a su tipo"),
             br(),
             h4("Actividad grupal domiciliaria entregable"),
             p("Formula un diseño de investigación con objetivo general y específicos sobre Desigualdad educativa, Género y trabajo, Participación comunitaria, Migración, Políticas sociales u otro tema de tu interés."),
             br(),
             tags$hr(),
             h4("Recursos complementarios:"),
             tags$ul(
               tags$li(
                 tags$a(href = "https://taller-obj.onrender.com/", 
                        target = "_blank", 
                        "4. Taller")
               ),
               
               
             )
    ),

    
    # --------------------------
    # CAPÍTULO V
    # --------------------------
    tabPanel("Hipótesis",
             h3("Las Hipótesis"),
             br(),
             tags$li("Una vez formulado el problema de investigación a partir del marco teórico y 
del grado de conocimiento del fenómeno de estudio, se plantea una respuesta anticipada y tentativa a la pregunta de investigación. Estas posibles respuestas son las 
hipótesis. Actualmente es indiscutible la utilidad que tiene el planteamiento de una 
o varias hipótesis durante el proceso de generación de conocimiento científico (Batthyány et al., 2011)."),
             tags$li("Son enunciados teóricos supuestos, no verificados pero probables, referentes a variables o 
relaciones entre variables (Sierra Bravo, 1987: 49 y 69)."),
             tags$li("Las hipótesis representan predicciones o respuestas probables a los interrogantes que 
el investigador formula, ante un conocimiento previo, para su contrastación empírica 
(Cea D’Ancona, 1996: 70)."),
             tags$li("Etimológicamente el término hipótesis tiene su origen en los términos griegos hipo que significa 
debajo y thesis que significa lo que se pone. Hipótesis literalmente significa entonces lo que se 
pone por debajo o se supone (Sierra Bravo, 1987: 69)."),
             br(),
             h4("Respuesta tentativa a la pregunta de investigación"),
             br(),
             tags$li("Las hipótesis se desprenden del marco teórico que le da sustento a la investigación y hasta tanto no sean sometidas a prueba (contrastación empírica) no se validarán ni rechazarán. Por ello, debe existir una estrecha relación entre el marco teórico, 
el problema de investigación y las hipótesis (Batthyány et al., 2011)."),
             tags$li("En tanto es una respuesta tentativa, la hipótesis tiene un carácter de provisionalidad, de conjetura verosímil, de suposición. Siguiendo a Corbetta (2007:72) la hipótesis es «una afirmación provisoria que se debe comprobar, derivada de la teoría, 
pero que precisa su comprobación empírica para poder confirmarse» (Batthyány et al., 2011)."),
             br(),
             h4("Establecen una relación entre conceptos"),
             br(),
             tags$li("Los conceptos que aparecen en la hipótesis son los que se presentan en el problema y se definen en el marco teórico. La relación entre conceptos establecida en 
la hipótesis es la que se someterá a prueba con los datos.
 Es importante tener en cuenta que el centro de la investigación es la hipótesis y 
no los datos. Las hipótesis van más allá de los datos y guían la construcción de los 
mismos; en tal sentido muchas veces se mantiene la imagen de las hipótesis como 
brújula que guía la generación de conocimiento científico (Batthyány et al., 2011)."),
             br(),
             h4("Son oraciones o enunciados declarativos"),
             tags$li("La manera en la que se redacta o se escribe una hipótesis es la de una proposición simple. No son oraciones imperativas ni interrogativas ni exclamativas. Es una 
afirmación que puede ser verdadera o falsa (Batthyány et al., 2011). "),
             br(),
             h4("Características de una hipótesis"),
             br(),
             tags$li("Plausible: debe tener una estrecha relación con el fenómeno que se quiere 
estudiar y estar relacionada con el cuerpo teórico que la sustenta. En este caso, 
también se habla de la pertinencia de la hipótesis respecto al fenómeno a estudiar. 
Un claro planteamiento del problema de investigación y una revisión teórica adecuada, son condiciones fundamentales para la elaboración de hipótesis plausibles (Batthyány et al., 2011)."),
             tags$li("Contrastable: las hipótesis deben ser «contrastables mediante los procedimientos 
objetivos de la ciencia» (Bunge, 1997). Los términos de la hipótesis y la relación 
planteada entre ellos deben tener un referente empírico. La hipótesis es una conjetura, una suposición o solución probable que puede ser comprobada o rechazada 
durante una investigación empírica (Batthyány et al., 2011)."),
             tags$li("Refutable: La contrastación implica, además, que las hipótesis tienen que ser 
refutables por la experiencia, es decir, tiene que ser un enunciado cuya forma lógica 
permita rechazarlo cuando se lo pone a prueba (Batthyány et al., 2011)."),
             tags$li("Precisa: Debe formularse en términos claros y concretos evitando la ambigüedad y la confusión. Las hipótesis no deben contener términos imprecisos o generales ni contener términos valorativos o juicios de valor (Batthyány et al., 2011)."),
             tags$li("Comunicable. Debe ser comprendida de una sola y misma manera por todos los 
investigadores. La claridad con que se formule es fundamental, debido a que constituye una guía para la investigación (Batthyány et al., 2011)."),
             tags$li("General: El poder de explicación debe superar el caso individual. Las hipótesis 
no deben referirse a experiencias singulares, en tanto los datos aislados sirven para 
refutar o verificar hipótesis y no para establecerlas (Batthyány et al., 2011). "),
             br(),
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Las hipótesis son proposiciones tentativas que establecen relaciones entre variables,
 conceptos o fenómenos. Orientan la investigación, permiten anticipar respuestas y guían
 la recolección y análisis de datos."),
               tags$li("Hipótesis descriptivas, correlacionales, causales, nulas y alternativas."),
               tags$li("Orientan la recolección y análisis de datos."),
               tags$li("En Ciencias Sociales: permiten evaluar impacto de políticas públicas, prácticas sociales y dinámicas comunitarias.")
             ),
             br(),
             tags$li("Funciones de las hipótesis (Ver siguiente tabla)"),
             
             # Tabla jurídica
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Función", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Descripción", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Orientadora", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Señalan el rumbo del estudio.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Explicativa", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Plantean relaciones causales o correlacionales.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Operativa", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Transforman conceptos abstractos en variables medibles.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 4
               tags$tr(
                 tags$td("Verificadora", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Permiten contrastar empíricamente supuestos teóricos.", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(),
             tags$li("Ejemplo:"),
             tags$li("En un estudio sobre violencia doméstica, se plantea la hipótesis: La existencia
                     de equipos técnicos interdisciplinarios en juzgados de familia reduce el tiempo de
                     respuesta en la adopción de medidas cautelares."),
             br(),
             tags$li("Tipos de Hipótesis"),
             
             # Tabla jurídica
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Tipos", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("    ", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Hipótesis descriptivas:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("plantean características o frecuencia de fenómenos.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Hipótesis correlacionales:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("relacionan dos o más variables sin afirmar causalidad.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Hipótesis causales:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("explican relaciones de causa-efecto entre variables.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 4
               tags$tr(
                 tags$td("Hipótesis teóricas:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Son de mayor nivel de abstracción y se originan en una 
elaboración conceptual.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 5
               tags$tr(
                 tags$td("Hipótesis de trabajo:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Tienen un fundamento empírico.", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(),
             tags$li("Ejemplo: en un estudio sobre accreso a la justicia:"), 
             tags$li("Hipótesis descriptiva: La población de menores recursos de Salto percibe tener un menor acceso a la justicia"),
             tags$li("Hipótesis correlacional: La percepción de acceso a la justicia está asociada a la cantidad de jueces por departamento"),
             tags$li("Hipótesis causal: La menor cantidad de juzgados y jueces en Salto que en Montevideo causa un menor acceso a la justicia"),
             br(),
             tags$li("Elaboración de hipótesis"),
             tags$li(" Para formular hipótesis se requieren tres pasos principales:"),
             tags$li("1. Identificar variables relevantes a partir del marco teórico."),
             tags$li("2. Plantear relaciones claras, lógicas y verificables entre variables."),
             tags$li("3. Redactar la hipótesis de forma precisa y coherente con los objetivos del
 estudio."),
             br(),
             tags$li("Ejemplo:en un estudio sobre derechos humanos en cárceles:"),
             tags$li("Hipótesis: El hacinamiento carcelario incrementa la frecuencia de denuncias por tratos crueles e
                     inhumanos"),
             br(),
             h4("Quiz"),
             radioButtons("q7", "7) Ejemplo de hipótesis válida:",
                          choices = list(
                            "El acceso a defensa pública mejora el acceso a la justicia" = "a",
                            "La justicia es importante" = "b",
                            "Los juicios existen desde hace siglos" = "c"
                          ), selected = character(0)),
             actionButton("submit6", "Responder"),
             textOutput("feedback6"),
             br(),br(),
             h4("Actividad práctica"),
             p("Redacta una hipótesis sobre cantidad de juzgados y acceso a la justicia."),
             actionButton("sol6", "Ver respuesta sugerida"),
             textOutput("resp6"),
             br(),
             
             h4("Actividad práctica:  Educación"),
             p("Proponga una hipótesis correlacional entre nivel socioeconómico y acceso a la educación superior."),
             
             br(),
             h4("Actividad práctica grupal: Género y trabajo"),
             p("Redacta una hipótesis descriptiva sobre brechas salariales en mujeres jóvenes."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Participación comunitaria"),
             p("Elabore una hipótesis causal sobre la baja participación juvenil en organizaciones barriales y la falta de políticas públicas de incentivo."),
             br(),
             tags$hr(),
             h4("Recursos complementarios:"),
             tags$ul(
               tags$li(
                 tags$a(href = "https://hipocs.onrender.com/", 
                        target = "_blank", 
                        "5. Taller")
               ),
               
               
             )
    ),
    
    # --------------------------
    # CAPÍTULO VI
    # --------------------------
    tabPanel("Variables e Indicadores",
             h3("Variables, indicadores e índices"),
             br(),
             h4("Variables"),br(),
             tags$li(" Definición: Una variable es una propiedad o atributo que puede tomar diferentes valores y que se utiliza para
 estudiar relaciones. Se derivan del marco teórico y de los objetivos de investigación. Variable: Cualidad o característica de un objeto (o evento) que contenga al menos 
dos atributos (categorías o valores) en los que pueda clasificarse un objeto o evento 
determinado (Cea D’Ancona, 1996: 126)."),
             br(),
             tags$li("Tipos de variables"),
             
             # Tabla en Ciencias Sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Variables", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Ejemplo en Ciencias Sociales", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Según su naturaleza:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("cuantitativas (ej.: ingreso mensual) y cualitativas (ej.: género, ocupación).", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Según su rol:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("independientes (ej.: nivel educativo) y dependientes (ej.: participación política).", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Según su escala:", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("nominal (ej.: estado civil), ordinal (ej.: nivel socioeconómico), de intervalo (ej.: edad en rangos) y de razón (ej.: ingreso exacto).", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             h4("Operacionalización"),br(),
             tags$li("Proceso por el cual se realiza el pasaje de los conceptos (constructos teóricos) a las variables. La importancia de una correcta operacionalización se expresa por sí misma si las variables no pueden ser 
observadas y medidas en la realidad (Batthyány et al., 2011).  El proceso de operacionalización consiste en la transformación de conceptos y 
proposiciones teóricas en variables. En el extremo más abstracto de este proceso están los conceptos teóricos, y en el menos, los referentes empíricos directos o 
indicadores. Por ejemplo, algunas variables son directamente observables, como el sexo o el partido político que votó en las últimas elecciones nacionales. Existen 
conceptos más abstractos, como el estrato social o la calidad del empleo, que se encuentran más alejadas del plano empírico, por lo cual es necesario realizar un 
proceso de operacionalización que permita identificar variables para representar a los constructos teóricos (op. cit)."),
             br(),
             tags$li("Ejemplos de Variables según su rol en Ciencias Sociales"),
             
             # Tabla en Ciencias Sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Problema", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Variable Independiente", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Variable Dependiente", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Desigualdad educativa", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Nivel socioeconómico", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Acceso a educación superior", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Género y trabajo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Sexo de la persona trabajadora", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Nivel salarial", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Participación comunitaria", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Edad de los jóvenes", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Frecuencia de participación en organizaciones barriales", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             h4("Indicadores"),
             br(),
             tags$li("Definición: Un indicador es una medida observable y operacional de una variable. Dicha medida debe ser válida,
 confiable y pertinente. Los indicadores permiten cuantificar conceptos que, en principio, son abstractos.  Un indicador de una variable es otra variable que traduce la primera al plano empírico."),
             br(),
             tags$li("El principio de validez refiere a la capacidad de un indicador de representar adecuadamente el concepto que se supone intenta precisar y medir."),
             tags$li("El principio de confiabilidad implica que observaciones repetidas por el mismo observador deben producir los mismos datos"),
             tags$li("La pertinencia se refiere a que el indicador debe estar alineado con los objetivos de investigación."),
             br(),
             tags$li("Ejemplos de Indicadores en Ciencias Sociales"),
             # Tabla en Ciencias Sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Tema", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Variable", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Indicador", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Desigualdad educativa", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Nivel socioeconómico", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Porcentaje de estudiantes que acceden a educación superior según quintil de ingreso", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Género y trabajo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Sexo de la persona trabajadora", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Brecha salarial promedio entre hombres y mujeres", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Participación comunitaria", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Edad de los jóvenes", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Frecuencia de asistencia a reuniones barriales por grupo etario", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             h4("Índices"),
             br(),
             tags$li("Definición:  Los índices son indicadores complejos que resumen un conjunto de indicadores. Un índice combina varios indicadores en una sola medida compuesta. Se usa para resumir dimensiones
 múltiples (enfoque multidimensional). Para construir un índice se siguen pasos: selección de dimensiones, indicadores,
 normalización, ponderación y agregación."),
             br(),
             br(),
             tags$li("Ejemplo práctico: Índice simplificado de Desigualdad Educativa"),
             
             # Tabla en Ciencias Sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Pasos:", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Descripción", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("1. Selección de dimensiones", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Acceso a educación superior; permanencia en secundaria; brecha de género; nivel socioeconómico", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("2. Indicadores", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Porcentaje de ingreso a universidad; tasa de abandono escolar; diferencia en logros por género; distribución por quintiles de ingreso", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("3. Normalización", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Transformar cada indicador a escala 0-100", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 4
               tags$tr(
                 tags$td("4. Ponderación", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Asignar pesos según criterio (ej. 0.25, 0.25, 0.25, 0.25)", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 5
               tags$tr(
                 tags$td("5. Agregación", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Suma ponderada para obtener índice final (0-100)", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Variable: atributo medible."),
               tags$li("Indicador: expresión empírica de la variable."),
               tags$li("Índice: suma de indicadores."),
               tags$li("En C.S.: medir acceso a justicia = Nº defensores públicos/población departamental.")
             ),
             br(),br(),
             h4("Quiz"),
             radioButtons("q8", "8) ¿Qué diferencia hay entre variable e indicador?",
                          choices = list(
                            "La variable es abstracta, el indicador la mide" = "a",
                            "Son lo mismo" = "b",
                            "El indicador es más amplio que la variable" = "c"
                          ), selected = character(0)),
             actionButton("submit7", "Responder"),
             textOutput("feedback7"),br(),br(),
             
             h4("Actividad práctica"),
             p("Define indicadores para la variable 'igualdad de género en tribunales'."),
             actionButton("sol7", "Ver respuesta sugerida"),
             textOutput("resp7"),
             br(),br(),
             
             
             h4("Actividad individual: Desigualdad educativa"),
             p("Propuestas de indicadores cuantitativos y una escala ordinal para evaluar acceso y permanencia en educación."),
             
             br(),
             h4("Actividad grupal: Participación comunitaria"),
             p("Construyan un indicador compuesto para 'participación juvenil' usando 3 variables (asistencia a reuniones, 
organización de actividades, uso de redes sociales)."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Migración"),
             p("Propongan indicadores que permitan medir la integración de migrantes en el mercado laboral y en el acceso a servicios."),
             br(),
             tags$hr(),
             h4("Recursos complementarios:"),
             tags$ul(
               tags$li(
                 tags$a(href = "https://taller-var-ind.onrender.com/", 
                        target = "_blank", 
                        "6a. Taller")
               ),br(),
               
               tags$li(
                 tags$a(href = "https://joseclasederecho.shinyapps.io/3Dplot/", 
                        target = "_blank", 
                        "6b. Taller"))
               )
    ),
    
             
             
    ),
    
    # --------------------------
    # CAPÍTULO VII
    # --------------------------
    tabPanel("Unidades de Análisis",
             h3("Unidades de análisis y población"),br(),
             h4("Introducción"),br(),
             tags$li("En toda investigación, definir las unidades de análisis y la población es fundamental para garantizar la
 coherencia metodológica. Las unidades de análisis son los elementos concretos sobre los que se centra
 el estudio, mientras que la población refiere al conjunto total de dichas unidades."),
             br(),
             h4("Las Unidades de Análisis"),br(),
             tags$li("Unidades de análisis: Son los sujetos, casos u objetos concretos que se observan en la investigación.
 Pueden ser personas, instituciones, documentos, etc."),
             br(),
             tags$li("Ejemplos:"),
             br(),
             tags$ul(
               tags$li("Individuos: jóvenes en situación de desempleo."),
               tags$li("Instituciones: organizaciones comunitarias y centros educativos."),
               tags$li("Documentos: encuestas de hogares y estudios de opinión.")
               ),
             br(),
             h4("Población y Muestra"),br(),
             tags$li("La población es el conjunto total de unidades de análisis que comparten las características que se
 desea estudiar. Cuando no es posible estudiar a toda la población, se recurre a una muestra, que debe
 ser representativa."),
             br(),
             tags$li("Ejemplos:"),
             tags$ul(
               tags$li("Población: todos los estudiantes de educación secundaria en Montevideo (2018-2022)."),
               tags$li("Muestra: 300 estudiantes seleccionados aleatoriamente de ese período."),
               br(),
               tags$li("Población: conjunto total de mujeres trabajadoras en Uruguay."),
               tags$li("Muestra: 50 mujeres seleccionadas aleatoriamente.")
             ),
             br(),
             tags$li("Ejemplos en Ciencias Sociales:"),
             # Tabla en Ciencias Sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Problema", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Unidad de análisis", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Población", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Muestra", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Impacto del nivel socioeconómico en acceso a educación superior", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Estudiantes de secundaria", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Todos los estudiantes de secundaria en Montevideo entre 2018-2022", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Muestra aleatoria de 1000 estudiantes de secundaria entre 2018-2022", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Brecha salarial de género", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Trabajadores/as en el mercado laboral", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Todas las personas ocupadas en Uruguay 2015-2022", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Muestra aleatoria de 1000 personas ocupadas entre 2015-2022", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Participación juvenil en organizaciones comunitarias", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Jóvenes entre 15 y 24 años", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Todos los jóvenes residentes en barrios periféricos de Montevideo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Muestra aleatoria de 500 jóvenes residentes en barrios periféricos", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 4
               tags$tr(
                 tags$td("Integración de migrantes en el mercado laboral", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Migrantes residentes en Uruguay", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Todos los migrantes registrados en Uruguay entre 2015-2022", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Muestra aleatoria de 200 migrantes registrados entre 2015-2022", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Unidad de análisis: persona, institución, expediente."),
               tags$li("Población: conjunto total."),
               tags$li("Muestra: parte representativa."),
               tags$li("En C.S.: una escuela puede ser unidad de análisis.")
             ),br(),br(),
             
             h4("Quiz"),
             radioButtons("q9", "9) ¿Qué es una unidad de análisis?",
                          choices = list(
                            "Elemento específico que se estudia" = "a",
                            "La técnica usada" = "b",
                            "El marco teórico" = "c"
                          ), selected = character(0)),
             actionButton("submit8", "Responder"),
             textOutput("feedback8"),
             br(), br(),
             h4("Actividad práctica"),
             p("Define población y muestra para un estudio sobre desigualdad educativa."),
             actionButton("sol8", "Ver respuesta sugerida"),
             textOutput("resp8"),
             br(),
             
             h4("Actividad individual: Género y trabajo"),
             p("Defina unidad de análisis y población para estudiar brecha salarial."),
             
             br(),
             h4("Actividad individual: Participación comunitaria"),
             p("Plantee población y muestra para investigar jóvenes en barrios periféricos."),
             
             br(),
             h4("Actividad grupal: Migración"),
             p("Determine unidad y población en casos de integración laboral de migrantes."),
             br(),
             
             h4("Actividad grupal domiciliaria entregable: Políticas sociales"),
             p("Diseñe muestreo de beneficiarios de programas sociales 2010-2020."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Participación digital"),
             p("Unidad y población para analizar uso de redes sociales en participación política juvenil."),
             
             br(),
             tags$hr(),
             br(),
             
    ),
    
    # --------------------------
    # CAPÍTULO VIII
    # --------------------------
    tabPanel("Métodos",
             h3("Métodos en Ciencias Sociales"),
             br(),
             h4("Introducción"),
             br(),
             tags$li("Los métodos en las Ciencias Sociales constituyen los caminos y estrategias utilizados para investigar
 fenómenos sociales. El método elegido condiciona la forma en que se formula el problema, se recogen
 datos y se construyen conclusiones."),
             br(),
             h4("Paradigma"),br(),
             tags$li(" El término paradigma refiere a un ejemplo o modelo y tiene un origen antiguo 
en la historia de la filosofía. Thomas Kuhn, en su trabajo La estructura de las revoluciones científicas (1962), adoptó ese concepto para referirse a
 una perspectiva teórica compartida y reconocida por la comunidad de científicos de 
una determinada disciplina, fundada sobre adquisiciones que preceden a la disciplina 
misma, y que actúa dirigiendo la investigación en términos tanto de: a) identificación 
y elección de los hechos relevantes a estudiar; b) formulación de hipótesis entre las 
que situar la explicación del fenómeno observado; y de c) preparación de las técnicas 
de investigación empíricas necesarias (Corbetta, 2007: 5)."),
             br(),
             tags$li("Características de los paradigmas"),
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               
               # Encabezado
               tags$tr(
                 tags$th("Cuestión de fondo", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Positivismo", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Pospositivismo", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Interpretativismo", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               
               # Ontología
               tags$tr(
                 tags$td("Ontología", style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td("Realismo ingenuo: la realidad social es «real» y conocible (como si se tratara de una cosa).", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Realismo crítico: la realidad social es «real» pero conocible solo de un modo imperfecto y probabilístico.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Constructivismo: el mundo conocible es el de los significados atribuidos por los individuos. Relativismo (realidad múltiple): varía según individuos, grupos y culturas.", style = "border: 1px solid black; padding: 6px;")
               ),
               
               # Epistemología
               tags$tr(
                 tags$td(HTML("Epistemología"), style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td(HTML("Dualismo/objetividad. Resultados ciertos. Ciencia experimental en busca de leyes.<br/> Objetivo: explicación. Generalizaciones: leyes «naturales» inmutables."), style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("Dualismo/objetividad modificados. Resultados probablemente ciertos. Ciencia experimental en busca de leyes.<br/> Objetivo: explicación. Generalizaciones: leyes provisionales y revisables."), style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("Ausencia de dualismo/objetividad. El investigador y el objeto de investigación están relacionados. Ciencia interpretativa en busca de significado.<br/> Objetivo: comprensión. Generalizaciones: enunciados de posibilidad, tipos ideales."), style = "border: 1px solid black; padding: 6px;")
               ),
               
               # Metodología
               tags$tr(
                 tags$td("Metodología", style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td("Experimental-manipuladora. Observación. Separación observador/observado. Predomina el método inductivo. Técnicas cuantitativas. Análisis «por variables».", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Experimental-manipuladora modificada. Observación. Separación observador/observado. Predomina el método deductivo (comprobación de hipótesis). Técnicas cuantitativas (sin descartar cualitativas). Análisis «por variables».", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Interacción empática entre investigador y objeto. Interpretación. Interacción observador/observado. Inducción (conocimiento desde la realidad estudiada). Técnicas cualitativas. Análisis «por casos».", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(),br(),br(),
             h4("Características de la investigación cuantitativa"),br(),
             tags$ul(
               tags$li("Contexto experimental: En la investigación cuantitativa se recogen los datos en 
contextos que no pueden ser entendidos como naturales."),
               tags$li("El rol del investigador: Desde esta perspectiva quien investiga debe mantenerse 
distanciado de su objeto de estudio para influir lo menos posible en los datos que va 
a recoger. La observación científica debe  tender a la neutralidad."),
               tags$li("Fuentes de información: Pueden utilizarse tanto fuentes primarias como secundarias. La técnica más utilizada en este tipo de investigaciones es la encuesta."),
               tags$li("Análisis deductivo: En la investigación cuantitativa la teoría precede a la observación, es previa a las hipótesis y tiene un lugar central, tanto para la definición de los 
objetivos como para la selección de la estrategia metodológica a utilizar."),
               tags$li("Participantes: Los participantes si bien tienen un rol importante ya que son 
quienes van a brindar los datos para la investigación no resultan pertinentes en 
su individualidad, sino a nivel agregado, como representativos de una población o 
universo."),
               tags$li("Diseño estructurado: La investigación cuantitativa se caracteriza por tener un diseño estructurado, secuenciado, cerrado y que precede a la investigación. Consiste 
en una serie de pasos que deben ser llevados a la práctica en el orden propuesto y 
no serán modificados sustancialmente a lo largo del desarrollo de la investigación."),
               tags$li("Perspectiva explicativa: El interés central de este tipo de trabajos radica en la 
descripción y la explicación de los fenómenos sociales desde una mirada objetiva y 
estadística. Importa la representatividad de los datos y la posibilidad de generalizar 
a la población de referencia. En este caso no interesa comprender al sujeto, sino 
explicar relaciones entre variables.")
               
             ),
             br(),br(),
             h4("Resumen del Método Cuantitativo"),br(),
             tags$li("Este método busca establecer regularidades y patrones a través de la medición numérica. Se aplica
 especialmente cuando se pretende probar hipótesis y obtener resultados generalizables."),br(),
             h4("Ejemplos"),br(),
             tags$ul(
               tags$li("Medir la relación entre nivel educativo de los hogares y acceso a empleo formal."),
               tags$li("Analizar correlación entre participación en organizaciones barriales y percepción de confianza institucional."),
               tags$li("Evaluar evolución de la migración interna y su impacto en el mercado laboral urbano."),
               tags$li("Observar cambios en la distribución de tareas domésticas según género en distintos estratos sociales."),
               tags$li("Examinar variaciones en el consumo cultural de jóvenes según nivel socioeconómico."),
               tags$li("Evaluar evolución anual del empleo generado por hogares MIPYME dependientes entre 2023 y 2025.")
             ),
             br(),br(),
             h4("Características de la investigación cualitativa"),br(),
             tags$ul(
               tags$li("Contexto natural: Los investigadores cualitativos tienden a recoger datos de 
campo en el lugar donde los participantes experimentan el fenómeno o problema 
de estudio. No trasladan a los sujetos a un ambiente controlado y no suelen enviar 
instrumentos de recogida para que los individuos los completen. Esta información 
cercana, recogida al hablar directamente con las personas u observar sus comportamientos y acción en contexto, en una interacción cara a cara a lo largo del tiempo, 
es una característica central de lo cualitativo."),
               tags$li("El investigador como instrumento clave: Los investigadores cualitativos recopilan datos por sí mismos al examinar documentos, observar el comportamiento o 
entrevistar participantes. Pueden usar un protocolo como instrumento de recogida, 
pero los investigadores son quienes relevan la información. Tienden a no usar ni 
confiar en instrumentos o cuestionarios que han desarrollado otros investigadores."),
               tags$li("Fuentes múltiples: Los investigadores cualitativos suelen recoger múltiples tipos 
de datos, como entrevistas, observaciones y documentos, más que confiar en una 
fuente única. Luego evalúan toda la información, le dan sentido y organizan en 
categorías o temas que atraviesan todas las fuentes de datos."),
               tags$li("Análisis inductivo: Los investigadores cualitativos suelen construir patrones, 
categorías y temas, de abajo hacia arriba, organizando sus datos hasta llegar cada 
vez a unidades de información más abstractas. Este proceso inductivo involucra un 
ida y vuelta entre temas y datos hasta lograr un conjunto comprehensivo de temas. 
Puede incluir el intercambio interactivo con los participantes, de forma que tengan 
la posibilidad de incidir en la forma dada a los temas y las abstracciones que han 
emergido del proceso."),
               tags$li("Significaciones de los participantes: Durante todo el proceso de investigación 
cualitativa, el investigador se focaliza en aprender el significado que los participantes otorgan al problema o fenómeno en cuestión, no en el significado que los 
investigadores le han dado ni a lo que expresa la literatura al respecto."),
               tags$li("Diseño emergente: El proceso de investigación cualitativa es emergente. Esto 
significa que el plan inicial de investigación no puede ser prescrito rígidamente y 
 que las fases del proceso pueden cambiar. Por ejemplo, las preguntas pueden cam
biar, las formas de recogida de datos pueden modificarse, así como los individuos y 
el contexto del estudio."),
               tags$li("Perspectiva interpretativa: En la investigación cualitativa es central la interpreta
ción del investigador acerca de lo que se ve, oye y comprende. Esta interpretación 
no es ajena a su contexto, historia y concepciones propias. También los participantes han interpretado los fenómenos en los que estaban involucrados y los propios lectores del informe de la investigación tendrán sus interpretaciones. Así se 
ve la emergencia de las múltiples miradas que pueden surgir sobre el problema de 
investigación.")
             ),
             br(),
             h4("Resumen del Método Cualitativo"),br(),
             tags$li("El método cualitativo busca comprender significados, percepciones y experiencias en profundidad. Es
 útil en investigaciones exploratorias y cuando se abordan fenómenos complejos o poco estudiados."),br(),
             h4("Ejemplos"),br(),
             tags$ul(
               tags$li("Analizar testimonios de hogares MIPYME dependientes sobre barreras en el acceso a financiamiento."),
               tags$li("Estudiar discursos de políticas públicas en relación con la igualdad de género."),
               tags$li("Observar dinámicas comunitarias para identificar prácticas de cooperación en barrios urbanos."),
               tags$li("Examinar relatos de migrantes sobre integración laboral en sectores de servicios."),
               tags$li("Evaluar percepciones de género en la distribución de tareas dentro de hogares MIPYME dependientes."),
               tags$li("Analizar evolución de la participación en programas sociales entre 2010 y 2023.")
             ),
             br(),br(),
             h4("Resumen del Método Mixto"),br(),
             tags$li("El enfoque mixto permite triangular la información, integrando lo cuantitativo y lo cualitativo. Su mayor
 ventaja es ofrecer una comprensión más completa y contrastada de los fenómenos jurídicos."),br(),
             h4("Ejemplos"),br(),
             tags$ul(
               tags$li("Acceso a créditos bancarios: estadísticas de hogares MIPYME dependientes + entrevistas a beneficiarios."),
               tags$li("Impacto de políticas de género: comparación de indicadores numéricos con testimonios de mujeres en hogares MIPYME."),
               tags$li("Efectividad de políticas educativas: análisis de datos de matrícula + encuestas a familias."),
               tags$li("Migración interna: evolución de registros poblacionales + relatos de comunidades receptoras."),
               tags$li("Participación ciudadana: indicadores de asistencia a cabildos + observación de dinámicas comunitarias.")
             ),
             br(),
             h4("Métodos"),
             
             # Tabla ciencias sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Método", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Características", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Ejemplo en Ciencias Sociales", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Cuantitativo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("• Busca medir y cuantificar fenómenos.<br/> • Se apoya en datos numéricos y análisis estadístico.<br/> • Permite generalizar resultados."), style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Analizar estadísticas de ingresos en hogares MIPYME dependientes.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Cualitativo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("• Se centra en significados, experiencias y procesos.<br/> • Utiliza entrevistas, observación, análisis documental.<br/> • Busca profundidad más que generalización."), style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Entrevistar a familias sobre estrategias de supervivencia en contextos de crisis económica.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Mixto", style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("• Combina técnicas cuantitativas y cualitativas.<br/> • Permite complementar datos numéricos con interpretaciones profundas.<br/> • Integra fortalezas de ambos enfoques."), style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Explorar necesidades y expectativas de hogares MIPYME dependientes: encuestas + entrevistas.", 
                         style = "border: 1px solid black; padding: 6px;"))
             ),
             br(),br(),
             h4("Comparación entre investigación cuantitativa y cualitativa"),
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               
               # Encabezado
               tags$tr(
                 tags$th("Fases en la investigación", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Investigación cuantitativa", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Investigación cualitativa", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               
               # Planteamiento de la investigación
               tags$tr(
                 tags$td("Planteamiento de la investigación", style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td(HTML("Estructurada, las fases siguen<br/>una secuencia lógica<br/><br/>Método deductivo (la teoría<br/>precede a la observación)<br/><br/>Función de la literatura: Fundamental para la definición<br/>de la teoría e hipótesis<br/><br/>Conceptos: Operativos<br/><br/>Relación con el entorno: Manipulador<br/><br/>Interacción psicológica: Observación científica, distante, neutral<br/><br/>Interacción física estudioso/estudiado: Distancia, separación<br/><br/>Papel del sujeto estudiado: Pasivo"), 
                         style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("Abierta, interactiva<br/><br/>Método inductivo (la teoría<br/>surge de la observación)<br/><br/>Función de la literatura: Auxiliar<br/><br/>Conceptos: Orientativos, abiertos, en construcción<br/><br/>Relación con el entorno: Naturalista<br/><br/>Interacción psicológica: Identificación empática con el objeto estudiado<br/><br/>Interacción física estudioso/estudiado: Proximidad, contacto<br/><br/>Papel del sujeto estudiado: Activo"), 
                         style = "border: 1px solid black; padding: 6px;")
               ),
               
               # Recopilación de datos
               tags$tr(
                 tags$td("Recopilación de datos", style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td(HTML("Diseño de la investigación: Estructurado, cerrado, anterior a la investigación<br/><br/>Representatividad/Inferencia: Muestra estadísticamente representativa<br/><br/>Instrumento de investigación: Uniforme para todos los sujetos. Objetivo: matriz de datos<br/><br/>Naturaleza de los datos: Hard, objetivos, estandarizados"), 
                         style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("Diseño de la investigación: Desestructurado, abierto, se construye en el curso de la investigación<br/><br/>Representatividad/Inferencia: Casos individuales no representativos estadísticamente<br/><br/>Instrumento de investigación: Varía según el interés de los sujetos. No se tiende a la estandarización<br/><br/>Naturaleza de los datos: Soft, subjetivos y flexibles"), 
                         style = "border: 1px solid black; padding: 6px;")
               ),
               
               # Análisis de los datos
               tags$tr(
                 tags$td("Análisis de los datos", style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td(HTML("Objeto del análisis: La variable (análisis por variables, impersonal)<br/><br/>Objetivo del análisis: Explicar la variación de las variables<br/><br/>Uso de técnicas matemáticas y estadísticas: Máximo"), 
                         style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("Objeto del análisis: El individuo (análisis por sujetos)<br/><br/>Objetivo del análisis: Comprender a los sujetos<br/><br/>Uso de técnicas matemáticas y estadísticas: Ninguno"), 
                         style = "border: 1px solid black; padding: 6px;")
               ),
               
               # Resultados
               tags$tr(
                 tags$td("Resultados", style = "border: 1px solid black; padding: 6px; font-weight: bold;"),
                 tags$td(HTML("Presentación de los datos: Tablas (enfoque relacional)<br/><br/>Generalizaciones: Correlaciones, modelos causales, leyes. Lógica de la causalidad<br/><br/>Alcance de los resultados: Se buscan generalizaciones (inferencia)"), 
                         style = "border: 1px solid black; padding: 6px;"),
                 tags$td(HTML("Presentación de los datos: Fragmentos de entrevistas, textos (enfoque narrativo)<br/><br/>Generalizaciones: Clasificaciones y tipologías, tipos ideales. Lógica de la clasificación<br/><br/>Alcance de los resultados: Especificidad"), 
                         style = "border: 1px solid black; padding: 6px;")
               )
             ),
             
             br(), br(),
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Cuantitativo: busca generalización."),
               tags$li("Cualitativo: busca comprensión profunda."),
               tags$li("Mixto: combina ambos."),
               tags$li("Ejemplo en C.S.: análisis estadístico + entrevistas.")
             ),
             br(),
             h4("Elección del Método"), br(),
             h4("La elección del método depende de:"),
             tags$ul(
               tags$li("El problema de investigación."),
               tags$li("Los objetivos propuestos."),
               tags$li("El tipo de datos disponibles."),
               tags$li("El tiempo y los recursos.")
             ),
             tags$li("En Ciencias Sociales, la selección adecuada del método
 permite responder a preguntas tanto sobre la magnitud de los fenómenos (cuánto) como sobre sus
 causas y significados (por qué y cómo)."),
             br(),
             h4("Quiz"),
             radioButtons("q10", "10) ¿Cuál es la diferencia entre método cuantitativo y cualitativo?",
                          choices = list(
                            "Cuantitativo: datos numéricos; Cualitativo: comprensión profunda" = "a",
                            "Son idénticos" = "b",
                            "Cuantitativo es subjetivo, cualitativo es objetivo" = "c"
                          ), selected = character(0)),
             actionButton("submit9", "Responder"),
             textOutput("feedback9"),
             br(), br(),
             h4("Actividad práctica"),
             p("¿Qué método usarías para estudiar la sostenibilidad económica de hogares MIPYME dependientes?"),
             actionButton("sol9", "Ver respuesta sugerida"),
             textOutput("resp9"),
             
             br(),
             h4("Actividad individual: Violencia doméstica"),
             p("Formule un diseño de investigación cuantitativo sobre reincidencia en casos de violencia doméstica."),
             
             br(),
             h4("Actividad individual: Acceso a la justicia"),
             p("Proponga un estudio mixto sobre acceso a la justicia en poblaciones afrodescendientes o trans."),
             
             br(),
             h4("Actividad grupal: Medio ambiente"),
             p("Diseñe una entrevista cualitativa para comunidades sobre percepciones de la contaminación ambiental en barrios urbanos."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Hogares MIPYME"),
             p("Compare ventajas y limitaciones del enfoque cuantitativo y cualitativo para estudiar resiliencia de hogares MIPYME dependientes."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Migración"),
             p("Redacte posibles hipótesis a contrastar con un método cuantitativo y preguntas de investigación para un método cualitativo sobre integración laboral de migrantes."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Participación ciudadana"),
             p("Analice cómo distintos métodos permiten estudiar la relación entre participación comunitaria y confianza en instituciones democráticas."),
             
             br(),
  
    ),
    
    # --------------------------
    # CAPÍTULO IX
    # --------------------------
    tabPanel("Técnicas",
             h3("Técnicas de investigación"),
             br(),
             h4("Introducción"),
             br(),
             tags$li(" Las técnicas de investigación son los instrumentos específicos que permiten obtener información de la
 realidad. A diferencia de los métodos (estrategias generales), las técnicas son procedimientos concretos
 para recolectar y analizar datos."),
             br(),
             h4("Fuentes primarias y secundarias de información"),
             br(),
             tags$li("Es importante distinguir entre investigaciones que utilizan fuentes de información primarias e investigaciones que utilizan fuentes secundarias, aunque también 
es posible combinar ambos tipos de fuentes en un proceso de investigación. La primera de ellas refiere a 
cualquier tipo de indagación en la que el investigador analiza la información que él 
mismo obtiene, mediante la aplicación de una o varias técnicas de obtención de datos. La investigación secundaria analiza datos 
generados por otros investigadores u otras fuentes como internet y repositorios, datos no publicados elaborados por organismos públicos y privados (ejemplos: I.N.E., Poder Judicial)."),
             br(), br(),
             h4("Técnicas Cuantitativas"),
             # Tabla ciencias sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Técnica", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Características", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Ejemplo en Ciencias Sociales", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Encuesta", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Aplicación masiva de preguntas estandarizadas a una muestra.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Encuesta sobre condiciones laborales en hogares MIPYME dependientes.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Cuestionario", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Preguntas cerradas para medir variables específicas.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Cuestionario a familias sobre acceso a servicios de salud y educación.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Censo", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Aplicación masiva de preguntas estandarizadas a una población.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Censo de hogares MIPYME dependientes en zonas urbanas y rurales.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 4
               tags$tr(
                 tags$td("Análisis estadístico", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Uso de bases de datos para identificar tendencias.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Estadísticas sobre migración interna y su impacto en el empleo juvenil (2010-2023).", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             h4("Encuesta"),
             br(),
             tags$li("Una encuesta por muestreo es un modo de obtener información preguntando a 
los individuos que son objeto de la investigación, que forman parte de una muestra 
representativa, mediante un procedimiento estandarizado de cuestionario, con el fin 
de estudiar las relaciones existentes entre las variables (Corbetta: 2007)."),
             br(),
             h4("Características de la técnica de encuesta"),
             tags$ul(
               tags$li("En la encuesta la información se adquiere mediante observación indirecta, a 
través de las respuestas de los sujetos encuestados."),
               tags$li("La información abarca una amplia cantidad de aspectos, que pueden ser objetivos (hechos) o subjetivos (opiniones, actitudes)."),
               tags$li("La información es recogida de forma estructurada: se formulan las mismas 
preguntas en el mismo orden a cada uno de los encuestados."),
               tags$li("Las respuestas de los individuos se agrupan y cuantifican para posteriormente ser analizadas a través del uso de herramientas estadísticas."),
               tags$li("Los datos obtenidos son generalizables a la población a la que muestra 
pertenece (Batthyány et al., 2011).")
             ),
             br(),
             h4("Tipos de encuestas"),
             tags$ul(
               tags$li("Encuestas cara a cara"),
               tags$li("Encuestas telefónicas"),
               tags$li("Encuestas por correo / autoadministradas"),
               tags$li("Encuestas informatizadas")
             ),
             br(),
             h4("Cuestionario"),
             br(),
             tags$li("El cuestionario es una técnica cuantitativa de recolección de datos que consiste en un conjunto estructurado de preguntas escritas, organizadas de manera lógica y secuencial, que se aplican a una muestra de personas con el fin de obtener información sobre sus opiniones, percepciones, comportamientos o características.
Su objetivo es medir variables previamente definidas y obtener información comparable y sistemática."),
             br(),
             h4("Características principales del cuestionario"),
             tags$ul(
               tags$li("Estandarización: todas las personas reciben las mismas preguntas, en el mismo orden y con las mismas opciones de respuesta (cuando las hay)."),
               tags$li("Cuantificación: permite transformar las respuestas en datos numéricos para análisis estadístico."),
               tags$li("Objetividad: reduce la influencia del investigador en la recolección de la información."),
               tags$li("Economía y rapidez: se pueden aplicar a un gran número de personas en poco tiempo."),
               tags$li("Flexibilidad de aplicación: pueden ser autoadministrados (en papel o digital), o aplicados por encuestador (cara a cara, telefónico, online)."),
               tags$li("Limitación: no permite profundizar en significados subjetivos; depende de la claridad de las preguntas y de la disposición del encuestado.")
             ),
             br(),
             h4("Tipos de cuestionarios según el formato de las preguntas:"),
             tags$ul(
               tags$li("Cerradas: el encuestado selecciona entre opciones dadas (ej.: sí/no, escala Likert, opciones múltiples)."),
               tags$li("Abiertas: el encuestado responde libremente con sus palabras (menos común en enfoques puramente cuantitativos, pero a veces complementa)."),
               tags$li("Mixtas: combinan preguntas cerradas y abiertas.")
               
             ),
             br(),
             
             h4("Censo"),
             br(),
             tags$li("El censo es una técnica de investigación cuantitativa que consiste en la recolección exhaustiva y sistemática de datos de toda la población objetivo, es decir, no trabaja con muestras, sino que busca cubrir la totalidad de los elementos o individuos que integran el universo de estudio. Su finalidad es obtener información completa, precisa y confiable sobre las características sociales, económicas, demográficas o jurídicas de una población en un momento determinado."),
             br(),
             h4("Características principales del censo"),
             tags$ul(
               tags$li("Cobertura total: estudia a todos los individuos de la población objetivo (no es una muestra)."),
               tags$li("Periodicidad: se realiza en períodos determinados, generalmente largos (ej.: censos nacionales cada 10 años)."),
               tags$li("Gran magnitud: requiere recursos logísticos, humanos y económicos importantes."),
               tags$li("Exhaustividad: permite conocer la estructura global de una población dada y realizar comparaciones históricas."),
               tags$li("Confiabilidad: al abarcar a todos los elementos, elimina el error muestral (aunque puede haber errores de recolección)."),
               tags$li("Instrumento: suele aplicarse mediante un cuestionario estructurado estandarizado.")
             ),
             h4("Ejemplo de censo"),
             tags$ul(
               tags$li("Censo judicial: relevar todos los juzgados y expedientes activos en un período, para conocer carga laboral, duración de procesos y áreas con mayor saturación.")),
             br(),
             br(),
             
             h4("Análisis estadístico"),
             br(),
             tags$li("El análisis estadístico es una técnica cuantitativa que consiste en el tratamiento sistemático de datos numéricos mediante procedimientos matemáticos y estadísticos, con el fin de describir, organizar, interpretar y explicar fenómenos sociales. Permite transformar datos brutos en información significativa, identificar patrones, relaciones entre variables y realizar inferencias sobre una población a partir de una muestra."),
             br(),
             h4("Características principales del Análisis estadístico"),
             tags$ul(
               tags$li("Rigurosidad matemática: se apoya en métodos formales y objetivos para analizar datos."),
               tags$li("Versatilidad: puede aplicarse tanto a estudios descriptivos como explicativos."),
               tags$li("Cuantificación: requiere que la información esté expresada en forma numérica o codificada en variables."),
               tags$li("Inferencia: posibilita generalizar resultados de una muestra a toda la población, con un nivel de confianza conocido."),
               tags$li("Apoyo tecnológico: se suele realizar con software estadístico (SPSS, R, Stata, Python, etc.).")
               
             ),
             br(),
             h4("Tipos de análisis estadístico"), br(),
             h4("Análisis descriptivo:"),
             tags$ul(
               tags$li("Resume y organiza los datos."),
               tags$li("Usa medidas como media, mediana, moda, desviación estándar."),
               tags$li("Ejemplo: calcular el ingreso promedio mensual de hogares MIPYME dependientes.")
             ),
             br(),
             h4("Análisis inferencial:"),
             tags$ul(
               tags$li("Permite hacer generalizaciones y contrastar hipótesis."),
               tags$li("Usa pruebas de significancia, intervalos de confianza, regresiones."),
               tags$li("Ejemplo: comprobar si existe relación significativa entre nivel educativo y acceso a empleo formal en hogares MIPYME dependientes.")
             ),
             br(),
             h4("Análisis multivariante:"),
             tags$ul(
               tags$li("Examina simultáneamente varias variables."),
               tags$li("Ejemplo: analizar cómo influyen edad, género y situación socioeconómica en la participación comunitaria.")
             ),
             br(),
             h4("Ejemplos aplicados a Ciencias Sociales"),
             tags$ul(
               tags$li("Hogares MIPYME dependientes: análisis estadístico de ingresos y acceso a servicios básicos para identificar desigualdades."),
               tags$li("Migración: comparar tasas de empleo entre migrantes internos y externos en zonas urbanas."),
               tags$li("Educación: analizar la relación entre nivel socioeconómico y rendimiento escolar en secundaria.")
             ),
             br(),
             
             h4("Técnicas Cualitativas"),
             # Tabla ciencias sociales
             tags$table(
               style = "width:100%; border-collapse: collapse; margin-top: 10px;",
               # Encabezado
               tags$tr(
                 tags$th("Técnica", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Características", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;"),
                 tags$th("Ejemplo en Ciencias Sociales", style = "border: 1px solid black; padding: 6px; background-color: #f2f2f2;")
               ),
               # Fila 1
               tags$tr(
                 tags$td("Entrevista", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Conversaciones en profundidad.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Entrevista a familias de hogares MIPYME dependientes sobre estrategias de resiliencia económica.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 2
               tags$tr(
                 tags$td("Grupo focal", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Discusión grupal sobre un tema.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Grupo focal con jóvenes sobre participación comunitaria y confianza en instituciones.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 3
               tags$tr(
                 tags$td("Análisis documental", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Revisión de documentos y textos sociales.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Análisis de informes de políticas públicas sobre inclusión social.", style = "border: 1px solid black; padding: 6px;")
               ),
               # Fila 4
               tags$tr(
                 tags$td("Observación", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Registro sistemático de conductas.", style = "border: 1px solid black; padding: 6px;"),
                 tags$td("Observación de dinámicas de cooperación en ferias de hogares MIPYME dependientes.", style = "border: 1px solid black; padding: 6px;")
               )
             ),
             br(), br(),
             h4("Entrevista"),
             br(),
             tags$li("Podemos definir la entrevista cualitativa como una conversación: a) provocada por 
el entrevistador; b) realizada a sujetos seleccionados a partir de un plan de investiga
ción; c) en un número considerable; d) que tiene una finalidad de tipo cognitivo; e) 
guiada por el entrevistador; y f) con un esquema de preguntas flexible y no estandarizado (Corbetta, 2007: 344)."),
             br(),
             h4("Tipos de entrevista:"),
             tags$ul(
               tags$li("Entrevista estructurada: se hacen las mismas preguntas a todos los entrevistados, con la misma formulación y el mismo orden."),
               tags$li("Entrevista semiestructurada: el investigador dispone de una serie de temas 
que debe trabajar a lo largo de la entrevista, pero puede decidir libremente 
sobre el orden de presentación de los diversos temas y el modo de formular 
la pregunta."),
               tags$li("Entrevista no estructurada: no se fija el contenido de las preguntas, pudiendo 
variar en función del sujeto a entrevistar; solamente se plantearan temas a 
abordar.")
             ),
             br(),
             
             h4("Grupo focal o de discusión"),
             br(),
             tags$li("El grupo de discusión es una técnica de investigación social que (como la entrevista 
abierta o en profundidad, y las historias de vida) trabaja con el habla."),
             br(),
             h4("Características del grupo de discusión"),
             tags$ul(
               tags$li("El grupo de discusión no es tal ni antes ni después de la discusión. Su existencia se reduce a la situación discursiva. No puede tratarse de un grupo que 
exista naturalmente."),
               tags$li("El grupo de discusión debe realizar una tarea, como un equipo de trabajo se 
orienta a la producción de algo. Existe por, y para ese objetivo."),
               tags$li("El grupo de discusión instaura un espacio de opinión grupal, se trata de un 
intercambio de ideas y opiniones entre sus integrantes."),
               tags$li("La muestra no responde a criterios estadísticos, sino estructurales (pretende 
que estén representadas aquellas relaciones sociales que son de interés para 
el estudio) Algunos puntos a tener en cuenta al momento del diseño son: el 
número total de grupos, las variables o atributos que definirán a los participantes de cada uno de ellos, y la dispersión geográfica de los grupos."),
               tags$li("El tamaño del grupo de discusión se sitúa entre los cinco y diez participantes."),
               tags$li("Debe existir cierta homogeneidad y heterogeneidad a la interna del grupo (Delgado y Gutiérrez, 1999, en Batthyány et al., 2011).")
             ),
             br(),
             h4("Observación participante"),
             br(),
             tags$li("Por consiguiente, podemos definir la observación participante como una técnica en 
la que el investigador se adentra en un grupo social determinado: a) de forma directa; b) durante un período de tiempo relativamente largo; c) en su medio natural; d) 
estableciendo una interacción personal con sus miembros; y, e) para describir sus 
acciones y comprender, mediante un proceso de identificación, sus motivaciones 
(Corbetta, 2007: 305)."),
             br(),
             h4("Técnicas Mixtas"), br(),
             tags$li("Las técnicas mixtas integran herramientas cuantitativas y cualitativas. En ciencias sociales permiten combinar estadísticas de encuestas con entrevistas, observación o análisis documental."),
             br(),
             tags$li("Ejemplos"),
             tags$ul(
               tags$li("Hogares MIPYME dependientes: análisis de ingresos y empleo + entrevistas sobre estrategias de resiliencia."),
               tags$li("Migración interna: encuestas a familias migrantes + grupos focales en comunidades receptoras."),
               tags$li("Educación: estadísticas de matrícula escolar + entrevistas a docentes sobre desigualdades en el aula."),
               tags$li("Participación ciudadana: indicadores de asistencia a cabildos + observación de dinámicas comunitarias."),
               tags$li("Género: encuestas sobre distribución de tareas domésticas + relatos de mujeres en hogares MIPYME dependientes.")
             ),
             br(),
             h4("Conceptos clave"),
             tags$ul(
               tags$li("Encuestas, censos, entrevistas, observación, etc."),
               tags$li("Análisis documental y de políticas públicas."),
               tags$li("En Ciencias Sociales: entrevistas a familias, análisis de programas sociales, encuestas a comunidades.")
             ),
             br(), br(),
             h4("Quiz"),
             radioButtons("q11", "11) ¿Cuál de estas es una técnica de investigación?",
                          choices = list(
                            "Entrevistas semiestructuradas" = "a",
                            "Teoría crítica" = "b",
                            "Diseño exploratorio" = "c"
                          ), selected = character(0)),
             actionButton("submit10", "Responder"),
             textOutput("feedback10"),
             br(), br(),
             
             h4("Actividad práctica"),
             p("Diseña una entrevista semiestructurada a familias de hogares MIPYME dependientes sobre acceso a recursos."),
             actionButton("sol10", "Ver respuesta sugerida"),
             textOutput("resp10"),
             br(),
             
             h4("Actividad individual: Violencia doméstica"),
             p("Diseñe una entrevista a mujeres en hogares monoparentales sobre violencia doméstica con 3 preguntas abiertas."),
             
             br(),
             h4("Actividad individual: Acceso a la justicia"),
             p("Formule un cuestionario de 5 preguntas cerradas sobre acceso a la justicia en poblaciones afrodescendientes o trans."),
             
             br(),
             h4("Actividad grupal: Medio ambiente"),
             p("Elabore un esquema de análisis documental para revisar políticas ambientales y su impacto en comunidades locales."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Hogares MIPYME dependientes"),
             p("Plantee un diseño mixto para estudiar estrategias de adaptación económica en hogares MIPYME dependientes: encuestas + entrevistas."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Migración"),
             p("Diseñe una encuesta a familias migrantes sobre integración laboral y preguntas cualitativas sobre experiencias comunitarias."),
             
             br(),
             h4("Actividad grupal domiciliaria entregable: Participación ciudadana"),
             p("Compare ventajas y limitaciones del enfoque cuantitativo y cualitativo para estudiar participación en organizaciones barriales."),
             br(),
             
             
    )
  )
)
claritaServer <- function(id, seccion_reactiva) {
  moduleServer(id, function(input, output, session) {
    
    conceptos <- list(
      "hipótesis" = "Una hipótesis es una proposición que puede ser puesta a prueba mediante la investigación.",
      "variable" = "Una variable es una característica que puede tomar diferentes valores en una investigación.",
      "variable independiente" = "Es la variable que se manipula para observar su efecto sobre otra.",
      "variable dependiente" = "Es la variable que se observa para ver cómo cambia en función de la independiente.",
      "variable contextual" = "Describe el entorno del estudio sin ser parte directa de la relación causal.",
      "indicador" = "Una medida observable que representa una característica no directamente medible.",
      "índice" = "Una combinación de indicadores que resume una dimensión compleja.",
      "unidad de análisis" = "El objeto principal que se estudia: personas, instituciones, documentos, etc.",
      "unidad de observación" = "El elemento desde el cual se recolectan los datos.",
      "población" = "Conjunto total de elementos que cumplen con ciertas características definidas.",
      "universo" = "Sinónimo de población, aunque a veces se refiere al marco teórico total.",
      "método cualitativo" = "Busca comprender significados, experiencias y procesos sociales en profundidad.",
      "método cuantitativo" = "Busca medir variables y analizar relaciones mediante datos numéricos.",
      "encuesta" = "Aplicación de un cuestionario estandarizado a una muestra.",
      "censo" = "Recolección de datos de todos los elementos de la población.",
      "cuestionario" = "Instrumento con preguntas estructuradas para recolectar datos.",
      "entrevista" = "Conversación dirigida para obtener información.",
      "grupo focal" = "Discusión grupal guiada para explorar percepciones.",
      "observación" = "Registro de comportamientos o situaciones tal como ocurren.",
      "observación participante" = "El investigador se involucra activamente en el contexto observado.",
      "ciencia" = "Conjunto de conocimientos obtenidos mediante la observación y el razonamiento, sistemáticamente estructurados y de los que se deducen principios y leyes generales.",
      "método" = "Procedimiento que se sigue en las ciencias para hallar la verdad y enseñarla. En investigación social, permite obtener nuevos conocimientos o diagnosticar problemas con fines prácticos.",
      "epistemología" = "Disciplina que analiza los supuestos filosóficos de las ciencias, sus métodos, teorías y la validez del conocimiento científico.",
      "metodología" = "Conjunto de estrategias y procedimientos para producir conocimiento. Reflexiona sobre los métodos utilizados y sus implicancias epistemológicas.",
      "proceso de investigación" = "Conjunto de etapas que permiten generar conocimiento científico: desde las primeras preguntas hasta el diseño del estudio y la recolección de evidencia.",
      "proyecto de investigación" = "Documento que explicita todos los elementos del proceso de investigación: problema, objetivos, marco teórico, metodología y diseño empírico.",
      "tema" = "Campo general de estudio que puede surgir de preocupaciones sociales, demandas institucionales o motivaciones personales. Requiere delimitación conceptual para orientar la investigación.",
      "problema" = "Pregunta concreta que guía la investigación. Es la problematización de un aspecto específico del tema, traducido en preguntas u objetivos. Requiere delimitación conceptual, temporal y empírica, y disponibilidad de información.",
      "marco teórico" = "Conjunto de teorías, enfoques y antecedentes científicos que sustentan y orientan la investigación. Permite comprender el problema desde una perspectiva académica y ubicarlo en el campo del conocimiento.",
      "marco conceptual" = "Sistema de conceptos clave que se definen y articulan para guiar la investigación. Aporta claridad terminológica y delimita el sentido en que se utilizarán ciertos términos.",
      "antecedentes" = "Trabajos previos, investigaciones o datos relevantes que abordan el mismo problema o problemas similares. Sirven para justificar la investigación y evitar duplicaciones.",
      "objetivo" = "Un objetivo expresa lo que se pretende alcanzar con la investigación. Puede ser general o específico, y debe ser claro, viable y coherente con el problema planteado.",
      "objetivo general" = "Es la meta principal de la investigación. Resume lo que se busca comprender, explicar o analizar en términos amplios.",
      "objetivo específico" = "Son metas concretas que descomponen el objetivo general. Permiten abordar dimensiones particulares del problema y guiar la recolección de datos.",
      "diseño de investigación" = "Es la planificación detallada de cómo se llevará a cabo la investigación. Incluye el enfoque metodológico, las técnicas de recolección de datos, la población, el muestreo y el cronograma.",
      "muestra" = "Es un subconjunto de la población seleccionado para representar sus características en la investigación.",
      "conocimiento" = "Es el conjunto de saberes que una persona o grupo posee sobre el mundo, adquiridos por experiencia, educación o investigación.",
      "conocimiento cotidiano" = "Es el saber que se construye en la vida diaria, basado en la experiencia, la tradición y el sentido común.",
      "conocimiento científico" = "Es el saber que se obtiene mediante métodos sistemáticos, verificables y racionales, orientado a explicar fenómenos con validez general.",
      "paradigma" = "Es un conjunto de creencias, valores y métodos compartidos por una comunidad científica que orienta la producción de conocimiento.",
      "parsimonia" = "Principio metodológico que sugiere elegir la explicación más simple y suficiente entre varias posibles.",
      "teoría" = "Conjunto sistemático de ideas, principios y proposiciones que explican un fenómeno y permiten formular hipótesis.",
      "vigilancia epistemológica" = "Actitud crítica constante del investigador para evitar que sus prejuicios o creencias contaminen el proceso científico.",
      "ruptura epistemológica" = "Proceso por el cual el investigador se distancia del sentido común y de las ideas previas para construir conocimiento científico.",
      "concepto" = "Representación mental que sintetiza las características esenciales de un fenómeno. Es la unidad básica del pensamiento científico.",
      "dimensión" = "Aspecto o componente de un concepto que puede ser descompuesto para su análisis o medición.",
      "supuesto ontológico" = "Presuposición sobre la naturaleza de la realidad que se investiga: qué existe y cómo es.",
      "supuesto gnoseológico" = "Presuposición sobre cómo se puede conocer la realidad: qué tipo de conocimiento es válido y cómo se obtiene.",
      "teoría" = "Explicar fenómenos, orientar la formulación de hipótesis y dar sentido a los datos empíricos.",
      "vigilancia epistemológica" = "Garantizar la objetividad y la rigurosidad del proceso de investigación.",
      "ruptura epistemológica" = "Permitir el paso del conocimiento cotidiano al conocimiento científico.",
      "concepto" = "Delimitar y organizar el pensamiento científico, facilitando la comunicación y el análisis.",
      "dimensión" = "Permitir descomponer un concepto complejo en partes observables o medibles.",
      "supuesto ontológico" = "Orientar qué tipo de realidad se considera investigable.",
      "supuesto gnoseológico" = "Definir cómo se accede al conocimiento y qué métodos se consideran válidos.",
      "operacionalización de concepto" = "Proceso mediante el cual se traduce un concepto abstracto en variables e indicadores observables y medibles.",
      "falacia ecológica" = "Error lógico que consiste en atribuir características de un grupo a los individuos que lo componen.",
      "positivismo" = "Corriente filosófica que sostiene que el conocimiento válido es el que se obtiene mediante la observación empírica y el método científico.",
      "neopositivismo" = "Enfoque que retoma el positivismo clásico, incorporando la lógica formal y el análisis del lenguaje científico.",
      "postpositivismo" = "Perspectiva que reconoce los límites del conocimiento objetivo, incorporando la crítica epistemológica y la posibilidad de error.",
      "interpretativismo" = "Enfoque que sostiene que la realidad social debe comprenderse desde la perspectiva de los actores, priorizando significados y contextos.",
      "fuentes secundarias" = "Datos ya existentes que fueron recolectados por otros investigadores o instituciones, como estadísticas oficiales o estudios previos.",
      "fuentes primarias" = "Datos originales recolectados directamente por el investigador mediante técnicas como entrevistas, encuestas u observación.",
      "modo normativo" = "Construye el objeto jurídico desde el análisis de normas vigentes, su jerarquía, coherencia y aplicación.",
      "modo sociológico" = "Construye el objeto jurídico observando cómo el derecho opera en la sociedad, considerando prácticas, actores e instituciones.",
      "modo histórico" = "Construye el objeto jurídico reconstruyendo su evolución en el tiempo, atendiendo a contextos políticos, sociales y culturales.",
      "modo filosófico" = "Construye el objeto jurídico reflexionando sobre sus fundamentos éticos, ontológicos y axiológicos.",
      "modo crítico" = "Construye el objeto jurídico cuestionando sus presupuestos, efectos y relaciones de poder, desde una perspectiva transformadora."
    )
    
    ejemplos <- list(
      "variable" = "Ejemplo: la participación en organizaciones comunitarias es una variable si se mide como alta, media o baja.",
      "variable independiente" = "Ejemplo: el nivel educativo puede ser una variable independiente si se estudia su efecto sobre la participación política.",
      "variable dependiente" = "Ejemplo: la participación política sería la variable dependiente si se analiza cómo varía según el nivel educativo.",
      "variable contextual" = "Ejemplo: el contexto urbano o rural puede ser una variable contextual que influye indirectamente en la participación social.",
      "indicador" = "Ejemplo: porcentaje de mujeres que participan en asociaciones vecinales.",
      "índice" = "Ejemplo: un índice de bienestar social que combine indicadores de salud, educación y empleo.",
      "unidad de análisis" = "Ejemplo: los hogares encabezados por mujeres.",
      "unidad de observación" = "Ejemplo: cada hogar encabezado por una mujer.",
      "entrevista" = "Ejemplo: entrevista semiestructurada a jóvenes sobre expectativas laborales.",
      "grupo focal" = "Ejemplo: discusión grupal con estudiantes universitarios sobre experiencias de discriminación.",
      "observación participante" = "Ejemplo: el investigador participa en actividades comunitarias para observar dinámicas de cooperación.",
      "hipótesis" = "Ejemplo: A mayor nivel educativo, mayor participación en organizaciones sociales.",
      "cuestionario" = "Ejemplo: cuestionario estructurado con preguntas cerradas sobre percepción de desigualdad de género.",
      "censo" = "Ejemplo: relevamiento de todos los hogares de un barrio para conocer condiciones de vivienda.",
      "encuesta" = "Ejemplo: encuesta a trabajadores sobre satisfacción laboral.",
      "método cualitativo" = "Ejemplo: entrevistas en profundidad a mujeres sobre experiencias de violencia simbólica.",
      "método cuantitativo" = "Ejemplo: análisis estadístico de tasas de desempleo por grupo etario.",
      "universo" = "Ejemplo: todos los estudiantes universitarios de Uruguay en 2024.",
      "población" = "Ejemplo: estudiantes de sociología en Montevideo.",
      "ciencia" = "Ejemplo: el estudio sistemático de las causas de la desigualdad social es una investigación científica.",
      "método" = "Ejemplo: aplicar encuestas y entrevistas para estudiar la percepción de desigualdad es parte del método científico.",
      "epistemología" = "Ejemplo: reflexionar sobre si los datos de encuestas reflejan la realidad o construyen una visión parcial es un análisis epistemológico.",
      "metodología" = "Ejemplo: decidir si se usarán grupos focales o análisis estadístico forma parte de la metodología.",
      "proceso de investigación" = "Ejemplo: comenzar con una pregunta sobre desigualdad educativa, revisar bibliografía y diseñar un estudio es parte del proceso de investigación.",
      "proyecto de investigación" = "Ejemplo: un proyecto que busca analizar el impacto de las políticas sociales incluye problema, objetivos, marco teórico y métodos.",
      "tema" = "Ejemplo: 'La desigualdad educativa en Uruguay' es un tema que puede abordarse desde distintas perspectivas sociales.",
      "problema" = "Ejemplo: ¿Qué obstáculos enfrentan los jóvenes de bajos ingresos para acceder a la educación superior?",
      "marco teórico" = "Ejemplo: utilizar la teoría del capital cultural de Bourdieu para analizar desigualdades educativas.",
      "marco conceptual" = "Ejemplo: definir conceptos como 'capital social', 'participación comunitaria' y 'desigualdad' para precisar su uso en el estudio.",
      "antecedentes" = "Ejemplo: revisar investigaciones previas sobre participación política juvenil en América Latina.",
      "objetivo" = "Ejemplo: comprender el impacto del nivel educativo en la participación política.",
      "objetivo general" = "Ejemplo: analizar la relación entre educación y participación política.",
      "objetivo específico" = "Ejemplo: describir las diferencias en participación política según género y nivel educativo.",
      "diseño de investigación" = "Ejemplo: investigación cualitativa con entrevistas semiestructuradas a jóvenes y análisis de encuestas nacionales.",
      "muestra" = "Ejemplo: 300 estudiantes seleccionados aleatoriamente de un total de 2000 matriculados.",
      "conocimiento" = "Ejemplo: saber que los jóvenes participan más en redes sociales que en partidos políticos.",
      "conocimiento cotidiano" = "Ejemplo: creer que los barrios periféricos tienen menos actividades culturales por experiencia personal.",
      "conocimiento científico" = "Ejemplo: demostrar con datos que los barrios periféricos tienen menor acceso a actividades culturales.",
      "paradigma" = "Ejemplo: el paradigma interpretativo prioriza comprender significados y experiencias subjetivas.",
      "parsimonia" = "Ejemplo: explicar la baja participación política por falta de interés antes que por múltiples factores complejos.",
      "teoría" = "Ejemplo: la teoría del capital social explica cómo las redes comunitarias fortalecen la cooperación.",
      "vigilancia epistemológica" = "Ejemplo: revisar si nuestras creencias sobre los jóvenes influyen en la interpretación de los datos.",
      "ruptura epistemológica" = "Ejemplo: dejar de pensar que 'los pobres no estudian porque no quieren' y analizar las barreras estructurales.",
      "concepto" = "Ejemplo: 'participación social' es un concepto que incluye actividades comunitarias, políticas y culturales.",
      "dimensión" = "Ejemplo: del concepto 'desigualdad social', una dimensión puede ser la desigualdad económica.",
      "supuesto ontológico" = "Ejemplo: asumir que la desigualdad social existe como fenómeno y puede ser investigada.",
      "supuesto gnoseológico" = "Ejemplo: creer que la experiencia de los jóvenes puede ser conocida a través de entrevistas cualitativas.",
      "operacionalización de concepto" = "Ejemplo: traducir el concepto 'participación social' en indicadores como asistencia a reuniones, votación y voluntariado.",
      "falacia ecológica" = "Ejemplo: afirmar que todos los jóvenes de un barrio son apáticos porque el promedio de participación es bajo.",
      "positivismo" = "Ejemplo: estudiar la relación entre nivel educativo y participación política mediante análisis estadístico.",
      "neopositivismo" = "Ejemplo: construir definiciones precisas y verificables para conceptos como 'capital social' o 'desigualdad'.",
      "postpositivismo" = "Ejemplo: reconocer que los datos de encuestas pueden estar influenciados por sesgos de respuesta.",
      "interpretativismo" = "Ejemplo: analizar cómo los jóvenes interpretan su experiencia educativa a través de entrevistas.",
      "fuentes secundarias" = "Ejemplo: usar estadísticas del INE sobre empleo juvenil.",
      "fuentes primarias" = "Ejemplo: realizar entrevistas a estudiantes sobre expectativas laborales.",
      "modo normativo" = "Ejemplo: analizar políticas públicas sobre acceso a la educación superior.",
      "modo sociológico" = "Ejemplo: estudiar cómo los jóvenes acceden (o no) a la educación superior, más allá de lo que dicen las políticas.",
      "modo histórico" = "Ejemplo: reconstruir la evolución de la participación estudiantil desde la década de 1960 hasta hoy.",
      "modo filosófico" = "Ejemplo: reflexionar sobre el concepto de igualdad desde el pensamiento de Bourdieu o Sen.",
      "modo crítico" = "Ejemplo: analizar cómo el sistema educativo reproduce desigualdades de género y clase."
    )
    funciones <- list(
      "hipótesis" = "Orientar la recolección y el análisis de datos, permitiendo confirmar o refutar relaciones.",
      "variable" = "Permitir la medición y comparación de fenómenos.",
      "variable independiente" = "Actuar como causa o factor explicativo en el estudio.",
      "variable dependiente" = "Representar el efecto o resultado que se quiere explicar.",
      "variable contextual" = "Aportar información sobre el entorno que puede influir en los resultados.",
      "indicador" = "Operacionalizar conceptos abstractos para hacerlos observables.",
      "índice" = "Sintetizar múltiples datos en una sola medida compuesta.",
      "unidad de análisis" = "Delimitar qué se está investigando.",
      "unidad de observación" = "Definir el punto de acceso empírico a la información.",
      "población" = "Establecer el universo al que se pretende generalizar los resultados.",
      "universo" = "Delimitar el alcance conceptual o empírico del estudio.",
      "método cualitativo" = "Explorar fenómenos complejos desde la perspectiva de los actores.",
      "método cuantitativo" = "Establecer patrones, correlaciones y generalizaciones.",
      "encuesta" = "Recolectar datos comparables sobre opiniones, comportamientos o características.",
      "censo" = "Obtener información exhaustiva sin necesidad de inferencias.",
      "cuestionario" = "Estandarizar la recolección de información.",
      "entrevista" = "Explorar percepciones, experiencias y significados en profundidad.",
      "grupo focal" = "Generar información colectiva sobre temas sensibles o complejos.",
      "observación" = "Captar información directa sobre el fenómeno estudiado.",
      "observación participante" = "Comprender desde adentro las dinámicas sociales.",
      "ciencia" = "Generar conocimiento válido y confiable.",
      "método" = "Guiar el proceso investigativo.",
      "epistemología" = "Fundamentar críticamente el conocimiento producido.",
      "metodología" = "Estructurar el enfoque técnico y teórico de la investigación.",
      "proceso de investigación" = "Organizar el trabajo investigativo de forma sistemática.",
      "proyecto de investigación" = "Planificar y comunicar cómo se desarrollará la investigación.",
      "tema" = "Definir el área de interés.",
      "problema" = "Focalizar el estudio en una cuestión relevante.",
      "marco teórico" = "Fundamentar conceptualmente el estudio.",
      "marco conceptual" = "Precisar el lenguaje y los significados operativos.",
      "antecedentes" = "Contextualizar el estudio en el campo existente.",
      "objetivo" = "Orientar el desarrollo del estudio y delimitar lo que se busca alcanzar.",
      "objetivo general" = "Definir el propósito central de la investigación.",
      "objetivo específico" = "Guiar la recolección y el análisis de datos sobre aspectos concretos del problema.",
      "diseño de investigación" = "Organizar los procedimientos para obtener evidencia válida.",
      "muestra" = "Permitir estudiar una parte representativa de la población cuando no es posible acceder a su totalidad.",
      "conocimiento" = "Permitir comprender, interpretar y actuar sobre el mundo que nos rodea.",
      "conocimiento cotidiano" = "Orientar decisiones prácticas en la vida diaria sin necesidad de validación científica.",
      "conocimiento científico" = "Explicar fenómenos de forma sistemática y generar saberes confiables y replicables.",
      "paradigma" = "Guiar la formulación de problemas, métodos y criterios de validación en la investigación.",
      "parsimonia" = "Favorecer explicaciones claras y eficientes, evitando complejidad innecesaria en el análisis.",
      "teoría" = "Explicar fenómenos, orientar la formulación de hipótesis y dar sentido a los datos empíricos.",
      "vigilancia epistemológica" = "Garantizar la objetividad y la rigurosidad del proceso de investigación.",
      "ruptura epistemológica" = "Permitir el paso del conocimiento cotidiano al conocimiento científico.",
      "concepto" = "Delimitar y organizar el pensamiento científico, facilitando la comunicación y el análisis.",
      "dimensión" = "Permitir descomponer un concepto complejo en partes observables o medibles.",
      "supuesto ontológico" = "Orientar qué tipo de realidad se considera investigable.",
      "supuesto gnoseológico" = "Definir cómo se accede al conocimiento y qué métodos se consideran válidos.",
      "operacionalización de concepto" = "Permitir medir empíricamente conceptos abstractos para analizarlos en la investigación.",
      "falacia ecológica" = "Advertir sobre errores de inferencia que pueden distorsionar la interpretación de los datos.",
      "positivismo" = "Fundamentar investigaciones que buscan leyes generales mediante observación y medición objetiva.",
      "neopositivismo" = "Refinar el análisis científico incorporando criterios de verificación lógica y precisión conceptual.",
      "postpositivismo" = "Incorporar la crítica y la reflexividad en el proceso científico, reconociendo la influencia del observador.",
      "interpretativismo" = "Comprender fenómenos sociales desde los significados que les atribuyen los propios actores.",
      "fuentes secundarias" = "Aportar información previa útil para contextualizar, comparar o complementar los datos primarios.",
      "fuentes primarias" = "Proveer evidencia directa y específica sobre el fenómeno investigado.",
      "modo normativo" = "Permitir describir, interpretar y sistematizar el derecho positivo vigente.",
      "modo sociológico" = "Analizar el funcionamiento real del derecho en contextos sociales concretos.",
      "modo histórico" = "Comprender el origen y transformación de instituciones jurídicas a lo largo del tiempo.",
      "modo filosófico" = "Fundamentar conceptualmente el derecho y sus valores desde una perspectiva reflexiva.",
      "modo crítico" = "Desnaturalizar el derecho, evidenciar sus efectos excluyentes y proponer alternativas emancipadoras."
    )
    
    
    
    
    observeEvent(input$consultar, {
      req(input$pregunta)
      consulta <- tolower(trimws(input$pregunta))
      seccion <- seccion_reactiva()
      
      
      claves_ordenadas <- names(conceptos)[order(nchar(names(conceptos)), decreasing = TRUE)]
      clave <- claves_ordenadas[sapply(claves_ordenadas, function(k) grepl(k, consulta))]
      
      if (length(clave) > 0) {
        concepto <- clave[1]
        definicion <- conceptos[[concepto]]
        funcion <- funciones[[concepto]]
        ejemplo <- ejemplos[[concepto]]
        
        mensaje <- paste0(
          "\n\n",
          "🔹 Definición de ", concepto, ":\n", definicion, "\n\n",
          if (!is.null(funcion)) paste0("🔹 Función en la investigación:\n", funcion, "\n\n") else "",
          if (!is.null(ejemplo)) paste0("🔹 \n", ejemplo) else ""
        )
      } else {
        mensaje <- "Todavía no tengo una respuesta para eso, pero podés consultarlo con tu docente."
      }
      
      output$respuesta_ui <- renderUI({
        div(style = "background-color:#f0f8ff; border-radius:10px; padding:10px;",
            strong("Respuesta:"),
            p(mensaje)
        )
      })
    })
  })
}
server <- function(input, output, session) {
  
  # --- INICIO LÓGICA PIZARRA GLOBAL ---
  observeEvent(input$setTema, {
    if (nzchar(input$tema)) {
      pizarra$tema <- input$tema
      updateTextInput(session, "tema", value = "")
    }
  })
  
  observeEvent(input$enviar, {
    if (nzchar(input$idea)) {
      pizarra$ideas <- c(pizarra$ideas, input$idea)
      updateTextInput(session, "idea", value = "")
    }
  })
  
  observeEvent(input$borrar, {
    pizarra$tema  <- "Pendiente de definir..."
    pizarra$ideas <- character()
    updateTextInput(session, "tema", value = "")
    updateTextInput(session, "idea", value = "")
  })
  
  output$temaActual <- renderText({
    pizarra$tema
  })
  
  output$listaIdeas <- renderUI({
    HTML(paste0("<li>", pizarra$ideas, "</li>", collapse = ""))
  })
  output$descargarPizarra <- downloadHandler(
    filename = function() {
      paste0("pizarra_", Sys.Date(), ".txt")
    },
    content = function(file) {
      contenido <- paste(
        "TEMA DE LA CLASE:\n", pizarra$tema, "\n\n",
        "IDEAS DE LOS ESTUDIANTES:\n",
        paste(paste0("- ", pizarra$ideas), collapse = "\n"),
        sep = ""
      )
      writeLines(contenido, file)
    }
  )
  
  # --- FIN LÓGICA PIZARRA GLOBAL ---  
  
  # ---DRa clara
  claritaServer("clarita_pizarra", seccion_reactiva = reactive("pizarra")) 
  
  # Quizzes
  observeEvent(input$submit2, { output$feedback2 <- renderText(if (input$q1 == "b" && input$q2 == "a") "✅ Correcto" else "❌ Revisa tus respuestas") })
  observeEvent(input$submit3, { output$feedback3 <- renderText(if (input$q3 == "b" && input$q4 == "c") "✅ Correcto" else "❌ Revisa tus respuestas") })
  observeEvent(input$submit4, { output$feedback4 <- renderText(if (input$q5 == "a") "✅ Correcto" else "❌ Incorrecto") })
  observeEvent(input$submit5, { output$feedback5 <- renderText(if (input$q6 == "a") "✅ Correcto" else "❌ Incorrecto") })
  observeEvent(input$submit6, { output$feedback6 <- renderText(if (input$q7 == "a") "✅ Correcto" else "❌ Incorrecto") })
  observeEvent(input$submit7, { output$feedback7 <- renderText(if (input$q8 == "a") "✅ Correcto" else "❌ Incorrecto") })
  observeEvent(input$submit8, { output$feedback8 <- renderText(if (input$q9 == "a") "✅ Correcto" else "❌ Incorrecto") })
  observeEvent(input$submit9, { output$feedback9 <- renderText(if (input$q10 == "a") "✅ Correcto" else "❌ Incorrecto") })
  observeEvent(input$submit10, { output$feedback10 <- renderText(if (input$q11 == "a") "✅ Correcto" else "❌ Incorrecto") })
  
  # Respuestas sugeridas
  observeEvent(input$sol2, { output$resp2 <- renderText("Respuesta sugerida: Limitarse a encuestas es insuficiente. Se deberían combinar entrevistas a jueces y análisis documental.") })
  observeEvent(input$sol3, { output$resp3 <- renderText("Respuesta sugerida: Reformulación: ¿Qué barreras enfrentan las mujeres de bajos ingresos para acceder a la justicia en materia de violencia doméstica?") })
  observeEvent(input$sol4, { output$resp4 <- renderText("Respuesta sugerida: Conceptos: sostenibilidad, responsabilidad estatal, derecho ambiental.") })
  observeEvent(input$sol5, { output$resp5 <- renderText("Respuesta sugerida: Obj. general: Analizar la aplicación de la Ley 19.580. Obj. específicos: 1) Examinar sentencias, 2) Entrevistar a operadores.") })
  observeEvent(input$sol6, { output$resp6 <- renderText("Respuesta sugerida: Hipótesis: A mayor cantidad de juzgados ........") })
  observeEvent(input$sol7, { output$resp7 <- renderText("Respuesta sugerida: Indicadores: % mujeres juezas, % mujeres en tribunales superiores, tiempos de ascenso por género.") })
  observeEvent(input$sol8, { output$resp8 <- renderText("Respuesta sugerida: Población: estudiantes universitarios. Muestra: estudiantes del CENUR LN seleccionados aleatoriamente.") })
  observeEvent(input$sol9, { output$resp9 <- renderText("Respuesta sugerida: Método mixto: estadísticas sobre ingresos + entrevistas jefe/a de hogar.") })
  observeEvent(input$sol10, { output$resp10 <- renderText("Respuesta sugerida: Entrevista con preguntas sobre barreras tecnológicas, percepción de eficacia, propuestas de mejora.") })
}

shinyApp(ui, server)
