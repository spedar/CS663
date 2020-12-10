function [J] = myNearestNeighbourInterpolation(image)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%I = imread('barbaraSmall.png');
I = imread(image);

%imshow(I);
%I = [1,2,3; 4,5,6; 7,8,9; 10,11,12];
[m,n,l] = size(I);
% disp(m);
% disp(n);

J = zeros(3*m-2, 2*n -1);
    for i = 1:m
        for j = 1:n
            J(3*i-2, 2*j-1) = I(i,j);
        end
    end
%imshow(J);
%J;

    for i = 1: m-1
        for j = 1: n-1
            tl = [3*i-2, 2*j-1];
            tr = [3*i-2, 2*j+1];
            bl = [3*i+1, 2*j-1];
            br = [3*i+1, 2*j+1];
            
            %disp(tl);
            %disp(size(tl));
            
            x1 = tl(1);
            y1 = tl(2);
            x2 = br(1);
            y2 = br(2);
            %den = (x2-x1)*(y2-y1);
            x_mean = (x1+x2)/2;
            y_mean = (y1+y2)/2;
            
            q11 = J(x1,y1);
            q12 = J(x1,y2);
            q21 = J(x2,y1);
            q22 = J(x2,y2);
            
            for k = 0:2
                for l = 0:1
                    if ~(k==0 && l==0)
                        x = x1 + k;
                        y = y1 + l;
                 
                        if (x>= x_mean && y>=y_mean)
                            J(x,y) = J(x2,y2);
                        elseif (x >= x_mean && y<y_mean)
                            J(x,y) = J(x2,y1);
                        elseif (x< x_mean && y>=y_mean)
                            J(x,y) = J(x1,y2);
                        else
                            J(x,y) = J(x1,y1);
                        end
                        
                    end
                    
                    if (i== m-1)
                        x = x1 + 3;
                        y = y1 + 1;
                        if (x>= x_mean && y>=y_mean)
                            J(x,y) = J(x2,y2);
                        elseif (x >= x_mean && y<y_mean)
                            J(x,y) = J(x2,y1);
                        elseif (x< x_mean && y>=y_mean)
                            J(x,y) = J(x1,y2);
                        else
                            J(x,y) = J(x1,y1);
                        end
                    end
                    
                    if (j== n-1)
                        x = x1 + 1;
                        y = y1 + 2;
                        if (x>= x_mean && y>=y_mean)
                            J(x,y) = J(x2,y2);
                        elseif (x >= x_mean && y<y_mean)
                            J(x,y) = J(x2,y1);
                        elseif (x< x_mean && y>=y_mean)
                            J(x,y) = J(x1,y2);
                        else
                            J(x,y) = J(x1,y1);
                        end
                        
                        x = x1 + 2;
                        y = y1 + 2;
                        if (x>= x_mean && y>=y_mean)
                            J(x,y) = J(x2,y2);
                        elseif (x >= x_mean && y<y_mean)
                            J(x,y) = J(x2,y1);
                        elseif (x< x_mean && y>=y_mean)
                            J(x,y) = J(x1,y2);
                        else
                            J(x,y) = J(x1,y1);
                        end
                    end
                end
            end
        end
    end

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];

%imagesc (single (phantom)); % phantom is a popular test image
% colormap (myColorScale);
% colormap jet;
% daspect ([1 1 1]);
% %axis tight;
% %colorbar
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

% set(gcf, 'Position', [500 500 1000 500]);

% K = imcrop(J);
%J;
% imshow(mat2gray(J));
end
