library(sp)
data<-read.csv("G:/seat.csv",sep = ',',header =TRUE)
attach(data)
data.uid=data[,'uid']
data.gpa=data[,'gpa.all']
data.seat=data[,'X4月11日']
newdata=data.frame(data.uid,data.gpa,data.seat)

gpa2=c()
seat2=c()
a=1
for (i in 1:nrow(newdata)) {
  if(is.na(newdata[i,3])==FALSE&&newdata[i,2]>=3){
    gpa2[a]=newdata[i,2]
    seat2[a]=newdata[i,3]
    a=a+1
  }
  else{
    next()
  }
}
newdata2=data.frame(gpa2,seat2)


attr <- expand.grid(xc = 1:16, yc = 1:2)
attr2 <- expand.grid(xc = 2:15, yc = 3:5)
c1<- rbind(attr,attr2)
d<- data.frame(c1,seat1=74:1)
#total=merge(d,newdata2,by.x="seat1",by.y="seat2")#鍐呰繛鎺?
total=merge(d,newdata2,by.x="seat1",by.y="seat2",all.x=TRUE)
quad<-total#鏍锋柟鏁版嵁


coordinates(total) <- c("xc", "yc")
gridded(total) <-TRUE  
col1 <- colorRampPalette(c("red","green"))
spplot(total, "gpa2", key.space = "left",colorkey =TRUE, col.regions = col1(4))


seat3=c()
qx=c()
qy=c()
gpa3=c()
b=1
for (i in 1:nrow(quad)) {
  if(is.na(quad[i,4])==FALSE){
    seat3[b]=quad[i,1]
    qx[b]=quad[i,2]
    qy[b]=quad[i,3]
    gpa3[b]=quad[i,4]
    b=b+1
  }
  else{
    next()
  }
}
newdata3=data.frame(seat3,qx,qy,gpa3)#11涓ソ瀛︾敓

count=c(0,0,0,0,0,0)
for (i in 1:nrow(newdata3) ){
  if(newdata3[i,2]>0&&newdata3[i,2]<7&&newdata3[i,3]>0&&newdata3[i,3]<3){
    count[1]=count[1]+1
  }
  
  if(newdata3[i,2]>6&&newdata3[i,2]<11&&newdata3[i,3]>0&&newdata3[i,3]<3){
    count[2]=count[2]+1
  }
  
  if(newdata3[i,2]>10&&newdata3[i,2]<17&&newdata3[i,3]>0&&newdata3[i,3]<3){
    count[3]=count[3]+1
  }
  
  if(newdata3[i,2]>0&&newdata3[i,2]<7&&newdata3[i,3]>2&&newdata3[i,3]<6){
    count[4]=count[4]+1
  }
  
  if(newdata3[i,2]>6&&newdata3[i,2]<11&&newdata3[i,3]>2&&newdata3[i,3]<6){
    count[5]=count[5]+1
  }
  
  if(newdata3[i,2]>10&&newdata3[i,2]<17&&newdata3[i,3]>2&&newdata3[i,3]<6){
    count[6]=count[6]+1
  }
}
group=c('第一组','第二组','第三组','第四组','第五组','第六组')
cnb<-data.frame(group,count)



meanvalue<-1/6*sum(count)
sum1=0
for(i in 1:length(count)){
  sum1=sum1+(count[i]-meanvalue)^2
}
variance=1/5*sum1
result=variance/meanvalue
if(result<0.5){
  print(result)
  print("均匀分布")
}
if(result>0.5&&result<1.5){
  print(result)
  print("随机分布")
}
if(result>1.5){
  print(result)
  print("聚集分布")
}
detach(data)



