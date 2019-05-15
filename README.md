
# “Why won’t this run again?\!”: Making R analysis more reproducible

[Andrew Heiss, PhD](https://www.andrewheiss.com) • Brigham Young
University  
May 14, 2019 • Utah County R Users Group

-----

  - [Slides](#slides)
  - [General resources for
    reproducibility](#general-resources-for-reproducibility)
  - [Example methods](#example-methods)
      - [Code only](#code-only)
      - [Code and data](#code-and-data)
      - [Code and data + Makefile](#code-and-data--makefile)
      - [R Markdown report](#r-markdown-report)
      - [R Markdown website](#r-markdown-website)
      - [`rrtools`](#rrtools)
      - [`renv`](#renv)
      - [Docker](#docker)
      - [Binder](#binder)

-----

# Slides

[Download the slides from today’s
talk](presentation/andrew-heiss_2019-05-14_utah-county-rug_reproducibility.pdf)

<img src="presentation/slides-thumb.png" width="75%" style="display: block; margin: auto;" />

# General resources for reproducibility

  - [The National Academies of Science’s recommendations for
    reproducibility](http://www8.nationalacademies.org/onpinews/newsitem.aspx?RecordID=25303)
  - Karl Broman’s [tutorials on initial steps toward reproducible
    research](http://kbroman.org/steps2rr/)
  - Karl Broman’s talk [“Steps toward reproducible
    research”](https://github.com/kbroman/Talk_RRBoston2019)
  - Kirstie Whitaker’s [“A how to guide to reproducible
    research”](https://figshare.com/articles/A_how_to_guide_to_reproducible_research/5886475)

# Example methods

Examples of each of these are included in this repository. Click on the
big green “Clone or download” button at the top of the GitHub page and
download the .zip file to follow along.

## Code only

All code included in a single fairly well-commented file. Data is not
included; must either be downloaded separately or obtained from authors.

Real life examples:

  - Most R code out in the wild :)

How to use:

  - Download and open `analysis.R`
  - Try to run it
  - Install missing packages as needed
  - Hope packages are the correct version
  - Track down data if/when missing

## Code and data

All code is included in multiple well-commented files. Data is included
in `data/`. Folder is structured as an [RStudio
project](https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects).

Real life examples:

  - [Attitudes in the Arab
    World](https://github.com/andrewheiss/Attitudes-in-the-Arab-World)

How to use:

  - Download directory
  - Open `02_code-data.Rproj` to open a new RStudio instance
  - Run `process-data.R`, then `figure-1.R`, then `models_figure-2.R`
    (following the instructions in the project’s README file)
  - Install missing packages as needed (and hope they’re the right
    version)

## Code and data + Makefile

Same as the previous example, except now everything is automated with a
Makefile that runs the three R scripts in the correct order.

Real life examples:

  - [Nonprofit Collaboration and the Resurrection of Market
    Failure](https://github.com/andrewheiss/np-collaboration)

Writing Makefiles goes beyond the scope of this little demonstration,
but Karl Broman has some [excellent
resources](https://kbroman.org/minimal_make/) and
[tutorials](http://kbroman.org/steps2rr/pages/automate.html) about how
to use them.

How to use:

  - Make sure you have access to GNU `make`. On macOS open Terminal
    (found in /Applications/Utilities/) and run `xcode-select
    --install`. If you use Windows, check out [this Stat 545
    page](http://stat545.com/automation02_windows.html)
  - Download directory
  - Open `03_code-data_makefile.Rproj` to open a new RStudio instance
  - Open the terminal panel in RStudio and type `make output` (go to
    Tools \> Terminal \> New terminal if you don’t have a terminal panel
    available already)
  - Install missing packages as needed (and hope they’re the right
    version)

## R Markdown report

Here we use a single [R Markdown](https://rmarkdown.rstudio.com/) file
to conduct the analysis. This literate programming approach lets you mix
prose and code and creates a notebook for your analysis.

Real life examples:

  - Article 19 regional spending
    ([code](https://github.com/andrewheiss/a19-regional-spending);
    [website](https://stats.andrewheiss.com/a19/a19_expenditures.nb.html))

How to use:

  - Downlaod directory
  - Open `04_Rmd-report.Rproj` to open a new RStudio instance
  - Open `provo-weather.Rmd` and click on the “Knit” button near the top
    of the source editor; wait for R to generate an HTML file
  - Install missing packages as needed (and hope they’re the right
    version)

## R Markdown website

Here we use R Markdown’s built-in website capabilities to generate a
static website from a collection of `.Rmd` files. This allows you to
have a more complicated notebook with subpages that you can upload
anywhere online (your own private server, GitHub pages, etc.), or keep
locally on your computer.

See the [R Markdown Websites
documentation](https://rmarkdown.rstudio.com/lesson-13.html) for
complete details of this approach. Here’s the tl;dr version:

  - Click on the “Build website” button in the Build panel in RStudio to
    build the website
  - The generated site will be in `_site/`. Put this somewhere online if
    you want.
  - `_site.yml` controls what goes in the navigation bar controls other
    site generation settings
  - `index.Rmd` is the home page (it is required)
  - R will knit all `.Rmd` files in the root directory in alphabetical
    order. To ensure the order they’re knit in (i.e. if one depends on
    another), prefix them with numbers.
      - By default all the `.Rmd` files will share the same environment
        (i.e. if one file runs `library(tidyverse)`, tidyverse functions
        will be available in the next file). If you don’t want this to
        happen (you don’t), make sure `new_session: true` is set in
        `_site.yml`, which makes each `.Rmd` use a clean environment.

Real life examples:

  - The Power of Ranking: The Ease of Doing Business Indicator as a Form
    of Social Pressure
    ([website](https://stats.andrewheiss.com/edb-social-pressure/);
    [GitHub](https://github.com/andrewheiss/edb-social-pressure))
  - NGO Crackdowns and Philanthropy
    ([website](https://stats.andrewheiss.com/ngo-crackdowns-philanthropy/);
    [GitHub](https://github.com/andrewheiss/ngo-crackdowns-philanthropy))
  - Why Donors Donate
    ([website](https://stats.andrewheiss.com/why-donors-donate/);
    [GitHub](https://github.com/andrewheiss/why-donors-donate))
  - Are Donors Really Responding? Analyzing the Impact of Global
    Restrictions on NGOs
    ([website](https://stats.andrewheiss.com/donors-ngo-restrictions/);
    [GitHub](https://github.com/andrewheiss/donors-ngo-restrictions))

How to use:

  - Download directory
  - Open `05_Rmd-website.Rproj` to open a new RStudio instance
  - Click on “Build website” in the “Build” panel
  - Navigate the preview that appears in RStudio or open
    `_site/index.html` in your browser
  - Install missing packages as needed (and hope they’re the right
    version)

## `rrtools`

Ben Marwick’s `rrtools` package allows you to create a “research
compendium,” or a self-contained R package that includes your analysis,
data, R functions, and final paper that users can install with
`devtools::install()` (or `devtools::install_github()` if you have your
project hosted at GitHub).

Because the project is structured as a package, R will handle package
dependencies for you automatically. You can also include your commonly
used custom functions into the package, letting you include things like
`library(myreproducibleproject)` or
`myreproducibleproject::custom_function()` in your project.

Real life examples:

  - Are Donors Really Responding? Analyzing the Impact of Global
    Restrictions on NGOs
    ([website](https://stats.andrewheiss.com/donors-ngo-restrictions/);
    [GitHub](https://github.com/andrewheiss/donors-ngo-restrictions))
  - Why Donors Donate
    ([website](https://stats.andrewheiss.com/why-donors-donate/);
    [GitHub](https://github.com/andrewheiss/why-donors-donate))

To create your own compendium [follow the instructions at the
README](https://github.com/benmarwick/rrtools). Here’s the tl;dr
version:

  - Run `library(rrtools)`
  - Run `create_compendium("nameofyourpackage")`
  - Open the new RStudio project that rrtools created
  - Put your analysis in `analysis/`; put your data in `analysis/data/`;
    put your paper in `analysis/paper/`
  - Put custom functions in `R/` and use roxygen2 to document them
  - Use `library(nameofyourpackage)` to access your custom functions
  - Build your package by clicking on “Install and Restart” in the Build
    panel

In this example, I’ve put an R Markdown website in the analyses folder.
Since this project is already a package, the Build panel in R Studio is
configured to build a package, not a website. In order to build the
website, you’ll need to run `rmarkdown::render_site()`. I’ve included
this in a Makefile in `analysis/`, so you’ll need to open a terminal
panel and type `cd analysis`, then `make html` to generate the site.

How to use this example:

  - Download directory
  - Open `rrtools.Rproj` to open a new RStudio instance
  - Run `devtools::install(".", dependencies = TRUE)` to install the
    package and all its dependencies
  - Click on the Terminal panel in RStudio and type `cd analysis`
  - Type `make html`
  - Open `analysis/_site/index.html` in your browser

## `renv`

RStudio’s new (and still in-development) `renv` package lets you
maintain a local project-specific library of packages, similar to
Python’s `virtualenv` and `pyenv`. The [README for
`renv`](https://github.com/rstudio/renv) and the [introduction
vignette](https://rstudio.github.io/renv/articles/renv.html) explain how
it all works and how to get started. Here’s the tl;dr version:

  - The `renv.lock` file contains a list of all the packages your
    project uses, with version number and hashes. Don’t edit this
    manually; `renv` has functions that generate and update this for you
  - The `renv/activate.R` file is a script that tells R to use
    `renv/library/*` when you run `library(blah)`.
  - `renv/library/` contains a local package structure
  - `.Rprofile` has a new line in it that runs `renv/activate.R` when
    you start a new R session.
  - If you use version control (or if you’re distributing this project
    to others), you only need to track/include `renv.lock`, `.Rprofile`,
    and `renv/activate.R`. *Don’t* include the contents of
    `renv/library/`, since that is platform-specific and R will install
    packages there as needed.

How to use this example:

  - Download directory
  - Open `07_renv.Rproj` to open a new RStudio instance
  - Install `renv` with `devtools::install_github("rstudio/renv")`
  - Restart your R session (to make `.Rprofile` run `renv/activate.R`)
  - Wait as all dependencies are installed automatically
  - Click on “Build website” in the “Build” panel
  - Navigate the preview that appears in RStudio or open
    `_site/index.html` in your browser

## Docker

Docker allows you to create virtual machines (or containers) and run
stuff in them. Containers are essentially miniature Linux computers with
different pieces of software pre-installed. They’re great for spinning
up computers with *exact* versions of R and packages. You can access R
within the containers through your browser—open a URL like
`http://localhost:8787` to get to an RStudio instance within the
container.

Installing Docker and creating Dockerfiles goes beyond the scope of this
little demonstration, but there are a ton of resources out there to get
you started:

  - Colin Fay’s [“An Introudction to Docker for R
    Users”](https://colinfay.me/docker-r-reproducibility/)
  - [“A Docker tutorial for reproducible
    research”](https://ropenscilabs.github.io/r-docker-tutorial/)
  - My [“Super basic practical guide to Docker and
    RStudio”](https://www.andrewheiss.com/blog/2017/04/27/super-basic-practical-guide-to-docker-and-rstudio/)

The main advantage of creating reproducible Docker containers is that it
essentially lets other users **download and install a complete
standalone computer that is configured exactly how it was when you ran
your code**. It’s like the gold standard of reproducibility.

[The Rocker team](https://www.rocker-project.org/) has made this even
more gold standardy for R projects too. They maintain base Docker images
for each R version (3.5.1, 3.6.0, etc.), and these images are set up to
install packages from MRAN (Microsoft’s snapshot-based mirror of CRAN).
This means that if you use R 3.6.0, any packages you install will be at
the version they were when R was released.

Real life examples:

  - Are Donors Really Responding? Analyzing the Impact of Global
    Restrictions on NGOs
    ([website](https://stats.andrewheiss.com/donors-ngo-restrictions/);
    [GitHub](https://github.com/andrewheiss/donors-ngo-restrictions);
    [Dockerfile](https://github.com/andrewheiss/docker-donors-ngo-restrictions))

How to use this example:

  - Install [Docker Desktop for
    Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
    or [Docker Desktop for
    Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
  - Install [Kitematic](https://github.com/docker/kitematic) if you want
    a GUI for managing Docker containers (you do)
  - Download directory
  - Navigate to the directory in a terminal and type `docker build -t
    myproject .` to build all the required pieces
  - Wait while everything gets downloaded
  - Run `docker run -e PASSWORD=blah -p 8787:8787 myproject` to start
    the container
  - In your browser, go to <http://localhost:8787>. Log in using
    “rstudio” as the user name and “blah” as the password.
  - Open `provo-weather.Rmd` and knit it

## Binder

[Binder](https://mybinder.org/) is a more user-friendly version of the
Docker approach to reproducibility. Instead of requiring users to
install Docker and build the container image locally, Binder handles all
the hosting and provides access to a specific version of R and RStudio
in a browser.

It also provides a simpler way to install and configure packages—there’s
no need for complicated Dockerfiles (you can still use them, but
[they’re not
recommended](https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html)).
You need two extra files for this to work:

  - `runtime.txt`, which contains the date for the MRAN snapshot that
    you want to use for package installation (formatted as
    `r-YYYY-MM-DD`)
  - `install.R`, which contains R code for installing packages

[Instructions and examples are
here](https://mybinder.readthedocs.io/en/latest/sample_repos.html#specifying-an-r-environment-with-a-runtime-txt-file).
Here’s the tl;dr version:

  - Make sure your project is in its own public repository either at
    GitHub or GitLab
  - Create a `runtime.txt` file and `install.R` file in the root of your
    project
  - Go to [Binder](https://mybinder.org/), paste your repository’s URL
    into the form, and click on “Launch”
  - Wait for a looooong time (the binder container will rebuild every
    time you commit to the repository, which will also take a long time;
    if there are no commits, the container should open fairly quickly)
  - Binder will give you a URL when it’s done. If you open the URL as
    is, Binder will try to load your R files in a Jupyter notebook,
    which won’t work. Append `?urlpath=rstudio` to the URL to open the
    project in an RStudio instance
    (e.g. `https://mybinder.org/v2/gh/andrewheiss/binder-example/master?urlpath=rstudio`)

That’s all\!

How to use this example (*this example actually lives in a [separate
GitHub repository](https://github.com/andrewheiss/binder-example) so
that it can work with Binder*):

  - Go to
    <https://mybinder.org/v2/gh/andrewheiss/binder-example/master?urlpath=rstudio>
  - Open `provo-weather.Rmd` and knit it
