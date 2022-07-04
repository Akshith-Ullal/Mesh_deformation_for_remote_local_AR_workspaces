function [correspondingpoint,minindex] = non_rigid_cpd_registration(Vsource,Vtarget)
sourcezero = zeros(size(Vsource,1),1);
sourcematrix = [Vsource, sourcezero];
targetzero = zeros(size(Vtarget,1),1);
targetmatrix = [Vtarget, targetzero];
ptClouds = pointCloud(sourcematrix);
ptCloudt = pointCloud(targetmatrix);

% figure
% sz = 25;
% scatter(ptClouds.Location(:,1),ptClouds.Location(:,2),sz,'filled');hold on;
% scatter(ptCloudt.Location(:,1),ptCloudt.Location(:,2),sz,'filled');hold off;
% % 
% figure
% pcshowpair(ptClouds,ptCloudt,'MarkerSize',50)
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% title('Point clouds before registration')
% legend({'Moving point cloud','Fixed point cloud'},'TextColor','w')
% legend('Location','southoutside')


% tformicp = pcregistericp(ptClouds,ptCloudt)
% movingRegicp = pctransform(ptClouds,tformicp);
%tform = pcregistercpd(movingRegicp,ptCloudt);
tform = pcregistercpd(ptClouds,ptCloudt);
movingReg = pctransform(ptClouds,tform);
%movingReg = pctransform(movingRegicp,tform);
ptCloudtarray = ptCloudt.Location;
movingRegarray = movingReg.Location;
% will sort to the nearest points movinReg to point cloud target
parfor i = 1:size(movingRegarray,1)
tempsort = repmat(movingRegarray(i,:),size(ptCloudtarray,1))
tempx = (tempsort(:,1) - ptCloudtarray(:,1)).^2;
tempy = (tempsort(:,2) - ptCloudtarray(:,2)).^2;
temp = sqrt(tempx+tempy);
[minval(i), minindex(i)] = min(temp);
correspondingpoint(i,:)= ptCloudtarray(minindex(i),:);
end
% figure
% sz = 25;
% scatter(ptCloudt.Location(:,1),ptCloudt.Location(:,2),sz,'filled');hold on;
% scatter(movingReg.Location(:,1),movingReg.Location(:,2),sz,'filled');hold off;
% % 
% figure
% pcshowpair(movingReg,ptCloudt,'MarkerSize',50)
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% title('Point clouds after registration')
% legend({'Moving point cloud','Fixed point cloud'},'TextColor','w')
% legend('Location','southoutside')

% figure
% sz = 25;
% scatter(ptClouds.Location(:,1),ptClouds.Location(:,2),sz,'filled');hold on;
% scatter(correspondingpoint(:,1),correspondingpoint(:,2),sz,'filled');hold on;
% scatter(ptCloudt.Location(:,1),ptCloudt.Location(:,2),sz,'filled');hold off;
end
