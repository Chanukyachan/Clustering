function loadlatency=kcenter(mex,mey)
k=1;
loadlatency=zeros(1,10);
newx=mex;
newy=mey;
for me=1:10 %for loop for increasing k values

    p = 1000; %no of points
    x = newx; %Value of x
    y = newy; %Value of y
    tempx=x;tempy=y;n=p;peak=p;
    P = round(p*rand(1,1)); %picking a random point
    Fx(1) = tempx(P);
    Fy(1) = tempy(P);
    tempx(P) = []; %removing that point
    tempy(P) = [];
    n=n-1;L=1;
    for j=1:(k-1) %finding fog nodes
        distance=zeros(1,n);
        for i=1:n
            distance(i) = sqrt(((Fx(L)-tempx(i)).^2)+((Fy(L)-tempy(i)).^2));
        end
        [maxVal,maxLoc]=max(distance);
        L=L+1;
        Fx(L)=tempx(maxLoc);
        Fy(L)=tempy(maxLoc);
        tempx(maxLoc)=[];
        tempy(maxLoc)=[];
        n=n-1;
    end
    q=zeros(k,p);
    for i=1:k %finding distance from nodes to points
        for j=1:n
            q(i,j)=sqrt(((Fx(i)-tempx(j)).^2)+(Fy(i)-tempy(j).^2));
        end
    end
    value=1;latency=zeros(1,k);
    while value~=(k+1) %clustering
        sum=0;
        for i=1:n
            [minq,location]=min(q(:,i));
            if value==location
                late=latency1(minq);
                sum=sum+late;
            end
            if i==n
                latency(value)=sum;
                value=value+1;
            end
        end
    end

loadlatency(me)=abs(addup(latency));
k=k+1;
end