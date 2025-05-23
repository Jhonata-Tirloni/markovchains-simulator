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


what_are_markov_chains <- function(current_page) {
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
    h1("Definition¹: Markov process",
       style = "font-size: 1.8rem; 
              font-weight: bold;
              color: #2D2473;
              margin-left: 0.9rem;"),
    card(
      class = "shadow-none",
      card_body(
        p("A stochastic sequence (or random sequence) Z, defined over a timeline 
          of states or steps Y, is called a Markov process if only the current 
          state or step n on the timeline Y influences the next state or step n+1. 
          In other words, the future depends only on the present, not on the past.",
          style = "font-size: 1.2rem;")
      )
    ),
    h4("Example¹:",
       style = "margin-left: 0.9rem;"),
    layout_columns(
      col_widths=c(5,6),
      card(class = "shadow-none",
           card_body(
             card_image(
               src="simple_markovian_process.png",
               style = "display: block; margin: auto; width: 12rem;"
             )
           )
      ),
      card(class = "shadow-none",
           card_body(
             p("The Figure 1 shows a simple example of a Markovian process, where the current 
               state X, on the point of time t, equal to x (Xt = x), can transition 
               to either state Y or Z at the next time step t+1 ((Xt+1 = y | Xt = x) ∨ (Xt+1 = z | Xt = x)), 
               with probabilities p and 1−p, respectively. 
               The process depends only on the current state, not on how it got 
               there. If we could put this altogether on a single formula, 
               we would have something like this:"),
             card(class = "shadow-none",
                  card_body(
                    card_image(
                      src = "complete_markovian_property.png",
                      style = "display: block; margin: auto; width: 25rem;"
                    )
                  )
             ),
             p("We could resume it to something of these sorts, that we call the
               Markov Property:"),
             card(class = "shadow-none",
                  card_body(
                    card_image(
                      src = "resume_markov_property.png",
                      style = "display: block; margin: auto; width: 18rem;"
                    )
                  )
             )
           )
      )
    ),
    h1("Definition²: Markov chain",
       style = "font-size: 1.8rem; 
              font-weight: bold;
              color: #2D2473;
              margin-left: 0.9rem;"),
    card(
      class = "shadow-none",
      card_body(
        p("A stochastic sequence with finite or countably infinite number of states/steps, 
          where the next state in the sequence depends only on the current state, 
          not on the past ones. That is, given the present state at step n ∈ N, 
          the next state at step n+1 is determined solely by it, along a timeline Y.",
          style = "font-size: 1.2rem;")
      )
    ),
    h4("Example²:",
       style = "margin-left: 0.9rem;"),
    layout_columns(
      col_widths=c(6,5),
      card(class = "shadow-none",
           card_body(
             p("On the Figure 2 example, you move from state 1 to state 2 with 
             probability 1. From state 3, you move either to 1 or 2 with equal 
             probability 1/2, and from state 2 you jump to 3 with probability 1/3; 
             otherwise, you remain in state 2. (J. R. Norris)."),
             p("In this example, we say that the Markov process is in discrete time, 
             because each transition occurs at a distinct step with a well-defined 
             probability. Each step represents a time unit t ∈ N+."),
             p("Note that, here, opposed to the last example, we have a sequence 
               of possible states/steps with well defined probabilities for each 
               possible outcome, has of the last example we had a single state with 
               only two possible outcomes that would end the process."),
           )
      ),
      card(class = "shadow-none",
           card_body(
             card_image(
               src="figure_2.png",
               style = "display: block; margin: auto; width: 12rem;"
             )
           )
      )
    ),
    br(),
    br(),
    h1("Important properties and components",
       style = "font-size: 1.8rem; 
              font-weight: bold;
              color: #2D2473;
              margin-left: 0.9rem;"),
    p("Now that we know what is a Markov process, it's main property called
      the Markov Property and how they go altogether to make a Markov chain,
      we must know one key propertie and one essential component of all this.",
      style = "margin-left: 0.9rem;"),
    h2("Component: Probability matrix",
       style = "font-size: 1.8rem; 
              font-weight: bold;
              color: #2D2473;
              margin-left: 0.9rem;"),
    p("Whether it is a Markov process or a Markov chain, we need to define the 
      probabilities of transitioning between states over time. This is done using 
      the transition probability matrix. The transition matrix tells us, for each 
      step n, the probabilities of moving from the current state to any other 
      state in the process or chain Z. For instance, a given transition might 
      occur with probability y, and another with probability 1−y, depending on 
      the current state.",
      style = "margin-left: 0.9rem;"),
    h4("Example:",
       style = "margin-left: 0.9rem;"),
    layout_columns(
      card(class = "shadow-none",
           card_body(
             p("Imagine that you work on a metereological station and, after a 
               long process of data gathering and analysis you come to a conclusion 
               that, for every sunny day you have a probability that, the next day, 
               can be rainy. If we could draw that to a matrix for better visual 
               understanding, we would end up with something of the likes of the 
               figure 3. "),
             p("This figure tells us that, the probability P that we can have a 
               rainy day R being that today is a sunny day S is equal to 0,7 
               or 70%."),
             p("This way, is easy to prove that, or predict whats the probabilty 
               to have a sunny day tomorrow, being that today was a rainy day 
               (Figure 4), using the markovian property."),
           )
      ),
      col_widths=c(6,5),
      card(class = "shadow-none",
           card_body(
             card_image(
               src="probability_matrix_example.png",
               style = "display: block; margin: auto; width: 25rem;"
             )
           )
      )
    ),
    h2("Propertie: Discrete and continuous time",
       style = "font-size: 1.8rem; 
              font-weight: bold;
              color: #2D2473;
              margin-left: 0.9rem;"),
    p("A Markov chain can be discrete or continuous depending on how time is 
      considered in the model. 
      In a discrete-time Markov chain, changes in state happen at fixed time steps 
      (e.g., every second, every day). We use a transition matrix to describe the 
      probabilities of moving from one state to another at each step.
      In a continuous-time Markov chain, changes can happen at any moment in time. 
      Instead of a transition matrix, we use a rate matrix (also called a 
      generator matrix) to describe the likelihood of transitioning between 
      states over time.",
      style = "margin-left: 0.9rem;"),
    h4("Example:",
       style = "margin-left: 0.9rem;"),
    layout_columns(
      card(class = "shadow-none",
           card_body(
             card_image(
               src="time_example.png",
               style = "display: block; margin: auto; width: 25rem;"
             )
           )
      ),
      card(class = "shadow-none",
           card_body(
             p("The choice between discrete and continuous time depends on the 
               real-world process you're modeling. For example:"),
             p("* If you're modeling steps in a board game or website clicks, 
               discrete time makes sense."),
             p("* If you're modeling events like machine failures or patient arrivals 
               in a hospital, which can happen at any time, continuous time is 
               more appropriate."),
           )
      ),
      col_widths=c(6,5)
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