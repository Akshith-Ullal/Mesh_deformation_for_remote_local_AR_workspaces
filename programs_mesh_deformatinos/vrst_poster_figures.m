
%make sure to geerate the deformed meshes first
innerobstaclelimit = 585;
Vpathlimit = 277;
% Vector to add to get Vpathoriginal to reach the obstacle in the center
Correct_vect =TVs(170,:)' - Vpathoriginal(Vpathlimit,:)';
Equ_Vpath = Vpathoriginal(1:Vpathlimit,:)'+Correct_vect;
P = Equ_Vpath';

%source room config
figure()
plot(TVs(1:100,1),TVs(1:100,2),'LineWidth',4);hold on;
plot(TVs(101:innerobstaclelimit,1),TVs(101:innerobstaclelimit,2),'LineWidth',4,'color','#26A500');hold on;
plot(P(:,1),P(:,2),'LineWidth',4,'color','red');hold off;
xlim([-1.5 1.5]);
ylim([-1 1]);
set(gca,'FontSize',40);
set(gcf,'color','w');
text(P(1,1),P(1,2),"A",'Color','black','FontSize',40);
text(P(size(P,1),1),P(size(P,1),2),"B",'Color','black','FontSize',40);
%axis equal;




% target room config 
figure()
plot(TVSmod(1:100,1),TVSmod(1:100,2),'LineWidth',4);hold on;
plot(TVSmod(101:innerobstaclelimit,1),TVSmod(101:innerobstaclelimit,2),'LineWidth',4,'color','#26A500');hold on;
plot(P(:,1),P(:,2),'LineWidth',4,'color','red');hold off;
xlim([-1.5 1.5]);
ylim([-1 1]);
text(P(1,1),P(1,2),"A'",'Color','black','FontSize',40);
text(P(size(P,1),1),P(size(P,1),2),"B'",'Color','black','FontSize',40);
set(gca,'FontSize',40);
set(gcf,'color','w');
%axis equal;