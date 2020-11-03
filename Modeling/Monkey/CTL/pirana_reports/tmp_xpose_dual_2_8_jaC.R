#--- Initialize R / Xpose  ---
setwd('C:/Users/cnr/Documents/GitHub/Autophage/Modeling/Monkey/CTL')
library(xpose4)
new.runno <- 'dual_2_8' 
newdb <- xpose.data(new.runno)
newnam <- paste('xpdb', new.runno, sep = '')
assign(pos = 1, newnam, newdb)
assign(pos = 1, '.cur.db', newdb)
#-----------------------------


#--- Start Xpose commands list  ----------
pdf (file="C:/Users/cnr/Documents/GitHub/Autophage/Modeling/Monkey/CTL/pirana_reports/dual_2_8_xpose.VPC_01.pdf")
xpose.VPC(vpc.info="/vpc_results.csv", vpctab="/vpctab", PI.ci.area.smooth=TRUE)
dev.off()
