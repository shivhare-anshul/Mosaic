function  H = calculate_H(im1,im2)

im1g = rgb2gray(im1);
im2g = rgb2gray(im2) ;

[feature_1,descriptor1] = vl_sift(im1g) ;
[feature_2,descriptor2] = vl_sift(im2g) ;

[matched_index, scores] = vl_ubcmatch(descriptor1,descriptor2);

P1 = feature_1(1:2,matched_index(1,:)) ; % storing all matching points of image1
P2 = feature_2(1:2,matched_index(2,:)) ; % storing all matching points of image2

%-----------------Applying RANSAC and simultaneously finding H----------------------------%
max_score = -9999;
N=200;

for i=1:N
    random_index = randi(size(matched_index,2),4,1); %selecting 4 random indexes 
    A= zeros(8,9);
    for r = 1:4          %this loop is computing A matrix
        rand=random_index(r,1);
        p1=P1(1:2,rand);
        p2=P2(1:2,rand);
        lst_2_row = cross_product_matrix(p1,p2);
        A(2*r-1:2*r,:) = lst_2_row;
    end
    
    [U,S,V] = svd(A);   % finding solution by SVD
    h=V(:,9);
    score = cal_score(P1,P2,h);
    if max_score < score  %comparing score and storing the one with highest score
        max_score = score;
        hmax=h;
    end
end

H = reshape(hmax,3,3);
H=H/H(3,3);
H=H';

end

