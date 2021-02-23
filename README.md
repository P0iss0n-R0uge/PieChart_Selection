# PieChart_Selection
trying out highchart callback for pie chart selection in R shiny
See [here](https://stackoverflow.com/questions/60190866/event-to-capture-unselect-category) for the selection issue of highcharts select & unselect 
* Run shiny app from GitHub
```R
shiny::runGitHub('P0iss0n-R0uge/PieChart_Selection', ref = 'main')
```

* Environment info
```R
> sessionInfo()
R version 3.6.0 (2019-04-26)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 18.04.2 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.7.1
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.7.1

locale:
 [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8        LC_COLLATE=C.UTF-8    
 [5] LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8    LC_PAPER=C.UTF-8       LC_NAME=C             
 [9] LC_ADDRESS=C           LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] highcharter_0.8.2    dplyr_1.0.4          shinydashboard_0.7.1 shiny_1.3.2         

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.1        pillar_1.4.7      compiler_3.6.0    later_0.8.0       xts_0.11-2        tools_3.6.0      
 [7] digest_0.6.19     lubridate_1.7.4   jsonlite_1.6      lifecycle_0.2.0   tibble_2.1.3      nlme_3.1-140     
[13] lattice_0.20-38   pkgconfig_2.0.2   rlang_0.4.10      igraph_1.2.6      cli_1.1.0         DBI_1.1.0        
[19] rstudioapi_0.10   yaml_2.2.0        curl_3.3          stringr_1.4.0     generics_0.0.2    vctrs_0.3.6      
[25] htmlwidgets_1.3   grid_3.6.0        tidyselect_1.1.0  data.table_1.12.2 glue_1.4.2        mongolite_2.1.0  
[31] R6_2.5.0          TTR_0.24.2        purrr_0.3.4       tidyr_1.1.2       magrittr_1.5      backports_1.1.4  
[37] promises_1.0.1    ellipsis_0.3.0    htmltools_0.3.6   rlist_0.4.6.1     quantmod_0.4.18   assertthat_0.2.1 
[43] mime_0.7          xtable_1.8-4      httpuv_1.5.1      stringi_1.4.3     broom_0.5.2       crayon_1.3.4     
[49] zoo_1.8-6        
```
