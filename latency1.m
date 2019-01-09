function [latency] = latency1(d)

packetSize=(1526);%bytes
bitRate=(100);%Mbit/sec
distanceWindow=1.5;%kms
propagationSpeed=(20000);%mt/sec
processingDelay=.025;%millisec

d = d*distanceWindow;

transmissionTime=(packetSize/(bitRate*(10^6)));

propogationTime =((d)/propagationSpeed);
latency=propogationTime+transmissionTime;
       
end
