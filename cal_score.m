function sc = cal_score(P1,P2,h)
n = size(P1,2) ;
epsilon = 0.0075;   % this is the threshold 
sc=0;
for i = 1:n
    p1 = P1(1:2,i);
    p2 = P2(1:2,i);
    A = cross_product_matrix(p1,p2);
    er = abs(A*h);
    sc = sc + (er(1,1)<epsilon && er(2,1)<epsilon);
end

end


