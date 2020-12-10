%% MyMainScript

tic;
%% Your code here
clc;
clear;
close all;
load("../data/image_low_frequency_noise.mat")
figure,imagesc(Z);
title('Original image');
daspect([1 1 1]);
axis tight;
colormap('gray');

% calculate Fourier transform
F1 = fftshift(fft2(Z));
figure;
daspect([1 1 1]);
imagesc(log(abs(F1)+1));
title('Log Fourier transform of the image');
axis tight;
colormap('jet');

%impixelinfo;

F2 = F1;
F2(117:121,122:126)=0;
F2(138:142,133:137)=0;
figure;
daspect([1 1 1]);
imagesc(log(abs(F2)+1));
title('Log Fourier transform of the image with notch filter');
axis tight;
colormap('jet');

F3 = ifft2(ifftshift(F2));
figure;
daspect([1 1 1]);
imagesc(abs(F3));
title('Restored image');
axis tight;
colormap('gray');


toc;