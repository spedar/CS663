%% MyMainScript

%% Your code here
tic;
%Original Image
img = imread('../data/barbara256.png');
figure, my_show(img); title('original Image');

%% Ideal low pass filter
D=40;
[ret_img, H] = idealLowPassFilter(img, D);
figure, my_show(ret_img), title('Ideal Low Pass Filter with D=40');
figure, my_show(H), title('Ideal Filter with D=40'), colormap(jet), colorbar;

D=80;
[ret_img, H] = idealLowPassFilter(img, D);
figure, my_show(ret_img), title('Ideal Low Pass Filter with D=80');
figure, my_show(H), title('Ideal Filter with D=80'), colormap(jet), colorbar;

%% Gaussian low pass filter
D=40;
[ret_img, H] = gaussianLowPass(img, D);    
figure, my_show(ret_img), title('Gaussian Low Pass Filter with \sigma = 40');
figure, my_show(H), title('Gaussian Filter with \sigma = 40'),  colormap(jet), colorbar;

D=80;
[ret_img, H] = gaussianLowPass(img, D);
figure, my_show(ret_img), title('Gaussian Low Pass Filter with \sigma = 80');
figure, my_show(H), title('Gaussian Filter with \sigma = 80'),  colormap(jet), colorbar;

toc;
