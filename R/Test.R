# methylMix = read.table("./data/TCGAexampleDataSmall.txt")
# methylSig = read.table("./data/MethylSortSignatureMatrix.txt")

# MethylResolver(methylMix = methylMix, methylSig = methylSig)
# 
# purityModel = readRDS("./data/TumorPurityRFModel.RDS")
# typeof(purityModel)
# class(purityModel)


# MethylResolver(methylMix = methylMix,absolute=FALSE)

# test = methylMix[,1:3]
# 
# MethylResolver(methylMix = methylMix)

# load(file = "./data/RFmodel.rda")
# RFmodel = rfModel
# save(RFmodel, file = "./data/RFmodel.rda", compress='xz')
# 
# 
# load(file = "./data/methylSig.rda")
# MethylSig = methylSig
# save(MethylSig, file = "./data/MethylSig.rda")
# 
# 
# load(file = "./data/methylMix.rda")
# MethylMix = methylMix
# save(MethylMix, file = "./data/MethylMix.rda")

# save(test, file="mypackage/data/test.rda", compress='xz')