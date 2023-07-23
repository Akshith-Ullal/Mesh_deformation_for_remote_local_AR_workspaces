th = linspace(0,2*pi,100);
th = th(1:end-1);
V = [cos(th)',sin(th)'];
E = [(1:size(V,1))',[(2:size(V,1))';1]];
E = [E;E+size(V,1)];
E = [E;E+size(V,1)];
V = [V;0.4.*V;0.2*V];
plot_edges(V,E,'-k','LineWidth',5)

[U,G] = triangle(V,E,[0,0],'Flags','-q20');
tsurf(G,U)