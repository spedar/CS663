%% MyMainScript

tic;
%% Your code here

path1 = "../data/baboonColor.png";
path2 = "../data/bird.jpg";
path3 = "../data/flower.jpg";

%%
rng(47);
% tic;
d=4;
hs=16;
hr=8;
lr=200;
it=20;

image1 = imread(path1);
I = image1;

g = fspecial('gaussian', 9, 1);
J = imfilter(I, g);

% sub-sampling by factor 4
[m,n,~] = size(I);
%     d=2;

K = zeros(floor(m/d), floor(n/d), 5);
for i = 1:m/d
    for j = 1:n/d
        for k = 1:3
            K(i,j,k) = J(i*d,j*d,k);
        end

            K(i,j,4) = i;
            K(i,j,5) = j;
    end
end


k=10;
J1 = myMeanShiftSegmentation(image1, d, hs, hr, lr, it, k,K);

figure;
imshow(mat2gray(K(:,:,1:3)));
% title('Original image');

figure, imshow(mat2gray(J1));
% title('Segmented image');
% toc;

%%
rng(48);

% tic;
d=6;
hs=20;
hr=20;
lr=450;
it=15;
image2 = imread(path2);
I = image2;

g = fspecial('gaussian', 9, 1);
J = imfilter(I, g);

% sub-sampling by factor 4
[m,n,~] = size(I);
%     d=2;

K = zeros(floor(m/d), floor(n/d), 5);
for i = 1:m/d
    for j = 1:n/d
        for k = 1:3
            K(i,j,k) = J(i*d,j*d,k);
        end

            K(i,j,4) = i;
            K(i,j,5) = j;
    end
end


k=10;

J2 = myMeanShiftSegmentation(image2, d,hs,hr,lr,it,k,K);

figure; imshow(mat2gray(K(:,:,1:3))); 
% title('Original image');
figure, imshow(mat2gray(J2));
% title('Segmented image');

% toc;
%%
rng(49);

% tic;
d=3;
hs=12;
hr=12;
lr=200;
it=25;
% k=15;
image3 = imread(path3);
I = image3;

g = fspecial('gaussian', 9, 1);
J = imfilter(I, g);

% sub-sampling by factor 4
[m,n,~] = size(I);
%     d=2;

K = zeros(floor(m/d), floor(n/d), 5);
for i = 1:m/d
    for j = 1:n/d
        for k = 1:3
            K(i,j,k) = J(i*d,j*d,k);
        end

            K(i,j,4) = i;
            K(i,j,5) = j;
    end
end


k=10;

% image3 = imread(path3);
J3 = myMeanShiftSegmentation(image3, d, hs, hr, lr, it, k, K);

figure, imshow(mat2gray(K(:,:,1:3)));
% title('Original image');
figure, imshow(mat2gray(J3));
% title('Segmented image');

toc;
