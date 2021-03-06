%for circular outer boundary
% th = linspace(0,2*pi,100);
% th = th(1:end-1);
% V = [cos(th)',sin(th)'];

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
Vscenter=Vsource-0.5;
%for circle
%Eorg = [(1:size(V,1))',[(2:size(V,1))';1]];
%for square or rectangle 
Eorg = [(1:size(V,1)-1)',[(2:size(V,1))']];
Ets = [(1:size(Vscenter,1))',[(2:size(Vscenter,1))';1]];
%E = [Eorg;Eorg+size(V,1)];
Ets = [Eorg;Ets+size(V,1)];
%V = [V;0.4*V];
Vts= [V;1.0*Vscenter];
% disp(size(V))

figure
[TVs,TFs,TVMs,TEMs] = triangulate(Vts,Ets,'Flags','-q20','Holes',[0,0]);
tsurf(TFs,TVs);
title('Source - Local workspace');
axis equal;

Vtcenter=Vtarget-0.5;
%for circle
%Eorg = [(1:size(V,1))',[(2:size(V,1))';1]];
%for square or rectangle 
Eorg = [(1:size(V,1)-1)',[(2:size(V,1))']];
Ett = [(1:size(Vtcenter,1))',[(2:size(Vtcenter,1))';1]];
%E = [Eorg;Eorg+size(V,1)];
Ett = [Eorg;Ett+size(V,1)];
%V = [V;0.4*V];
Vtt= [V;1.0*Vtcenter];
% disp(size(V))

figure
[TVt,TFt,TVMt,TEMt] = triangulate(Vtt,Ett,'Flags','-q20','Holes',[0,0]);
tsurf(TFt,TVt);
title('Target - Remote workspace');
axis equal;

TVsource = TVs(size(V,1)+1:size(TEMs,1),:);
TVtarget = TVt(size(V,1)+1:size(TEMt,1),:);

%[Vsourcetotarget,sourcetotargetindex] = non_rigid_cpd_registration(Vsource,Vtarget);
[Vsourcetotarget,sourcetotargetindex] = non_rigid_cpd_registration(TVsource,TVtarget);
sourcetotargetindex = sourcetotargetindex';

% parfor i = 1:size(TVs,1)
%     tempVfind = repmat(TVs(i,:),size(V,1));
%     tempVx = (tempVfind(:,1) - V(:,1)).^2;
%     tempVy = (tempVfind(:,2) - V(:,2)).^2;
%     tempV = sqrt(tempVx+tempVy);
% 
%     
%     if ~isempty(find(tempV == 0))
%         minindexV(i) = find(tempV == 0);
%     end
% 
%     
% 
% 
% end

% parfor i = 1:size(TVt,1)
% 
%     tempVsourcetotargetfind = repmat(TVt(i,:),size(Vsourcetotarget,1));
%     tempVsourcetotargetx = (tempVsourcetotargetfind(:,1) - Vsourcetotarget(:,1)).^2;
%     tempVsourcetotargety = (tempVsourcetotargetfind(:,2) - Vsourcetotarget(:,2)).^2;
%     tempVsourcetotarget = sqrt(tempVsourcetotargetx+tempVsourcetotargety);
% 
%     if ~isempty(find(tempVsourcetotarget == 0))
%         minindexVsourcetotarget(i) = find(tempVsourcetotarget == 0);
%     end
% 
% end    

figure
sz = 25;
%scatter(TVs(size(V,1)+1:size(TEMs,1),1),TVs(size(V,1)+1:size(TEMs,1),2),sz,'filled');hold on;
%scatter(TVt(size(V,1)+1:size(TEMt,1),1),TVt(size(V,1)+1:size(TEMt,1),2),sz,'filled');hold off;
%scatter(Vsource(:,1),Vsource(:,2),sz,'filled');hold on;
scatter(TVtarget(:,1),TVtarget(:,2),sz,'filled');hold on;
scatter(Vsourcetotarget(:,1),Vsourcetotarget(:,2),sz,'filled');hold off;



for i = 1:size(TVsource,1)

    d_handlesinner(i,1) = TVtarget(sourcetotargetindex(i,:),1) - TVsource(i,1);
    d_handlesinner(i,2) = TVtarget(sourcetotargetindex(i,:),2) - TVsource(i,2);

%     d_handlesinner(i,1) = TVsource(i,1) - Vsourcetotarget(i,1);
%     d_handlesinner(i,2) = TVsource(i,2) - Vsourcetotarget(i,2);
    d_handlesinner(i,3) = 0;

end    


%for circle
indexouter = [1:size(V,1)]';
%for rectangle
% indexouter00_01 = [1:size(V00_01,1)]';
% indexouter00_10 = [1:size(V00_10,1)]';
% indexouter01_11 = [1:size(V01_11,1)]';
% indexouter10_11 = [1:size(V10_11,1)]';
% indexouter = [indexouter00_01;indexouter00_10;indexouter01_11;indexouter10_11]
indexinner = [size(V,1)+1:size(TEMs,1)]';
%for circle
%handles = [indexinner;indexouter];
%for rectangle
handles = [indexinner;indexouter];
% v0=[0.3,0.2,0];
%For circle
%vouter=[0,0,0];
%For rectangle
vouter00_01=[-0.9,0,0];
vouter00_10=[0,0,0];
vouter01_11=[0.9,0,0];
vouter10_11=[0,0,0];
% d_handlesinner=repelem(v0,[size(indexinner,1)],[1]);
% %d_handlesinner=Vsourcetotarget;
%For circle
%d_handlesouter=repelem(vouter,[size(indexouter,1)],[1]);
%For rectangle
d_handlesouter00_01=repelem(vouter00_01,[size(V00_01,1)],[1]);
d_handlesouter00_10=repelem(vouter00_10,[size(V00_10,1)],[1]);
d_handlesouter01_11=repelem(vouter01_11,[size(V01_11,1)],[1]);
d_handlesouter10_11=repelem(vouter10_11,[size(V10_11,1)],[1]);
d_handlesouter= [d_handlesouter00_01;d_handlesouter00_10;d_handlesouter01_11;d_handlesouter10_11];
% % d_handles =[d_handles0;d_handles1];
%for circle
%d_handles =[d_handlesinner;d_handlesouter];
%for rectangle
d_handles =[d_handlesinner;d_handlesouter];
% % 
figure
tsurf(TFs,TVs)
hold on;
sct(TVs(handles,:),'filled','r');
qvr(TVs(handles,:),d_handles) 
title('Source - Local workspace with displacements to Remote workspace ');
axis equal

A = cotmatrix(TVs,TFs);
B = zeros(size(TVs,1),3);
d = min_quad_with_fixed(A,B,handles,d_handles);

figure()
tsurf(TFs,TVs+d(:,1:2))
title('Deformed source mesh to fit remote workspace obstacle shape');
axis equal