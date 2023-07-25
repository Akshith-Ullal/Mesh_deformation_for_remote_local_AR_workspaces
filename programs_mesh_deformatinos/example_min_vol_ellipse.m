%P = rand(2,100);

P=Vt';
scatter(P(1,:),P(2,:));hold on;

 % for calculating minvol ellipse efficiently
 K = convhulln(P');  
 K = unique(K(:));  
 Q = P(:,K);
 [A, c] = MinVolEllipse(Q, .01)

Ellipse_plot(A, c);