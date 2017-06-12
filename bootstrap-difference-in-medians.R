

        rm(list=ls())
      set.seed(123)
        startTime<-proc.time()
        library(knitr)
        options(width=120)
        opts_chunk$set(comment = "", warning = FALSE, message = FALSE,
                       echo = FALSE, tidy = FALSE, size="tiny",  cache=FALSE,
                       progress=TRUE, #results='hide',
                       fig.width=7, fig.height=3.5,
                       cache.path = 'program_Cache/',
                       fig.path='figure/')

        

        knitr::knit_hooks$set(inline = function(x) {
          knitr:::format_sci(x, 'md')
        })

        # create an R file of the code!

        # https://stackoverflow.com/questions/26048722/knitr-and-tangle-code-without-execution

       

         knit_hooks$set(purl = function(before, options) {
           if (before) return()
           input  = current_input()  # filename of input document
           output = paste(tools::file_path_sans_ext(input), 'R', sep = '.')
           if (knitr:::isFALSE(knitr:::.knitEnv$tangle.start)) {
           assign('tangle.start', TRUE, knitr:::.knitEnv)
           unlink(output)
         }

         cat(options$code, file = output, sep = '\n', append = TRUE)

         })
         
         
         
     list.of.packages <- c("boot")  # haven causes a problem

     new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

     if(length(new.packages)) install.packages(new.packages)

     sapply(X = list.of.packages, require, character.only = TRUE)

        



      set.seed(12434)
 
      x<-rnorm(70, 0, 5) 
      y<-rnorm(130, 5 ,5)
      
      n1 <- length(x) 
      n2 <- length(y)
      
      y1 <- c(x,y)
      
      group <- c(rep(1, each=n1),rep(2, each=n2))
      
      xx <- as.data.frame(cbind(group, y1))
     
      tapply(xx[,2], xx[,1], median, na.rm=T)  # check
   
     
      bo <- boot(data=x,
                 
      statistic = function(x, i) {
        
      booty <- tapply(xx$y, xx$group, FUN=function(x) X =sample(x,length(x),TRUE))
          diff(sapply(booty, median))
           }, 
      
      R=10000)
      
      boot.ci(bo)
 


options(width=70)
#opts_knit$set(root.dir = wd)   ##THIS SETS YOUR WORKING DIRECTORY
sessionInfo()
#print(getwd())
stopTime<-proc.time()




# move stangle R file to a folder in GPS
# put this at bottom and give it the same name as the RMD file , replace any blanks with underscore
# https://amywhiteheadresearch.wordpress.com/2014/11/12/copying-files-with-r/

filename <- "bootstrap difference in medians.Rmd"
rcode <-  gsub(' ','_', trimws(filename)) # replace blank with underscore, this is needed
rcode <-  gsub('md','', rcode) 
#file.copy(rcode, wd,  overwrite=TRUE)           # make a copy of the rcode in a folder of choice

