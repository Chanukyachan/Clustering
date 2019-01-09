function loadlatency=kmedianalmost(mex,mey)
loadlatency=zeros(1,10);
k=1;
newx=mex;
newy=mey;
for me=1:10

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
for c=1:k
    i=1;
    z(c)=round(p*(rand(1,1)));
    while i~=k
        t(c)=eq(d(i),z(c));
        i=i+1;
        if t(c)==1
            i=k;
        end
    end
    if t(c)==0
        px(c)=x(z(c));
        py(c)=y(z(c));
        d(c)=z(c);
    end
end
q=zeros(k,p);
%repetition of entire program for calibiration
cenx=zeros(1,k);ceny=zeros(1,k);em=0;latency=zeros(1,k);%rtt=zeros(1,k);
for z=1:iteration
    if em>0
       px=cenx;
       py=ceny;
    end
    em=em+1;
    for i=1:k
        for j=1:p
            q(i,j)=abs(py(i)-y(j))+abs(px(i)-x(j));
        end
    end
    value=1;
%if z==iteration
 %  hold on;
%end
while value~=(k+1)
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
        for mm=1:p
            disch(mm)=abs(checkv2-y(mm))+abs(checkv1-x(mm));
        end
        
        [minmval,minmloc]=min(disch);
        
        cenx(value)=x(minmloc);
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