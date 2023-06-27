
%addpath(genpath('C:/Users/ullala/Desktop/mesh_deformation'));
[V,F] = readOBJ('D:/GitHub/Mesh_deformation_for_remote_local_AR_workspaces/programs_mesh_deformatinos/example_meshes/circular_mesh_triangulate.obj');
%[V,F] = readOBJ('C:/gptoolbox/spot/spot_triangulated.obj');
E=sqrt((V(:,1) .^ 2 + (V(:,2) .^ 2)));
index0=find(E==0.4);
index1=find(E==1);
handles = [index0;index1];
v0=[0.0,0.5,0];
v1=[0.1,0,0];
d_handles0=repelem(v0,[size(index0,1)],[1]);
d_handles1=repelem(v1,[size(index1,1)],[1]);
d_handles =[d_handles0;d_handles1];
%handles = [25;235;114;154;168;59;18;234];
%d_handles = [0.5,0,0;0.5,0,0;0.5,0,0;-0.5,0,0;0.5,0,0;0.5,0,0;0.5,0,0;0.5,0,0];
% handles = [1837;2274;1144;1454;1685;569;178;2314];
% d_handles = [0.5,0,0;0.5,0,0;0.5,0,0;-0.5,0,0;0,0.5,0;0.5,0.5,0;0.5,0,0.5;0.5,0.5,0.5];

tsurf(F,V)
hold on;
sct(V(handles,:),'filled','r');
qvr(V(handles,:),d_handles) 
axis equal

A = cotmatrix(V,F);
B = zeros(size(V,1),3);
d = min_quad_with_fixed(A,B,handles,d_handles);

figure()
tsurf(F,V+d)
axis equal