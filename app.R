source("modules/global.R")


ui <- page_fluid(
  uiOutput("main_ui")
)

server <- function(input, output, session) {
  
  output$main_ui <- renderUI({
    switch(current_page(),
           "home" = home_ui(),
           "about_markov_chains" = what_are_markov_chains(current_page),
           "keyboard_markov_chains" = practical_simulator(current_page)
    )
  })
  
  current_page <- reactiveVal("home")
  
  observeEvent(input$what_are_markov_chains, {
    current_page("about_markov_chains")
  })
  
  observeEvent(input$keyboard_simulator, {
    current_page("keyboard_markov_chains")
  })
  
  observeEvent(input$back_home, {
    current_page("home")
  })
  # --- Lógica do teclado
  all_keys <- unlist(list(
    c("Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"),
    c("A", "S", "D", "F", "G", "H", "J", "K", "L"),
    c("Z", "X", "C", "V", "B", "N", "M", "Return"),
    c("Space")
  ))
  
  last_key_pressed <- reactiveVal("")
  
  observe({
    lapply(all_keys, function(key) {
      key_id <- paste0("key_", gsub(" ", "_", tolower(key)))
      observeEvent(input[[key_id]], {
        last_key_pressed(key)
      })
    })
  })
  
  output$last_key <- renderText({
    last_key_pressed()
  })
  
  # --- Cadeias
  keyboard_keys <- c(LETTERS, "Return", "Space")
  typed_text <- reactiveVal("")
  last_key <- reactiveVal("")
  
  observe({
    lapply(keyboard_keys, function(key) {
      key_id <- paste0("key_", tolower(key))
      observeEvent(input[[key_id]], {
        last_key(key)
        
        current <- typed_text()
        
        if (key == "Return") {
          typed_text(paste0(current, "\n"))
        } else if (key == "Space") {
          typed_text(paste0(current, " "))
        } else {
          typed_text(paste0(current, key))
        }
      }, ignoreInit = TRUE)
    })
  })
  
  # Exibe o texto digitado e a última tecla
  output$typed_text <- renderText({ typed_text() })
  output$last_key <- renderText({ last_key() })
  
  # --- Matriz de probabilidade e previsão com quanteda
  output$probability_matrix <- renderPrint({
    req(last_key() == "Space")
    words <- strsplit(typed_text(), "\\s+")[[1]]
    last_word <- tolower(tail(words[words != ""], 1))
    
    if (last_word %in% names(transition_probs)) {
      transition_probs[[last_word]][, c("word2", "prob")]
    } else {
      "No prediction available."
    }
  })
  
  output$next_word_prediction <- renderText({
    req(last_key() == "Space")
    words <- strsplit(typed_text(), "\\s+")[[1]]
    last_word <- tolower(tail(words[words != ""], 1))
    
    if (last_word %in% names(transition_probs)) {
      top_words <- transition_probs[[last_word]] %>%
        arrange(desc(prob)) %>%
        slice_head(n = 3)
      paste(top_words$word2, collapse = ", ")
    } else {
      "No prediction available."
    }
  })
  
  # --- Delete do teclado
  observeEvent(input$key_delete_word, {
    current <- typed_text()
    words <- strsplit(current, "\\s+")[[1]]
    if (length(words) > 1) {
      new_text <- paste(head(words, -1), collapse = " ")
      typed_text(paste0(new_text, " "))
    } else {
      typed_text("")
    }
  })
}

shinyApp(ui, server)