require(foreign)
require(plm)
require(lmtest)
require(data.table)

FM_Data = fread('FM-Data.csv')
basic_xs = c("mvel1","mom1m","mom12m","beta","LogBM")
sim_xs = c("MDA","RiskFactors","Disclosures","LegalProceedings","Combined")

for (sim_x in sim_xs){
  formula1 = as.formula(paste('RET', 
                              paste(c(sim_x,basic_xs), collapse = " + "), 
                              sep = " ~ "))
  formula2 = as.formula(paste('RET', sim_x,sep = " ~ "))
  
  fpmg1 = pmg(formula1, FM_Data, index=c("DATE","permno")) 
  res_test1 = coeftest(fpmg1)
  capture.output(res_test1, file=paste0(sim_x,".txt"))
  #fpmg2 = pmg(formula2, FM_Data, index=c("DATE","permno")) 
  #res_test2 = coeftest(fpmg2)
  #fwrite(as.data.table(res_test),'MDA-test.csv')
}


