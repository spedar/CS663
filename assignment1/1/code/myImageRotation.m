function [J] = myImageRotation(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%I = imread('barbaraSmall.png');
I = imread(image);
%imshow(I);

[m,m] = size(I);
theta = 30;

new_side = 1 + 2*ceil(sind(45 + theta) * floor(m/2) * sqrt(2)); %141
gap = (new_side - m)/2; %19

mid = ceil(new_side/2); %71
origin = [mid, mid]; %[71, 71]

xc1 = -floor(m/2); %-51
yc1 = -floor(m/2); %-51
xc2 = -xc1; %51
yc2 = -yc1; %51
norm = 1+xc2; %52

J = zeros(new_side, new_side);
J;
%size(J)

rot_mat = [cosd(theta) sind(theta); 0-sind(theta) cosd(theta)];

    for i = 1:new_side
        for j = 1:new_side

            i_norm = i - mid;
            j_norm = j - mid;
            new_coord = [i_norm ,j_norm] * rot_mat;

            i_prev = new_coord(1);
            j_prev = new_coord(2);

            if( xc1 <= i_prev && i_prev <= xc2 && yc1 <= j_prev && j_prev <= yc2)
                x1 = floor(i_prev);
                x2 = ceil(i_prev);
                y1 = floor(j_prev);
                y2 = ceil(j_prev);
                
                q11 = I(x1+norm,y1+norm);
                q12 = I(x1+norm,y2+norm);
                q21 = I(x2+norm,y1+norm);
                q22 = I(x2+norm,y2+norm);

                x = i_prev;
                y = j_prev;
                
                if(x1 ~= x2 && y1 ~= y2)
                    J(i,j) = q11*(x2-x)*(y2-y) + q12*(x2-x)*(y-y1) + q22*(x-x1)*(y-y1) + q21*(x-x1)*(y2-y);
                    
                elseif(x1 == x2 && y1 ~= y2)
                    J(i,j) = q11*(y2-y) + q12*(y-y1);
                
                elseif(y1 == y2 && x1 ~= x2)
                    J(i,j) = q11*(x2-x) + q21*(x-x1);
                
                else
                    J(i,j) = q11;
                    
                end
            end
        end
    end
    

% myNumOfColors = 200;
% myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
%     
% colormap (myColorScale);
% colormap jet;
% daspect ([1 1 1]);
% axis tight;
% colorbar
% 
% subplot(1,2,1);
% imshow(mat2gray(I));
% axis on;
% colorbar
% 
% subplot(1,2,2);
% imshow(mat2gray(J));
% axis on;
% colorbar    
% 
% set(gcf, 'Position', [500 500 1000 500]);
    
%J(71, :);
%imshow(mat2gray(J));
end

