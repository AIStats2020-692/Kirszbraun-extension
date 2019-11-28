function PlotArm(X,color)

%for i=1:length(X)
    
    plot(X(:,1),X(:,2),'-o','MarkerSize',10,'MarkerFaceColor',color,'color',color)
    hold on;
    plot(X(:,1),X(:,2),'-','LineWidth',3,'color',color)
    
    hold on;
    
    hold on;
quiver3(0,0,0,0.3,0,0,'color',[0 0 0],'LineWidth',2);
hold on;
quiver3(0,0,0,0,0.3,0,'color',[0 0 0],'LineWidth',2);
% hold on;
% quiver3(0,'color',[0 0 1],'LineWidth',2);
% hold on;
    
%end