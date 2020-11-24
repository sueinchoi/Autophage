#START OF AUTO-GENERATED PREAMBLE, WILL BE OVERWRITTEN WHEN THIS FILE IS USED AS A TEMPLATE
#Created 2020-11-24 at 16:31

rplots.level <- 1
xpose.runno <- '002'
toolname <- 'execute'
pdf.filename <- paste0('PsN_',toolname,'_plots.pdf')
pdf.title <- 'execute diagnostic plots run 002'
working.directory<-'C:\\Users\\admin\\Documents\\GitHub\\Autophage\\Modeling\\Monkey\\CTL\\modelfit_dir4\\'
model.directory<-'C:\\Users\\admin\\Documents\\GitHub\\Autophage\\Modeling\\Monkey\\CTL\\'
results.directory <- 'C:\\Users\\admin\\Documents\\GitHub\\Autophage\\Modeling\\Monkey\\CTL\\'
model.filename<-'dual_2_11.mod'
subset.variable<-NULL
mod.suffix <- '.mod'
mod.prefix <- 'dual_'
tab.suffix <- ''
rscripts.directory <- 'C:/STRAWB~1/perl/site/lib/PsN_4_9_0/R-scripts'
raw.results.file <- 'raw_results_dual_2_11.csv'
theta.labels <- c('THETA1','THETA2','CL(3) 2.16 L/h/kg','V2(4) 3.34 L/kg','V3(5) 0.651 L/kg','Q (6) 0.12 L/h/kg','KA(7) 0.299 /h','FF(8) 0.0201','FA(9) 0.623','D2(10)   7.92','ALAG2(11) 4.00')
theta.fixed <- c(TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE)
omega.labels <- c('CL(1)','V2(2)','V3(3)','Q (4)','KA(5)','FF(6)','FA(7)','D2(8)','ALAG2(9)')
omega.fixed <- c(TRUE,FALSE,TRUE,TRUE,TRUE,FALSE,TRUE,TRUE,TRUE)
sigma.labels <- c('SIGMA(1,1)')
sigma.fixed <- c(TRUE)
n.eta <- 9
n.eps <- 1

res.table <- 'patab002'

setwd(working.directory)

############################################################################
#END OF AUTO-GENERATED PREAMBLE
#WHEN THIS FILE IS USED AS A TEMPLATE THIS LINE MUST LOOK EXACTLY LIKE THIS


pdf(file=pdf.filename,width=10,height=7)
# get libPaths
library(PsNR)
library(magrittr)
library(methods)
library(xpose4)

R_info(directory=working.directory,only_libPaths=T)
#add R_info to the meta file
R_info(directory=working.directory)
xpdb <- xpose4::xpose.data(xpose.runno, directory=results.directory, tab.suffix=tab.suffix, mod.prefix=mod.prefix, mod.suffix=mod.suffix)

#uncomment below to change the idv from TIME to something else such as TAD.
#Other xpose preferences could also be changed
#xpdb@Prefs@Xvardef$idv="TAD"
xpose4::runsum(xpdb, dir=results.directory,
         modfile=paste(model.directory, model.filename, sep=""),
         listfile=paste(results.directory, sub(mod.suffix, ".lst", model.filename), sep=""))
if (is.null(subset.variable)){
    print(xpose4::basic.gof(xpdb))
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::basic.gof(xpdb,by=subset.variable,max.plots.per.page=1))
}
if (is.null(subset.variable)){
    print(xpose4::ranpar.hist(xpdb))
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::ranpar.hist(xpdb,by=subset.variable,scales="free",max.plots.per.page=1))
}
if (is.null(subset.variable)){
    print(xpose4::ranpar.qq(xpdb))
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::ranpar.qq(xpdb,by=subset.variable,max.plots.per.page=1))
}
if (is.null(subset.variable)){
    print(xpose4::dv.preds.vs.idv(xpdb))
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::dv.preds.vs.idv(xpdb,by=subset.variable))
}
if (is.null(subset.variable)){
    print(xpose4::dv.vs.idv(xpdb))
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::dv.vs.idv(xpdb,by=subset.variable))
}
if (is.null(subset.variable)){
    print(xpose4::ipred.vs.idv(xpdb))
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::ipred.vs.idv(xpdb,by=subset.variable))
}
if (is.null(subset.variable)){
    print(xpose4::pred.vs.idv(xpdb))
    
}else{
    # change the subset variable from categorical to continuous or vice versa.
    # change.cat.cont(xpdb) <- c(subset.variable)
    print(xpose4::pred.vs.idv(xpdb,by=subset.variable))
}
rplots.gr.1 <- FALSE
if (rplots.level > 1){
  rplots.gr.1 <- TRUE
  #individual plots of ten random IDs
  #find idcolumn
  idvar <- xpose4::xvardef("id",xpdb)
  ten.random.ids <- sort(sample(unique(xpdb@Data[,idvar]),10,replace=FALSE))
  subset.string <- paste0(idvar,'==',paste(ten.random.ids,collapse=paste0(' | ',idvar,'==')))

  if (is.null(subset.variable)){
    print(xpose4::ind.plots(xpdb,subset=subset.string))
  }else{
    for (flag in unique(xpdb@Data[,subset.variable])){
      print(xpose4::ind.plots(xpdb,layout=c(1,1),subset=paste0(subset.variable,'==',flag,' & (',subset.string,')')))
    }
  }
}  
if (rplots.level > 1){
  #check if files exist
  if (res.table != '') {
    file_1_exists <- file_existence_in_directory(directory=results.directory, file_name=paste0(mod.prefix, xpose.runno, ".phi"))
    file_2_exists <- file_existence_in_directory(directory=results.directory, file_name=res.table)
    
    if ((file_1_exists) && (file_2_exists)) {
      # calculate data
      list_out <- data.obj.obsi(obj.data.dir=paste0(results.directory, mod.prefix, xpose.runno, ".phi"),
                                obsi.data.dir=paste0(results.directory, res.table))
      have_needed_columns <- list_out$have_needed_columns
      if(have_needed_columns) {
        OBJ_data <- list_out$OBJ_data
        OBSi_vector <- list_out$OBSi_vector
        OBJ_vector <- list_out$OBJ_vecto
      
        # plot data
        plot.obj.obsi(OBJ_data,OBSi_vector,OBJ_vector)
      }
    }
  }
}
dev.off()

