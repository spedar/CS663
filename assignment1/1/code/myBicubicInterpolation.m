function [J] = myBicubicInterpolation(image)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%I = [1,2,3; 4,5,6; 7,8,9];
%I
%I = imread('barbaraSmall.png');
I = imread(image);
I;
imshow(I);

[m,n] = size(I);
% disp(m);
% disp(n);

left_mat = [1 0 0 0; 0 0 1 0; -3 3 -2 -1; 2 -2 1 1];
right_mat = [1 0 -3 2; 0 0 3 -2; 0 1 -2 1; 0 0 -1 1];

J = zeros(3*m+4, 2*n +3);
    for i = 1:m
        for j = 1:n
            J(3*i+1, 2*j+1) = I(i,j);
        end
    end
    
J(1,:) = J(4,:);
J(3*m+4, :) = J(3*m +1,:);
J(:, 1) = J(:,3);
J(:, 2*n+3) = J(:, 2*n+1);
%imshow(J);
%J

    for i = 1: m-1
        for j = 1: n-1
            %disp(i + " : " + j);
            
            tl = [3*i+1, 2*j+1];
            tr = [3*i+1, 2*j+3];
            bl = [3*i+4, 2*j+1];
            br = [3*i+4, 2*j+3];
            
            %disp(tl);
            %disp(size(tl));
            
            x1 = tl(1);
            y1 = tl(2);
            x2 = br(1);
            y2 = br(2);
            %den = (x2-x1)*(y2-y1);
            
            f00 = J(x1,y1);
            f01 = J(x1,y2);
            f10 = J(x2,y1);
            f11 = J(x2,y2);
            
            fx00 = (J(x1+3,y1) - J(x1-3,y1)) /6;
            fx01 = (J(x1+3,y2) - J(x1-3,y2)) /6;
            fx10 = (J(x2+3,y1) - J(x2-3,y1)) /6;
            fx11 = (J(x2+3,y2) - J(x2-3,y2)) /6;
            
            fy00 = (J(x1,y1+2) - J(x1,y1-2)) /4;
            fy01 = (J(x1,y2+2) - J(x1,y2-2)) /4;
            fy10 = (J(x2,y1+2) - J(x2,y1-2)) /4;
            fy11 = (J(x2,y2+2) - J(x2,y2-2)) /4;
            
            fxy00 = (J(x1+3,y1+2) + J(x1-3,y1-2) - J(x1-3,y1+2) - J(x1+3,y1-2)) /24;
            fxy01 = (J(x1+3,y2+2) + J(x1-3,y2-2) - J(x1-3,y2+2) - J(x1+3,y2-2)) /24;
            fxy10 = (J(x2+3,y1+2) + J(x2-3,y1-2) - J(x2-3,y1+2) - J(x2+3,y1-2)) /24;
            fxy11 = (J(x2+3,y2+2) + J(x2-3,y2-2) - J(x2-3,y2+2) - J(x2+3,y2-2)) /24;
            
            F = [f00 f01 fy00 fy01; f10 f11 fy10 fy11; fx00 fx01 fxy00 fxy01; fx10 fx11 fxy10 fxy11];
            
            
%             q11 = J(x1,y1);
%             q12 = J(x1,y2);
%             q21 = J(x2,y1);
%             q22 = J(x2,y2);
            A = left_mat * F * right_mat;
            
            for k = 0:2
                for l = 0:1
                    xn = k/3;
                    yn = l/2;
                    
                    if ~(k==0 && l==0)
                        x = x1 + k;
                        y = y1 + l;   
                        
                        J(x,y) = [1 xn xn^2 xn^3] * A * [1; yn; yn^2; yn^3];
%                         J(x,y) = q11*(x2-x)*(y2-y) + q12*(x2-x)*(y-y1) + q22*(x-x1)*(y-y1) + q21*(x-x1)*(y2-y);
%                         J(x,y) = J(x,y)/den;
                    end
                    
                    if (i== m-1)
                        x = x1 + 3;
                        y = y1 + 1;
                        
                        J(x,y) = [1 xn xn^2 xn^3] * A * [1; yn; yn^2; yn^3];
%                         J(x,y) = q11*(x2-x)*(y2-y) + q12*(x2-x)*(y-y1) + q22*(x-x1)*(y-y1) + q21*(x-x1)*(y2-y);
%                         J(x,y) = J(x,y)/den;
                    end
                    
                    if (j== n-1)
                        x = x1 + 1;
                        y = y1 + 2;
                        
                        J(x,y) = [1 xn xn^2 xn^3] * A * [1; yn; yn^2; yn^3];
%                         J(x,y) = q11*(x2-x)*(y2-y) + q12*(x2-x)*(y-y1) + q22*(x-x1)*(y-y1) + q21*(x-x1)*(y2-y);
%                         J(x,y) = J(x,y)/den;
                        
                        x = x1 + 2;
                        y = y1 + 2;
                        
                        J(x,y) = [1 xn xn^2 xn^3] * A * [1; yn; yn^2; yn^3];
%                         J(x,y) = q11*(x2-x)*(y2-y) + q12*(x2-x)*(y-y1) + q22*(x-x1)*(y-y1) + q21*(x-x1)*(y2-y);
%                         J(x,y) = J(x,y)/den;
                    end
                end
            end
        end
    end
    
J = J(4:end-3, 3:end-2);

% myNumOfColors = 200;
% myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
% 
% %imagesc (single (phantom)); % phantom is a popular test image
% colormap (myColorScale);
% colormap jet;
% daspect ([1 1 1]);
% axis tight;
% colorbar
% 
% figure(6)
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

%J
%imshow(mat2gray(J));
end


