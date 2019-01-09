
function [cc] = PlotSolution(X,sol)

    % Cluster Centers
    m = sol.Position;
    k = size(m,1);
    sum = 0;
    cnt = 0;
    
    % Cluster Indices
    ind = sol.Out.ind;
    
    for i=1:size(m,1)
        
        for ii=1:size(X,1)
            
            if ind(ii)==i
                d = sqrt(((X(ii,1)-m(i,1)).^2)+((X(ii,2)-m(i,2)).^2));
                pick = latency1(d);
                sum = sum + pick;
                cnt = cnt+1;
            end
        end
        
    end
    
    cc = sum;
    %Colors = hsv(k);
    
    %for j=1:k
     %   Xj = X(ind==j,:);
      %  plot(Xj(:,1),Xj(:,2),'x','LineWidth',1,'Color',Colors(j,:));
       % hold on;
    %end
    
    %plot(m(:,1),m(:,2),'ok','LineWidth',2,'MarkerSize',12);
    
    %hold off;
    %grid on;
    
end