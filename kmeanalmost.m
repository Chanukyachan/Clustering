function loadlatency=kmeanalmost(mex,mey)
loadlatency=zeros(1,10);
k=1;
newx=mex;
newy=mey;
for me=1:10 %for loop for increasing k values

p=1000; %no. of points
iteration=100; %for efficiency
x=newx;
y=newy;
z=[];
px=[];count=0;
py=[];
t=zeros(1,k);
%no. of fog nodes
d=zeros(1,k);
for c=1:k %for loop for finding k random points
    i=1;
    z(c)=round(p*(rand(1,1)));
    while i~=k %to get different k points
        t(c)=eq(d(i),z(c));
        i=i+1;
        if t(c)==1  %if any point is repeated then exits the loop
            i=k;
        end
    end
    if t(c)==0 %if there is no repetition then those random points are assigned
        px(c)=x(z(c));
        py(c)=y(z(c));
        d(c)=z(c);
    end
end
q=zeros(k,p);
%repetition of entire program for calibiration
cenx=zeros(1,k);ceny=zeros(1,k);em=0;latency=zeros(1,k);%rtt=zeros(1,k);
for z=1:iteration
    if em>0 %during 1st iteration we dont have any cen so skip it=1
       px=cenx;
       py=ceny;
    end
    em=em+1;
    for i=1:k %finding distance from nodes to points
        for j=1:p
            q(i,j)=sqrt(((py(i)-y(j)).^2)+((px(i)-x(j)).^2));
        end
    end
    value=1;
%if z==iteration
 %  hold on;
%end
while value~=(k+1) %clustering is done in this loop
check=0;sumx=0;sumy=0;summ=0;
for i=1:p
    [minq,location]=min(q(:,i));
    if(value==location)
        late=latency1(minq);
        summ=summ+late;
        %if z==iteration
        %L=['bs','g*','kO','ms','r*','bO','gO','k*','gs','rO'];
        %plot(x(i),y(i),L(value));
        %end
        sumx=sumx+x(i);
        sumy=sumy+y(i);
        check=check+1;
    end
    if(i==p)
        checkv1=round((sumx/check));
        checkv2=round((sumy/check));
        disch=zeros(1,p);
        for mm=1:p %finding the nearest point to the centroid using this loop
            disch(mm)=sqrt(((checkv2-y(mm)).^2)+((checkv1-x(mm)).^2));
        end
        
        [minmval,minmloc]=min(disch);
        
        cenx(value)=x(minmloc); %nearest point to centroid is assigned 
        ceny(value)=y(minmloc);
        latency(value)=summ;
        %rtt(value)=(2*latency(value))+processingDelay;
        value=value+1;
    end
end
end
  count=count+1;
%if z==iteration
 %  hold off;
%end
end

loadlatency(me)=addup(latency);
k=k+1;
end %for loop

end