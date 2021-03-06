path_2 = 'image01.jpg';
path_1 = 'image02.jpg';
path0 = 'image03.jpg';
path1 = 'image04.jpg';
path2 = 'image05.jpg';

%run('C:\Users\91626\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')

im_2 = im2single(imread(path_2));
im_1 = im2single(imread(path_1));
im0 = im2single(imread(path0));
im1 = im2single(imread(path1));
im2 = im2single(imread(path2));

%--------------Calculating H matrix of each individual image---------%

H01  = calculate_H(im0,im1);
H12 = calculate_H(im1,im2);
H0_1 = calculate_H(im0,im_1);
H_1_2 = calculate_H(im_1,im_2);

H0 = eye(3);
H1 = H01 ;           H1=H1/H1(3,3);
H2 = H12 * H1 ;      H2=H2/H2(3,3);
H_1 = H0_1;       H_1 = H_1/H_1(3,3);
H_2 = H_1_2 *H_1 ;       H_2=H_2/H_2(3,3);

%-----------Calculating the range coordinates of the final stitched image-----%

bxdim2= boxsize(size(im1,1,2),H1);
bxdim3= boxsize(size(im2,1,2),H2);
bxdim4= boxsize(size(im_1,1,2),H_1);
bxdim5= boxsize(size(im_2,1,2),H_2);

min_x = min([1 bxdim2(1,:) bxdim3(1,:) bxdim4(1,:) bxdim5(1,:)]);
max_x =  max([size(im0,2) bxdim2(1,:) bxdim3(1,:) bxdim4(1,:) bxdim5(1,:)]) ;
min_y = min([1 bxdim2(2,:) bxdim3(2,:) bxdim4(2,:) bxdim5(2,:)]);
max_y = max([size(im0,1) bxdim2(2,:) bxdim3(2,:) bxdim4(2,:) bxdim5(2,:)]) ;

%----------Filling the empty space by projecting all images on it------%

imag1 = filled_img(im2double(im0),min_x,max_x,min_y,max_y,H0) ;
imag2 = filled_img(im2double(im1),min_x,max_x,min_y,max_y,H1) ;
imag3 = filled_img(im2double(im2),min_x,max_x,min_y,max_y,H2) ;
imag4 = filled_img(im2double(im_1),min_x,max_x,min_y,max_y,H_1) ;
imag5 = filled_img(im2double(im_2),min_x,max_x,min_y,max_y,H_2) ;

%--------Summing all the images without blending-------------%
bmos = imag1;
bmos(isnan(bmos))= imag2(isnan(bmos));
bmos(isnan(bmos))= imag3(isnan(bmos));
bmos(isnan(bmos))= imag4(isnan(bmos));
bmos(isnan(bmos))= imag5(isnan(bmos));
bmos(isnan(bmos))= 0;

%----------Summing all images by averaging-------------------%
coff = ~isnan(imag1) + ~isnan(imag2) + ~isnan(imag3) + ~isnan(imag4) + ~isnan(imag5);
imag1(isnan(imag1)) = 0 ;imag2(isnan(imag2)) = 0 ;imag3(isnan(imag3)) = 0 ;imag4(isnan(imag4)) = 0 ;imag5(isnan(imag5)) = 0 ;

mosaic = (imag1 + imag2 + imag3 + imag4 + imag5 ) ./ coff ;

%-------------Printing the output-------------------
imshow(mosaic);
imshow(bmos);
