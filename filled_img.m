 function final_img = filled_img(img,min_x,max_x,min_y,max_y,H)

 % ---------------finding the dimension of final stitched image------
if min_x <1
    x_end = max_x + abs(min_x);
else
    x_end = max_x;
end

if min_y <1
    y_end = max_y + abs(min_y);
else
    y_end = max_y;
end

final_img = NaN( ceil(y_end),ceil(x_end),3);% initializing the final image matrix 

for i = 1:ceil(x_end)
    for j = 1: ceil(y_end)
        
        x = i+ min_x;
        y = j+ min_y ;
  
        proj_z = H(3,1) * x + H(3,2) * y + H(3,3) ;
        proj_x = (H(1,1) * x + H(1,2) * y + H(1,3)) / proj_z ;
        proj_y = (H(2,1) * x + H(2,2) * y + H(2,3)) / proj_z ;
        
        %------------ performing nearest neighbour interpolation
        if (mod(proj_x,1)~=0)            
            proj_x = floor(proj_x+ 0.5);
        end
        if (mod(proj_y,1)~=0)
            proj_y = floor(proj_y + 0.5);
        end
        %-------------filling the intensities in the projected image-------
        if proj_x >=1 && proj_x <=size(img,2) && proj_y >= 1 && proj_y <=size(img,1)
            final_img(j,i,:) = img(proj_y,proj_x,:);
        end
    end
end
%---------------------- vectorized form of above loop---------------------
% i = 1:ceil(x_end) ;
% j =  1: ceil(y_end);
% 
% x = i+ min_x;
% y = j+ min_y ;
% 
% [u,v] = meshgrid(x,y) ;
% 
% z_ = H(3,1) * u + H(3,2) * v + H(3,3) ;
% u_ = (H(1,1) * u + H(1,2) * v + H(1,3)) ./ z_ ;
% v_ = (H(2,1) * u + H(2,2) * v + H(2,3)) ./ z_ ;
% 
% u_(mod(u_,1)~=0) =  floor(u_ + 0.5);
% v_(mod(v_,1)~=0) =  floor(v_ + 0.5);
% 
% proj_u = u_( u_ >=1 && u_ <=size(img,2) );
% proj_v = v_( v_ >=1 && v_ <=size(img,2) );

end

