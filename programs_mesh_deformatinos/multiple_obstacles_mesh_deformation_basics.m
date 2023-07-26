outsize = 4; 
%vobs1 = vobs1*2;
%vobs2 = vobs2*2 + 2;

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
        9,0
        9,9
        0,9;
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

    edgetestfirstcol =[1:size(nodetest, 1)];
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
    figure;
    patch('faces',tria(:,1:3),'vertices',vert, ...
        'facecolor','w', ...
        'edgecolor',[.2,.2,.2]) ;
    hold on; axis image off;
    patch('faces',edge(:,1:2),'vertices',node, ...
        'facecolor','w', ...
        'edgecolor',[.1,.1,.1], ...
        'linewidth',1.5) ;

    drawnow;

    set(figure(1),'units','normalized', ...
        'position',[.05,.50,.30,.35]) ;
    set(figure(2),'units','normalized', ...
        'position',[.35,.50,.30,.35]) ;
