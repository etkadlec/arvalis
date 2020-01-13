### R softare to creat maps of tick abundances
### The datafile "data.txt" needs to contain geographic coordinates (x, y)
### and index of abundance of ticks (e.g. number of ticks per 1 h of flagging)
### Shapefiles of maps (borders, districts and rivers) are stored in D://maps

### Package which need to be installed and downloaded to creat
### scale and arrow for maps
library(prettymapr)

### Downloading the data
data = read.table("data.txt",header=T)

### Reading the GIS background from folder 
cr<-readOGR(dsn = "D://maps", layer = "crWGS84")    
toky<-readOGR(dsn = "D://maps", layer = "tokyWGS84")
okr<-readOGR(dsn = "D://Rwork/GIS/Czech/okresy-new", layer = "OkresyWGS84")
mesta=read.table("mesta.txt",header=T)

### Creating the plot
windows(10,7)  ##$ setting the size of a graphic window
par(mfrow=c(1,1),las=0,mar=c(0,0,0,0))

### Reordering the datafile to ensure that highest abundances
### are plotted first
data=data[order(data$index,decreasing=T),]

### Creating a variable to indicate the size of circles on maps
data$cex=0.5+0.018*data$index

### Figure
plot(okr,border="gray50",axes=F,xlab="",ylab="",xlim=c(12,19.5),
  ylim=c(48.1,51.3))#
polygon(mesta$xpraha,mesta$ypraha,density=25,angle=45)
polygon(mesta$xbrno,mesta$ybrno,density=25,angle=45)    
polygon(mesta$xostrava,mesta$yostrava,density=25,angle=45)    
polygon(mesta$xplzen,mesta$yplzen,density=25,angle=45)
plot(cr,add=T)
plot(toky,add=T,col="blue")
text(15,51.27,"Ixodes ricinus")
points(data$x,data$y,pch=21,bg="green1",cex=data$cex)

#### Creating the legend
legend(x=18.5,y=51.2,legend=c(1,80,160,300),pch=c(21,21,21,21), 
    pt.cex=c(0.5+0.018*1,0.5+0.018*80,0.5+0.018*160,0.5+0.018*300),
    pt.bg=c(rep("green1",4)), title="Index",bty="n",y.intersp=2,x.intersp=1.8)

### Adding arrow and scale to the map    
addnortharrow(scale=.6,padin = c(0.25, 0.7),pos="topleft")
addscalebar(htin=.04, pos="bottomleft",padin=c(1.4,.26))
