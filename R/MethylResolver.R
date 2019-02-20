#Least Trimmed Squares Regression (LTS Regression)
MethylResolver <- function(methylMix = NULL, methylSig = MethylSig, betaPrime = TRUE, outputPath = "./",
                           outputName = "MethylResolver", doPar = FALSE, numCores = 1,
                           alpha = 0.5, absolute = TRUE, purityModel = RFmodel) {
  
  i <- NULL ## To please R CMD check

  #User must provide a methylation mixture file
  if(is.null(methylMix)){
    cat("Please provide a methylation mixture file")
  } else{
    if(file.exists(file=paste0(outputPath,outputName,".txt"))){
      cat("LTS Deconvolution Already Exists For This Mixture...\n")
    } else{
      cat("Beginning LTS Deconvolution For This Mixture...\n")
      
      #Load the MethylResolver leukocyte signature, if default
      # if(is.character(methylSig)){
      #   if(methylSig == "default"){
      #     methylSig = MethylSig
      #   }
      # }

      #Format input matrices
      methylSig <- as.data.frame(methylSig)
      methylMix <- data.matrix(varhandle::unfactor(methylMix))
      overlappingCpGs = intersect(rownames(methylSig),rownames(methylMix))
      methylSig = methylSig[overlappingCpGs,]
      methylMix = methylMix[overlappingCpGs,]
      
      #If methylation mixture is supplied as Beta values, convert to Beta'
      if(betaPrime==FALSE){
        methylMix = 1 - methylMix
      }
      
      #Set up parallel processing if required
      ######################################################
      if(doPar==TRUE){
        #auto detect number of available cores
        if(numCores == "auto"){
          cores=parallel::detectCores()
          #set the number of cores for processing to the number of available cores minus 1 or 1 (if only 1 available core)
          cores = max(1,cores[1]-1)
          #setup and start parallel processing cluster
          cl <- snow::makeCluster(cores)
          doSNOW::registerDoSNOW(cl)
        } else{
          #if a number of cores for parallel processing is specified, use this number of cores
          if(is.numeric(numCores)){
            cores = numCores
            #setup and start parallel processing cluster
            cl <- snow::makeCluster(cores)
            doSNOW::registerDoSNOW(cl)
          }
        }
      }
      #if we are not using parallel processing, just use one core
      if(doPar==FALSE){
        cores = 1
        cl <- snow::makeCluster(cores)
        doSNOW::registerDoSNOW(cl)
      }
      #set up a progress bar
      pb <- txtProgressBar(max = ncol(methylMix), style = 3)
      progress <- function(n) setTxtProgressBar(pb, n)
      opts <- list(progress = progress)
      ######################################################

      ltsModel = foreach::foreach(i=1:ncol(methylMix), .combine = 'rbind', .options.snow = opts, .packages = c("robustbase","Metrics")) %dopar% {
        #the actual model
        regressionFormula = as.formula(paste0("methylMix[,i] ~ ",paste(colnames(methylSig),sep="",collapse=" + ")))
        deconvoluteSample <- robustbase::ltsReg(regressionFormula, data = methylSig, alpha = alpha)
  
        #get the optimal cpgs that are used
        bestCpGs = deconvoluteSample$best
        #get the coefficients (the cell type percentages)
        deconvoluteSample <- deconvoluteSample$coefficients[2:length(deconvoluteSample$coefficients)]
        #change any negative values to 0
        deconvoluteSample[which(deconvoluteSample<0)]<-0
        #if all coefficients are zero, set them all to the same value
        if(sum(deconvoluteSample)==0){
          deconvoluteSample[1:length(deconvoluteSample)] = rep((1/length(deconvoluteSample)),length(deconvoluteSample))
        }
        deconvoluteSample <- deconvoluteSample/sum(deconvoluteSample)
        
        #metrics for deconvolution accuracy
        mHat = deconvoluteSample%*%t(data.matrix(methylSig))
        mHat2 = mHat[bestCpGs]
        pearson1 = cor(methylMix[bestCpGs,i],as.vector(mHat2))
        rmse1 <- Metrics::rmse(methylMix[bestCpGs,i],mHat2)
        pearson2 = cor(methylMix[,i],as.vector(mHat))
        rmse2 <- Metrics::rmse(methylMix[,i],mHat)
  
        #return each sample deconvolution
        deconvoluteOne = data.frame(matrix(c(rmse1,pearson1,rmse2,pearson2,deconvoluteSample),nrow = 1))
        deconvoluteOne
      }
  
      #add row and column names
      rownames(ltsModel) <- colnames(methylMix)
      colnames(ltsModel) <- c("RMSE1","R1","RMSE2","R2",colnames(methylSig))
      
      #See if we should predict absolute fractions
      if(absolute == TRUE){
        #Predict sample purity and calculate absolute fractions
        ignoreMetrics = which(colnames(ltsModel) %in% c("RMSE1","R1","RMSE2","R2"))
        # if(is.character(purityModel)){
        #   if(purityModel == "default"){
        #     data("RFmodel", package="MethylResolver")
        #     rfModel = RFmodel
        #   }
        # } else{
        if(class(purityModel)[1] == "randomForest.formula"){
          rfModel = purityModel
        }
        else{
          cat("Provided purity model is not correct. Please provide a random forest model trained to
              predict purity...")
        }
        # }
        purityPrediction = predict(rfModel,ltsModel)
        absoluteFractions = ltsModel[,-ignoreMetrics]*(1-purityPrediction)
        colnames(absoluteFractions) = paste0("abs_",colnames(absoluteFractions))
        absoluteFractions$Purity = purityPrediction
        ltsModel = cbind(ltsModel,absoluteFractions)

      }
      
      #write to file
      write.table(ltsModel,file=paste0(outputPath,outputName,".txt"),quote = F, sep="\t")
      
      cat("\nCompleted LTS Deconvolution For This Mixture...\n")
      #shut down parallel processing
      close(pb)
      snow::stopCluster(cl)
    }
  }
}
