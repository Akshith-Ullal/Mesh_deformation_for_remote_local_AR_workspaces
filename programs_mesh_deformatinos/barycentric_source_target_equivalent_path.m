[TVs_read,TFs_read] = readOBJ('D:/GitHub/Mesh_deformation_for_remote_local_AR_workspaces/programs_mesh_deformatinos/example_meshes/Vsource_mesh_ieeevrposter_1.obj');
TVs_read = [TVs_read(:,1),TVs_read(:,2)];
[TVst_read,TFst_read] = readOBJ('D:/GitHub/Mesh_deformation_for_remote_local_AR_workspaces/programs_mesh_deformatinos/example_meshes/Vsource_to_target_deformed_mesh_ieeevrposter_1.obj');
TVst_read = [TVst_read(:,1),TVst_read(:,2)];

% points to plot
%P = [0.5 0.2;0.8 0.2];
%P=Vpath;
%P = [Vpath;TVs_read(101:150,:)];
%P = TVs_read(101:170,:);

 Vpathlimit = 165; % This is the path length
 innerobstaclelimit = 2120; %till where the green line should be drawn
 Vpathoriginal = Vpath;
 %Vector to add to get Vpath to reach the obstacle in the center
 Correct_vect =TVs_read(320,:)' - Vpathoriginal(Vpathlimit,:)';
 Equ_Vpath = Vpathoriginal(1:Vpathlimit,:)'+Correct_vect;
 P = Equ_Vpath';
 % triangles inside which the points lie on the source mesh
figure
TRsource = triangulation(TFs_read,TVs_read);
triplot(TRsource);hold on;
%plot(TVs_read(1:100,1),TVs_read(1:100,2),'LineWidth',4,'color','#20CCEB');hold on;
plot(TVs_read(101:innerobstaclelimit,1),TVs_read(101:innerobstaclelimit,2),'LineWidth',4,'color','#26A500');hold on;
plot(P(:,1),P(:,2),'LineWidth',4,'color','red');
xlim([-1.2 0.7]);
ylim([-1 0.425]);
set(gca,'FontSize',40);
set(gcf,'color','w');
%text(P(1,1),P(1,2),"A",'Color','black','FontSize',40);
%text(P(size(P,1),1),P(size(P,1),2),"B",'Color','black','FontSize',40);
IDsource = pointLocation(TRsource,P);
%triplot(TRsource.ConnectivityList(IDsource,:),TVs_read(:,1),TVs_read(:,2),'r');

%barycentric equivalent of the points on the source to target deformed mesh

Bsource = cartesianToBarycentric(TRsource,IDsource,P);

% triangles inside which the points lie on the source to target deformed mesh
figure
TRsourcetomesh = triangulation(TFst_read,TVst_read);
triplot(TRsourcetomesh);hold on;
%plot(TVst_read(1:100,1),TVst_read(1:100,2),'LineWidth',4,'color','#20CCEB');hold on;
plot(TVst_read(101:innerobstaclelimit,1),TVst_read(101:innerobstaclelimit,2),'LineWidth',4,'color','#26A500');hold on;
%Convert the source barycentric points back cartesian on the deformed mesh
Psourcetotarget = barycentricToCartesian(TRsourcetomesh,IDsource,Bsource)
plot(Psourcetotarget(:,1),Psourcetotarget(:,2),'LineWidth',4,'color','red');
xlim([-1.2 0.7]);
ylim([-1 0.425]);
set(gca,'FontSize',40);
set(gcf,'color','w');
%text(Psourcetotarget(1,1),Psourcetotarget(1,2),"A'",'Color','black','FontSize',40);
%text(Psourcetotarget(size(P,1),1),Psourcetotarget(size(P,1),2),"B'",'Color','black','FontSize',40);
%IDsourcetomesh = pointLocation(TRsourcetomesh,P);
%triplot(TRsourcetomesh.ConnectivityList(IDsource,:),TVst_read(:,1),TVst_read(:,2),'r');


