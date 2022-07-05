[TVs_read,TFs_read] = readOBJ('C:/gptoolbox/programs_mesh_deformatinos/example_meshes/Vsource_mesh.obj');
TVs_read = [TVs_read(:,1),TVs_read(:,2)];
[TVst_read,TFst_read] = readOBJ('C:/gptoolbox/programs_mesh_deformatinos/example_meshes/Vsource_to_target_deformed_mesh.obj');
TVst_read = [TVst_read(:,1),TVst_read(:,2)];

% points to plot
P = [0.5 0.2;0.8 0.2];

% triangles inside which the points lie on the source mesh
figure
TRsource = triangulation(TFs_read,TVs_read);
triplot(TRsource);
hold on;
plot(P(:,1),P(:,2),'k*');
ylim([-1 1]);
xlim([-2 2]);
IDsource = pointLocation(TRsource,P);
triplot(TRsource.ConnectivityList(IDsource,:),TVs_read(:,1),TVs_read(:,2),'r');

%barycentric equivalent of the points on the source to target deformed mesh

Bsource = cartesianToBarycentric(TRsource,IDsource,P);

% triangles inside which the points lie on the source to target deformed mesh
figure
TRsourcetomesh = triangulation(TFst_read,TVst_read);
triplot(TRsourcetomesh);
hold on;
%Convert the source barycentric points back cartesian on the deformed mesh
Psourcetotarget = barycentricToCartesian(TRsourcetomesh,IDsource,Bsource)
plot(Psourcetotarget(:,1),Psourcetotarget(:,2),'k*');
ylim([-1 1]);
xlim([-2 2]);
%IDsourcetomesh = pointLocation(TRsourcetomesh,P);
triplot(TRsourcetomesh.ConnectivityList(IDsource,:),TVst_read(:,1),TVst_read(:,2),'r');


