%% MyMainScript

%% Your code here
% Note: The values may be different every time due to random noise introduction
% Hence, I have put random seed. Run section wise.
rng(47);
tic;
path = '../data/barbara.mat';
im = load(path).imageOrig ;
figure, my_show(im); title('un-noisy image');
% using imdistline image size is approximately 508
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I choose not to blur as the results are better and time taken is not much
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[m,n,c] = size(im);
%kernel = fspecial('gaussian', [4 4], 0.56*508/m);
%im = imfilter(im, kernel);
%im = imresize(im, 1/2); % downSample by factor of 2
%figure, my_show(im); title('downsampled un-noisy image');

[m,n,c] = size(im);
std = 0.05 * (max(im,[],'all') - min(im,[],'all')) ;
im1 = im + std .* randn([m,n,c]);
figure, my_show(im1); title('my noisy image');

[ret_img, mask, weight] = myPatchBasedFiltering(im1, 17, 9, 5.3, 5.94, 22, 307) ; 
% one can change 5.94 to 5.9*0.9 and 5.94*1.1 to check for variation in
% sigma values
figure, my_show(ret_img) ; title('filtered image'); 
figure, my_show(mask) ; title('mask barbara'); toc; 
figure, my_show(weight) ; title('to see weight given for cloth'); 

rmsd = sqrt(sum((im - ret_img).^2, 'all')/m/n);
fprintf('RMSD is %f', rmsd);

%%
rng(48);
tic;
path = '../data/honeyCombReal.png';
im = imread(path);
figure, my_show(im); title('original image');

imo = 255*mat2gray(im);
[m,n,c] = size(imo);
std = 0.05 * (max(imo,[],'all') - min(imo,[],'all')) ;
im1 = imo + std .* randn([m,n,c]);
figure, my_show(im1); title('my noisy image');

[ret_img, mask, weight] = myPatchBasedFiltering(im1, 25, 9, 5.5, 14.63, 174, 153) ; 
figure, my_show(ret_img) ; title('filtered image'); 
figure, my_show(mask) ; title('mask honey'); toc; 
figure, my_show(weight) ; title('to see weight given'); 
rmsd = sqrt(sum((255 * mat2gray(im) - ret_img).^2, 'all')/m/n);
fprintf('RMSD is %f', rmsd);

ret_img1 = myCLAHE(uint8(ret_img), 30, 0.01) ; figure, my_show(ret_img1) ; title('filter+clahe'); toc;
rmsd = sqrt(sum((uint8(255 * mat2gray(im)) - ret_img1).^2, 'all')/m/n);
fprintf('RMSD after histogram equilization is %f', rmsd);

%%
rng(49);
tic;
path = '../data/grass.png';
im = imread(path);
figure, my_show(im); title('original image');

imo = 255*mat2gray(im);
[m,n,c] = size(imo);
std = 0.05 * (max(imo,[],'all') - min(imo,[],'all')) ;
im1 = imo + std .* randn([m,n,c]);
figure, my_show(im1); title('my noisy image');

[ret_img, mask, weight] = myPatchBasedFiltering(im1, 25, 9, 4.6, 13, 32, 66) ;
figure, my_show(ret_img) ; title("filtered image");
figure, my_show(mask) ; title('mask for grass'); toc; 
figure, my_show(weight) ; title('weight by grass edge'); 
rmsd = sqrt(sum((255 * mat2gray(im) - ret_img).^2, 'all')/m/n);
fprintf('RMSD is %f', rmsd);

ret_img1 = myCLAHE(uint8(ret_img), 43, 0.09) ; figure, my_show(ret_img1) ; title('clahe+filter'); toc;
rmsd = sqrt(sum((uint8(255 * mat2gray(im)) - ret_img1).^2, 'all')/m/n);
fprintf('RMSD after histogram equilization is %f', rmsd);

%%

