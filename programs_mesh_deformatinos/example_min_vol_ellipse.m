%P = rand(2,100);
[TVs_read,TFs_read] = readOBJ('D:/GitHub/Mesh_deformation_for_remote_local_AR_workspaces/programs_mesh_deformatinos/example_meshes/Vsource_mesh_ieeevrposter_1.obj');
TVs_read = [TVs_read(:,1),TVs_read(:,2)];
[TVst_read,TFst_read] = readOBJ('D:/GitHub/Mesh_deformation_for_remote_local_AR_workspaces/programs_mesh_deformatinos/example_meshes/Vsource_to_target_deformed_mesh_ieeevrposter_1.obj');
TVst_read = [TVst_read(:,1),TVst_read(:,2)];
% for the ieeevr poster source and target mesh the inner obstacle is from
% 101 to 3700 datapoints
vobs1 = [TVs_read(101:3700,1),TVs_read(101:3700,2)];
vobs2 = [TVst_read(101:3700,1),TVst_read(101:3700,2)];
Vt = vobs2;
%Vt = [vobs1;vobs2];
P=Vt';
scatter(P(1,:),P(2,:));hold on;

 % for calculating minvol ellipse efficiently
 K = convhulln(P');  
 K = unique(K(:));  
 Q = P(:,K);
 [A, c] = MinVolEllipse(Q, .01)

%Ellipse_plot(A, c);

%plot the ellipse
C=c;
[U D V] = svd(A);
 a = 1/sqrt(D(1,1));
    b = 1/sqrt(D(2,2));

    theta = [0:1/N:2*pi+1/N];

    % Parametric equation of the ellipse
    %----------------------------------------
    state(1,:) = a*cos(theta); 
    state(2,:) = b*sin(theta);

    % Coordinate transform 
    %----------------------------------------
    X = V * state;
    X(1,:) = X(1,:) + C(1);
    X(2,:) = X(2,:) + C(2);


    plot(X(1,:),X(2,:));
    hold on;
    plot(C(1),C(2),'r*');
    axis equal, grid