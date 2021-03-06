#functions for drawing pictures
#画出每个航次的轨迹
plotSegs <- function(l) {
  for (i in (1:nrow(l[,.N,tripid]))) {
    trip = l[tripid == i]
    dev.new()
    plot(trip$lon1,trip$lat1)
  }
}

plotZero<-function(){
  
  g=fread('zerogrids.csv')
  p=getMap(g,7)
  p=p+geom_point(data = g,aes(x=lon,y=lat))
  p
  
}
plotGrid<-function(egrid,scale=100){
  dev.new()
  #p=getMap(temp3,6)
#   centerX=0.5*(max(temp3$lon)+min(temp3$lon))
#   centerY=0.5*(max(temp3$lat)+min(temp3$lat))
  #p<-ggmap(get_map(location=c(centerX,centerY),zoom=6,source='google',maptype = 'roadmap'))
  p=ggplot()
  p=p+geom_rect(data=egrid,aes(xmin=g.lon,xmax=g.lon+1/scale,ymin=g.lat,ymax=g.lat+1/scale,fill=log(CO2)))
  p=p+scale_fill_gradient('log(CO2） \n (吨）',low='green',high='red')
  p=p+labs(x="经度",y="纬度")
  #+theme(legend.position=c(0.1,0.5))
    
  p
  
}


readClarkson <- function() {
  
  filenames = list.files('data/containerFromClarkson/')
  containers = data.table(
    Type = 'e',Name = '',Size = 0,Unit = '',Dwt = 0,GT = 0,Flag = '',Built =
      0,Month = 0,Builder = '', OwnerGroup = ''
  )[Size < 0,]
  
  for (filename in filenames) {
    dt = read.csv(paste('data/containerFromClarkson/',filename,sep = ''))
    containers = rbind(containers,dt)
    
    
  }
  
  return(containers)
  
}


getChuanXunAIS<-function(filedir){
  
  filedir='D://share/AIS/AIS_chuanxun_201409/csvdata/'
  filepaths=list.files(filedir,full.names =TRUE)
  dt=data.table(mmsi=0,time=0,status=0,sog=0,lon=0,lat=0)[mmsi<0]
  for (filepath in filepaths){
    temp=fread('D://share/AIS/AIS_chuanxun_201409/csvdata/ships_20140901.csv')
    temp=temp[,list(mmsi=unique_ID,time=acquisition_time,status,lon=longitude,lat=latitude,sog=round(speed/100))]
  }
  dt=rbind(bt,temp)
  
}





