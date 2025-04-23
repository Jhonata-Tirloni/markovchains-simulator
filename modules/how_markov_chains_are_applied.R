source("modules/home_ui.R")

link_github <- tags$a(
  shiny::icon("github"),
  "Project's Github",
  href = "https://github.com",
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


how_markov_chains_are_applied <- function(current_page) {
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
    },
      "))
    ),
    page_navbar(
      title = "Markov chains simulator",
      nav_item(link_home,
               align = "right"),
      nav_spacer(),
      nav_item(link_contact, 
               align = "right"),
      nav_item(link_github, 
               align = "right")
    ),
    
    # ABOUT
    card(
      class = "shadow-none",
      card_body(
        p("On this page, we’ll explore what a Markov process is, 
          how it leads to the concept of a Markov chain, its basic structure and 
          key feature—the Markov property—along with some simple examples.",
          style = "font-size: 1.2rem;"),
        p("Please note that Markov chains, as probability models, are part of a 
          much broader field of statistics and mathematics, which this app does 
          not fully cover. If you're curious and want to dive deeper into the topic, 
          i highly recommend checking out the reference books listed on the Home page.",
          style = "font-size: 1.2rem;"),
        p("Also keep in mind that this is a simplified overview. Many important 
          aspects of Markov processes and chains are not included here. Still, 
          with the content presented, you’ll gain a general understanding of what 
          the topic is about and how it works from a high-level perspective.",
          style = "font-size: 1.2rem;")
      )
    ),
    tags$br(),
    tags$br(),
    tags$br(),
    tags$br(),
    # BIBLIOGRAPHIC REFERENCES
    h1(
      "Bibliographic reference",
      style = "
             font-size: 1.6rem;
             font-weight: bold;
             color: #2D2473;
             margin-left: 0.9rem;
            "
    ),
    tags$br(),
    tags$br(),
    # FOOTER
    tags$div(
      tags$img(src = "Footer.png", style = "width: 70%; height: auto; padding: 0; margin: 0;"),
      style = "padding: 0; margin: 0; text-align: center;"
    )
  )
}