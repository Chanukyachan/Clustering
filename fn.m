x=round(1000*rand(1,1000));
y=round(1000*rand(1,1000));
k=1:10;

kmeanvalue = kmeanalmost(x,y);
kmedianvalue = kmedianalmost(x,y);
kcentervalue = kcenter(x,y);                                                     
gavalue = ga(x,y);
psovalue = pso(x,y);


hold on;
plot(k,kmeanvalue);
plot(k,kmedianvalue);
plot(k,kcentervalue);
plot(k,gavalue);
plot(k,psovalue);

legend('kmean','kmedian','kcenter','ga','pso');
title('Latency vs k graph vs ga vs pso');
xlabel('------->FogNodes');
ylabel('------->Latency');
hold off;