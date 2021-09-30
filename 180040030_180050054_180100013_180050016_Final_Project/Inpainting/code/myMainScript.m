
%%
tic ;
% In the image address put all images one by one, it may take time for
% images to output.
% images are: glasses.png, redparrot.png, sea_turtle.png
img = im2double(imread('glasses.png'));
mask = imread('mask_glasses.png');
figure ; my_show(img);
figure ; my_show(mask);
ret_img = inpainting(img, mask, 21, 10, 10, 1) ;
figure ; my_show(ret_img);
ssim(img, ret_img);
toc;


%%