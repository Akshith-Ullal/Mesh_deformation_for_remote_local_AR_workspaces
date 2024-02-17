
outsize = 4; 
%vobs1 = vobs1*2;
%vobs2 = vobs2*2 + 2;
max = 4;

outsize = 4; % number of mesh vertices on the outer boundary 
vobs1scale = 2;
vobs2scale = 2;
obstaclemovescale = false;
if(obstaclemovescale)
    posvobs1= [1,2]; % the x and y cordinates with which you want to shift obstacle 1;
    posvobs2= [1.5,2.5]; % the x and y cordinates with which you want to shift obstacle 2;
    %vobs1=  vobs1* vobs1scale;
    %vobs2=  vobs2* vobs2scale;
    vobs1 = [vobs1(:,1)+posvobs1(1,1),vobs1(:,2)+posvobs1(1,2)]
    vobs2 = [vobs2(:,1)+posvobs2(1,1),vobs2(:,2)+posvobs2(1,2)]
end
vobs=[vobs1;vobs2]; % mesh vertices of all interioir elements

% node = [                % list of xy "node" coordinates
%         0, 0                % outer square
%         9, 0
%         9, 9
%         0, 9
%         4.2,4.3             % inner obstacle co-ordinates
%         4, 4                
%         5, 4
%         5, 5
%         4, 5
%         5.4,5.5
%         6, 4
%         7, 4
%         7, 5
%         6, 5 ] ;

node = [
        0,0
        max,0
        max,max
        0,max;
        vobs1;vobs2]

    % edge = [                % list of "edges" between nodes
    %     1, 2                % outer square
    %     2, 3
    %     3, 4
    %     4, 1
    %     5, 6                % inner obstacle co-ordinates
    %     6, 7
    %     7, 8
    %     8, 9
    %     9, 5
    %     10, 11
    %     11, 12
    %     12, 13
    %     13, 14
    %     14, 10] ;

    edgetestfirstcol =[1:size(node, 1)];
    edgetestsecondcol = [2:outsize,1,outsize+2:size(vobs1,1)+outsize,outsize+1,outsize+size(vobs1,1)+2:size(vobs1,1)+outsize+size(vobs2,1),outsize+size(vobs1,1)+1];
    edge = [edgetestfirstcol',edgetestsecondcol'];
%------------------------------------------- call mesh-gen.
   [vert,etri, ...
    tria,tnum] = refine2(node,edge) ;


%------------------------------------------- draw tria-mesh
    figure;
    patch('faces',tria(:,1:3),'vertices',vert, ...
        'facecolor','w', ...
        'edgecolor',[.2,.2,.2]) ;
    hold on; axis image off;
    patch('faces',edge(:,1:2),'vertices',node, ...
        'facecolor','w', ...
        'edgecolor',[.1,.1,.1], ...
        'linewidth',1.5) ;

%------------------------------------------- call mesh-gen.
    hfun = +.5 ;            % uniform "target" edge-lengths

   [vert,etri, ...
    tria,tnum] = refine2(node,edge,[],[],hfun) ;

%------------------------------------------- draw tria-mesh
%     figure;
%     patch('faces',tria(:,1:3),'vertices',vert, ...
%         'facecolor','w', ...
%         'edgecolor',[.2,.2,.2]) ;
%     hold on; axis image off;
%     patch('faces',edge(:,1:2),'vertices',node, ...
%         'facecolor','w', ...
%         'edgecolor',[.1,.1,.1], ...
%         'linewidth',1.5) ;
% 
%     drawnow;
% 
%     set(figure(1),'units','normalized', ... 
%         'position',[.05,.50,.30,.35]) ;
%     set(figure(2),'units','normalized', ...
%         'position',[.35,.50,.30,.35]) ;

%perform mesh deformation
 
F=tria;
V=vert;
[rowmin,columnmin]= find(vert == 0); %finding all vertices at the boundary of the room
[rowmax,columnmax]= find(vert == max); %finidnig all vertices at the boundary of the room
rowzero = [rowmax;rowmin];
movevobs1 = [-1,0];
movevobs2 = [1,0];
vobs1col =5:5+size(vobs1,1);
vobs2co1 =5+size(vobs1,1)+1:5+size(vobs1,1)+1+size(vobs2,1);
handles = [rowzero;vobs1col';vobs2co1'];
d_handles = [zeros(size(rowzero,1), 2);repelem(movevobs1,[size(vobs1col',1)],[1]);repelem(movevobs2,[size(vobs2co1',1)],[1])];
% handles are the indices that you want to deform and d_handle specifies by
% how much you want to deform them. 
%TRsource = triangulation(F,V);
%triplot(TRsource);hold on;
tsurf(F,V)
hold on;
sct(V(handles,:),'filled','r');
qvr(V(handles,:),d_handles) 
axis equal

A = cotmatrix(V,F);
B = zeros(size(V,1),2);
d = min_quad_with_fixed(A,B,handles,d_handles);

figure()
tsurf(F,V+d)
axis equal

% % draw the min enclosing obstacles 
% P=vobs';
% P1=vobs1';
% P2=vobs2';
% % for calculating minvol ellipse efficiently
%  K = convhulln(P');  
%  K = unique(K(:));  
%  Q = P(:,K);
%  [A, c] = MinVolEllipse(Q, .01)
%  % first object vol
%  K1 = convhulln(P1');  
%  K1 = unique(K1(:));  
%  Q1 = P1(:,K1);
%  [A1, c1] = MinVolEllipse(Q1, .01)
%  % second obj vol
%  K2 = convhulln(P2');  
%  K2 = unique(K2(:));  
%  Q2 = P2(:,K2);
%  [A2, c2] = MinVolEllipse(Q2, .01)
%  figure()
%  scatter(P(1,:),P(2,:),"filled");hold on;
%  Ellipse_plot(A, c);
%  figure()
%  scatter(P1(1,:),P1(2,:),"filled");hold on;
%  Ellipse_plot(A1, c1);
%  %figure()
%  scatter(P2(1,:),P2(2,:),"filled");hold on;
%  Ellipse_plot(A2, c2);
% 
