function A = cross_product_matrix(p1,p2)

x1=p1(1,1);
y1=p1(2,1);

x2=p2(1,1);
y2=p2(2,1);

r1=[x1 y1 1 0 0 0 -x1*x2 -y1*x2 -x2];
r2=[0 0 0 x1 y1 1 -x1*y2 -y1*y2 -y2];

A=[r1;r2];

end

