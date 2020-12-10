function [J] = myShrinkImageByFactorD(image,d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%I = imread('circles_concentric.png');
I = imread(image);
%imshow(I);

%d = 2;
[m,n] = size(I);
%disp(m)
%disp(n)

J = zeros(floor(m/d), floor(n/d));
    for i = 1:m/d
        for j = 1:n/d
            J(i,j) = I(i*d,j*d);
        end
    end
    
% d = 3;
% K = zeros(floor(m/d), floor(n/d));
%     for i = 1:m/d
%         for j = 1:n/d
%             K(i,j) = I(i*d,j*d);
%         end
%     end

% myNumOfColors = 200;
% myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
% 
% colormap (myColorScale);
% colormap jet;
% daspect ([1 1 1]);
% axis tight;
% colorbar
% 
% subplot(1,3,1);
% imshow(mat2gray(I));
% title('Original image');
% axis on;
% colorbar
% 
% subplot(1,3,2);
% imshow(mat2gray(J));
% title('d=2');
% axis on;
% colorbar
% 
% subplot(1,3,3);
% imshow(mat2gray(K));
% title('d=3');
% axis on;
% colorbar
% set(gcf, 'Position', [500 500 1000 500]);

%
%imshow(mat2gray(J))
end
