
#!/bin/sh -l


Rscript -e "rsconnect::setAccountInfo(name='metrotransitmn', token='${SHINYAPPSIO_TOKEN}', secret='${SHINYAPPSIO_SECRET}')"
Rscript -e "rsconnect::deployApp(appDir = '.',      account = 'metrotransitmn', server = 'shinyapps.io', appName = 'bus-service-allocation-study',      appTitle = 'bus-service-allocation-study', lint = FALSE, metadata = list(asMultiple = FALSE, asStatic = FALSE,          ignoredFiles = 'lit/DRAFT.Intermediate.Scenario.Evaluation.Memo_20201230.pdf'),      logLevel = 'verbose')"
