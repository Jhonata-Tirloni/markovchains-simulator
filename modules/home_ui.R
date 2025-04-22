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

home_ui <- function() {
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
        p("About this app",
          style = "font-size: 1.8rem; font-weight: bold; color: #2D2473;"
        )
      ),
      card_body(
        p("This web app has been developed as a part of a class about Markov Chain’s and its application for the master’s degree 
               on applied computation at the Universidade Federal de Mato Grosso. Feel free to use and explore the app as you want.",
          style = "font-size: 1.2rem;"),
        p("On the top right side of this homepage you will find the link to this app’s repository on github, in case you want 
               to develop your own version of it. ",
          style = "font-size: 1.2rem;")
      )
    ),
    
    # SELECT A OPTION
    h1("Select a Option",
       style = "font-size: 1.6rem; 
              font-weight: bold;
              color: #2D2473;
              margin-left: 0.9rem;"),
    layout_columns(
      fill = FALSE,
      row_heights = c(1,1,1),
      style = "margin-left: 1rem;
             margin-right: 1rem;",
      gap = "1.0rem",
      actionButton(
        "what_are_markov_chains",
        card_body(
          card_image(
            src="markov_chain_example.png",
            style = "display: block; margin: auto; width: 12rem;"
          ),
          p("What are markov chains?",
            style = "color: #006CB1;
                     font-size: 1.2rem;"),
          p("What is a Markov chain, how does it works and it's main concepts
            that we need to know.",
            style = "font-size: 0.9rem;")
        )
      ),
      actionButton(
        "how_are_markov_chains_applied",
        card_body(
          card_image(
            src="how_markov_chains_are_applied.png",
            style = "display: block; margin: auto; width: 12rem;"
          ),
          p("How Markov chains are applied?",
            style = "color: #006CB1;
                     font-size: 1.2rem;"),
          p("How we use the concept of Markov chains daily, and applied examples
            of it's potential.",
            style = "font-size: 0.9rem;")
        )
      ),
      actionButton(
        "keyboard_simulator",
        card_body(
          card_image(
            src="keyboard_simulator.png",
            style = "display: block; 
                   margin: auto; 
                   width: 12rem;"
          ),
          p("Practical simulator",
            style = "color: #006CB1;
                   font-size: 1.2rem;"),
          p("Let's see how a Markov chain can be applied on our dear keyboards
          with it's auto-correction!",
            style = "font-size: 0.9rem;")
        )
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
    layout_columns(
      actionButton(
        "bibliography_mc_mt",
        card_image(
          src = "bibliography_mc_mt.png",
          style = "
                 display: block;
                 margin: auto;
                 width: 25rem;
                "
        )
      ),
      actionButton(
        "bibliography_mc",
        card_image(
          src = "bibliography_mc.png",
          style = "
                 display: block;
                 margin: auto;
                 width: 25rem;
                "
        )
      ),
      actionButton(
        "bibliography_pc_p",
        card_image(
          src = "bibliography_pc_p.png",
          style = "
                 display: block;
                 margin: auto;
                 width: 25rem;
                "
        )
      )
    ),
    tags$br(),
    tags$br(),
    # FOOTER
    tags$div(
      tags$img(src = "Footer.png", style = "max-width: 70%; height: auto; padding: 0; margin: 0;"),
      style = "padding: 0; margin: 0; text-align: center;"
    ))
}