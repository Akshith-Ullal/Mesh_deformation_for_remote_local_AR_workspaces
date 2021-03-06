
% For circular outer boundary
% th = linspace(0,2*pi,100);
% th = th(1:end-1);
% V = [cos(th)',sin(th)'];
% disp(size(V));

% For square outer boundary 
thsquare = linspace(0,2,25);
zerosth = zeros(size(thsquare));
onesth = 2*ones(size(thsquare));
V00_01 = [zerosth',thsquare'];
V00_10 = [thsquare',zerosth'];
V10_11 = [onesth',thsquare'];
V01_11 = [thsquare',onesth'];
V=[V00_01;V00_10;V10_11;V01_11];
V=V-1;

%centering Vt
%Vt=0.4*V;
Vtcenter=Vt-0.5;
%for circle
%Eorg = [(1:size(V,1))',[(2:size(V,1))';1]];
%for square or rectangle 
Eorg = [(1:size(V,1)-1)',[(2:size(V,1))']];
Et = [(1:size(Vtcenter,1))',[(2:size(Vt,1))';1]];
%E = [Eorg;Eorg+size(V,1)];
Et = [Eorg;Et+size(V,1)];
%V = [V;0.4*V];
Vtt= [V;1.8*Vtcenter];
%Vtt= [V;0.4*V];
% disp(size(V))

%matrixsize = size(V,1);
%E=zeros(matrixsize,2);
% for r=1:matrixsize
%        E(r,1) = r;
%        if r==matrixsize
%         E(r,2) = 1;
%        else
%         E(r,2) = r+1;
%        end
% end
[TV,TF,TVM,TEM] = triangulate(Vtt,Et,'Flags','-q20','Holes',[0,0]);
tsurf(TF,TV);
axis equal;
% E=sqrt((TV(:,1) .^ 2 + (TV(:,2) .^ 2)));
% % if E(:,1) > 0.4
% %     E(:,1) = 0
% % else
% %     E(:,1) = 1
% % end
% index=find(E==0.4);
% writeOBJ('C:/gptoolbox/programs_mesh_deformatinos/example_meshes/circular_mesh_triangulate.obj', TV,TF);