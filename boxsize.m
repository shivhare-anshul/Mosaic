function final_proj_matrix = boxsize(img_size,H)
x = img_size(1,2);
y = img_size(1,1);
four_end_points = [1 x x 1; 1 1 y y;1 1 1 1];
proj_end_cordinates = inv(H)*four_end_points ;

proj_end_cordinates(1,:) = proj_end_cordinates(1,:) ./ proj_end_cordinates(3,:) ;
proj_end_cordinates(2,:) = proj_end_cordinates(2,:) ./ proj_end_cordinates(3,:) ;

final_proj_matrix = zeros(2,4);
final_proj_matrix(1,:)=proj_end_cordinates(1,:);
final_proj_matrix(2,:)=proj_end_cordinates(2,:);
end

