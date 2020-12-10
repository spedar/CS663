%% MyMainScript


% Image 1: BIRD
tic;
fprintf('\nThe image of the bird:\n')
path1 = "../data/bird.jpg";
im1 = imread(path1);
figure, imshow(im1);
im2 = im2gray(im1);
edge1 = edge(im2,'approxcanny',[0.2 0.6]);
se = strel('disk',20);
edge2 = imclose(edge1, se);
mask1 = imfill(edge2, 'holes');
figure, imshow(mask1);
toc;

%% Image 2: FLOWER
tic;
fprintf('\nThe image of the flower:\n')
path1 = "../data/flower.jpg";
im3 = imread(path1);
figure, imshow(im3);
imc = Km(im3, 6);
rng(12);
edge3 = edge(im2gray(imc),'Canny',[0.3 0.67]);
se = strel('disk',5);
edge4 = imclose(edge3, se);
mask2 = imfill(edge4, 'holes');
mask2(:,1:145) = 0;
figure, imshow(mask2);
toc;

%%
myMask();
%%
mycontour();
%%
myhelper();
%%
mySpatiallyVaryingKernel();
