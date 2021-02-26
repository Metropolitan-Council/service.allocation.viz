# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
service.allocation.viz::run_app() # add parameters here (if any)


# rsconnect::deployApp(appDir = '.',      account = 'metrotransitmn', server = 'shinyapps.io', appName = 'bus-service-allocation-study',      appTitle = 'bus-service-allocation-study',  lint = FALSE, metadata = list(asMultiple = FALSE, asStatic = FALSE,          ignoredFiles = 'lit/DRAFT.Intermediate.Scenario.Evaluation.Memo_20201230.pdf'),      logLevel = 'verbose')
