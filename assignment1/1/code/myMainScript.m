%% MyMainScript

clear; clc;
tic;
%% Reading Images

path1 = '../data/barbaraSmall.png';
path2 = '../data/circles_concentric.png';
im1 = imread(path1);
im2 = imread(path2);

%% Q1
%% Q1(a)  
%% The original image

image_1a_1 = myShrinkImageByFactorD(path2, 2);
image_1a_2 = myShrinkImageByFactorD(path2, 3);

generate(im2,'gray');
title('Original image');

%% Image shrunk by d=2

generate(image_1a_1, 'gray');
title('d=2');


%% Image shrunk by d=3

generate(image_1a_2, 'gray');
title('d=3');

save('../images/image_1a_d2', 'image_1a_1');
save('../images/image_1a_d3', 'image_1a_2');

%% Q1(b)
%% The original image

image_1b = myBilinearInterpolation(path1);

generate(im1, 'gray');
title('Original image');

%% Bilinear Interpolated Image

generate(image_1b, 'gray');
title('Bilinear interpolation');

save('../images/image_1b', 'image_1b');
 
%% Q1(c)
%% The original image
 
image_1c = myNearestNeighbourInterpolation(path1);

generate(im1,'gray');
title('Original image');

%% Nearest Neighbour Interpolated image

generate(image_1c, 'gray');
title('Nearest Neighbour interpolation');

save('../images/image_1c', 'image_1c');

%% Q1(d)
%% The original image


image_1d = myBicubicInterpolation(path1);

generate(im1,'gray');
title('Original image');

%% Bicubic Interpolated image

generate(image_1d, 'gray');
title('Bicubic interpolation');

save('../images/image_1d', 'image_1d');

%% Q1(e)

%% Selected portion after Bilinear Interpolation

image_1e_1 = image_1b(100:200, 1:100);
image_1e_2 = image_1c(100:200, 1:100);
image_1e_3 = image_1d(100:200, 1:100);

generate(image_1e_1, 'jet');
title('Bilinear');

%% Selected portion after Nearest Neighbour Interpolation

generate(image_1e_2, 'jet');
title('Nearest Neighbour');

%% Selected portion after Bicubic Interpolation

generate(image_1e_3, 'jet');
title('Bicubic');

save('../images/image_1e_1', 'image_1e_1');
save('../images/image_1e_2', 'image_1e_2');
save('../images/image_1e_3', 'image_1e_3');

%% Q1(f)
%% The original image 
image_1f = myImageRotation(path1);

generate(im1, 'gray');
title('Original image');

%% Image after rotation by theta = 30

generate(image_1f, 'gray');
title('Rotated image');

save('../images/image_1f', 'image_1f');

%% 


toc;