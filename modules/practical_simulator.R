source("modules/home_ui.R")

library(quanteda)
library(dplyr)
library(stringr)
library(quanteda.textstats)

# 1. Pré-processar bigramas com quanteda
corpus <- quanteda::data_corpus_inaugural
tokens <- quanteda::tokens(corpus, what = "word", remove_punct = TRUE)
bigrams <- quanteda::tokens_ngrams(tokens, n = 2)
dfm_bigrams <- quanteda::dfm(bigrams)
bigram_freq <- textstat_frequency(dfm_bigrams)

# 2. Transformar em data.frame de duas palavras e contar frequência
bigram_df <- bigram_freq %>%
  mutate(
    word1 = word(feature, 1, sep = "_"),
    word2 = word(feature, 2, sep = "_")
  ) %>%
  group_by(word1) %>%
  mutate(prob = frequency / sum(frequency)) %>%
  ungroup()

# 3. Lista de transições por palavra
transition_probs <- split(bigram_df, bigram_df$word1)

link_github <- tags$a(
  shiny::icon("github"),
  "Project's Github",
  href = "https://github.com/Jhonata-Tirloni/markovchains-simulator",
  target = "_blank",
  class = "github-btn"
)

link_contact <- tags$a(
  shiny::icon("linkedin"),
  "Contact",
  href = "https://www.linkedin.com/in/jhonata-tirloni/",
  target = "_blank"
)

link_home <- actionLink(
  "back_home",
  shiny::icon("home")
)

keyboard_rows <- list(
  c("Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"),
  c("A", "S", "D", "F", "G", "H", "J", "K", "L", "Ç"),
  c("Z", "X", "C", "V", "B", "N", "M")
)

practical_simulator <- function(current_page) {
  tagList(
    # MAIN NAVBAR
    tags$head(
      tags$style(HTML("
    .navbar-brand {
      color: #2D2473 !important;
    }
    
    .github-btn {
      background-color: #2D2473;
      color: white !important;
      padding: 6px 12px;
      border-radius: 5px;
      text-decoration: none;
      transition: background-color 0.3s ease;
    }

    .github-btn:hover {
      background-color: #1a184d;
      text-decoration: none;
    }
    
    .btn:hover {
      background-color: inherit !important;
      color: inherit !important;
      border-color: #e6e6e6 !important;
      box-shadow: 0 2px 4px #e6e6e6 !important;
      text-decoration: none !important;
    }
    
    .btn{
      border-color: #f7f7f7;
      border-radius: 1rem;
    }
    
    .key-button {
      width: auto;
      height: auto;
      font-size: 0.9rem;
      margin: 3px;
      background-color: white;
      border: none;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.2);
    }
    .keyboard-container {
      background-color: #d9d9d9;
      padding: 5px;
      border-radius: 10px;
    }
    .prob-matrix {
      background-color: #fafafa;
      border-radius: 16px;
      min-height: 180px;
      padding: 1rem;
      font-family: monospace;
    }
      "))
    ),
    page_navbar(
      title = "Markov chains simulator",
      nav_item(link_home,
               align = "right"),
      nav_spacer(),
      nav_item(link_contact, 
               align = "right"),
      nav_item(),
      nav_item(link_github, 
               align = "right")
    ),
    
    # ABOUT
    card(
      class = "shadow-none",
      card_title(
        p("How to use",
          style = "font-size: 1.8rem; font-weight: bold; color: #2D2473;"
        )
      ),
      card_body(
        p("Press the letters on your keyboard to write a phrase. Whenever you press space the algorithm will try to calculate
          the next possible word, based on the actual written letters, and give you three suggestions of possible outcomes. The
          probability matrix on the right side of the keyboard below will show the probability output for each suggested outcome.",
          style = "font-size: 1.2rem;")
      )
    ),
    tags$br(),
    card(
      full_screen = FALSE,
      style = "padding: 0.1rem; 
               background-color: #f3f3f9;
               margin-left: 1.3rem;
               margin-right: 1.3rem;",
      card_title("Written text"),
      div(
        style = "background-color: #fafafc; 
                 border-radius: 1rem;
                 padding: 1rem;
                 box-shadow: 0 0 0 transparent;
                 margin-left: 1.3rem;
                 margin-right: 1.3rem;",
        card_body(
          textOutput("typed_text"),
          style = "min-height: 50px;"
        )
      )
    ),
    card(
      full_screen = FALSE,
      style = "padding: 0.1rem; 
               background-color: #f3f3f9;
               margin-left: 1.3rem;
               margin-right: 1.3rem;",
      card_title("Possible next word"),
      div(
        style = "background-color: #fafafc; 
                 border-radius: 1rem; 
                 padding: 1rem; 
                 box-shadow: 0 0 0 transparent;
                 margin-left: 1.3rem;
                 margin-right: 1.3rem;",
        card_body(
          textOutput("next_word_prediction"),
          style = "min-height: 50px;"
        )
      )
    ),
    div(
      class = "keyboard-matrix-wrapper",
      style = "display: flex; 
              flex-wrap: wrap; 
              justify-content: center; 
              gap: 0.5rem;",
      
      # Coluna 1: Teclado
      div(
        class = "keyboard-container",
        style = "flex: 1; min-width: 300px;",
        
        # Linhas do teclado
        lapply(seq_along(keyboard_rows), function(row_idx) {
          div(
            style = "display: flex; justify-content: center; flex-wrap: wrap;",
            lapply(keyboard_rows[[row_idx]], function(key) {
              key_id <- paste0("key_", gsub(" ", "_", tolower(key)))
              actionButton(
                inputId = key_id,
                label = key,
                class = "key-button"
              )
            })
          )
        }),
        
        # Tecla especial de espaço
        tags$br(),
        div(
          style = "display: flex; justify-content: center; width: 100%;",
          actionButton(
            inputId = "key_space",
            label = "Space",
            class = "key-button",
            style = "width: 90%; height: 40px; font-size: 1rem;"
          )
        ),
        div(
          style = "display: flex; justify-content: center; width: 100%; margin-top: 0.5rem;",
          actionButton(
            inputId = "key_delete_word",
            label = "Delete word",
            class = "key-button",
            style = "width: 50%; height: 35px; font-size: 0.9rem; background-color: #ffcccc;"
          )
        )
      ),
      
      # Coluna 2: Probability Matrix
      div(
        class = "prob-matrix",
        style = "flex: 1; max-width: 43.9%;",
        p("Probability Matrix"),
        verbatimTextOutput("probability_matrix")
      )
    ),
    tags$br(),
    tags$br(),
    tags$br(),
    tags$br(),
    tags$br(),
    tags$br(),
    # FOOTER
    tags$div(
      tags$img(src = "Footer.png", style = "width: 70%; height: auto; padding: 0; margin: 0;"),
      style = "padding: 0; margin: 0; text-align: center;"
    )
  )
}