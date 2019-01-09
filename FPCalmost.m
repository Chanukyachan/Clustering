%Intialization           %Farthest point clustering
n=1000;Ch=1;
Px=zeros(1,1000);
Py=zeros(1,1000);
Qx=zeros(1,1000);
Qy=zeros(1,1000);
tempx=zeros(1,1000);
tempy=zeros(1,1000);
tempn=n;
%for latency
processingDelay=0.25; %millisec

%Provoiding x and y coordinates and D value
Px=round(1000*rand(1,1000));
Py=round(1000*rand(1,1000));
InputD=2050;

%for intermediate calculations
tempx=Px;
tempy=Py;

%choosing a random point
p=round(1000*rand(1,1));

%store the randomly choosen point in the set 'Q'
Qx(Ch)=Px(p);
Qy(Ch)=Py(p);

%Now remove the point from the 'P' set
tempx(p)=[];
tempy(p)=[];
tempn=tempn-1;

%Defining dmax value
dmax=Inf;
D=InputD;

%checking condition dmax>D/2
while dmax>(D/2)
    %Reintializing distance everytime
    distance=zeros(1,tempn);
    for i=1:tempn
    distance(i)=sqrt((Qx(Ch) - tempx(i)).^2 + (Qy(Ch) - tempy(i)).^2);
        if i==tempn
           Ch=Ch+1;
        end
    end
    
    %Finding the farthest point to the randomly choosen point
    [maxVal,maxLoc]=max(distance);
    Qx(Ch)=tempx(maxLoc);
    Qy(Ch)=tempy(maxLoc);
    
    %Removing the point from the P set
    tempx(maxLoc)=[];
    tempy(maxLoc)=[];
    tempn=tempn-1;
    
    %assigning dmax value
    dmax=maxVal;
end
%Calculating distance
Virtualdistance=zeros(Ch,tempn);
for i=1:Ch
    for j=1:tempn
        Virtualdistance(i,j)=sqrt(((Qy(i)-tempy(j)).^2)+((Qx(i)-tempx(j)).^2));
    end
end
%for every q € Q
value=1;plt1=0;Cc=1;plt2=0;latency=zeros(1,Ch);rtt=zeros(1,Ch);
hold on;
for Nch=1:Ch
plot(Qx(Nch),Qy(Nch),'ks');
plt1=plt1+1;
end
while value~=(Ch+1)
    sum=0;
for i=1:tempn
    [minq,location]=min(Virtualdistance(:,i));
    if(value==location)
        late=latency1(minq);
        sum=sum+late;
        Co=['rO','bO','gO','mO','r*','b*','g*','m*','rs','bs','gs','ms'];
        plot(tempx(i),tempy(i),Co(Cc));
        plt2=plt2+1;
    end
    if i==tempn
        latency(value)=sum;
        rtt(value)=(2*latency(value))+processingDelay;
        value=value+1;
    end
end

Cc=Cc+1;
if Cc>12
    Cc=1;
end
end
hold off;

