clear; clc; clear all;
I = zeros(300);
J = I;
I(50:100,50:120) = 255;
J(20:70,120:190) = 255;

FfA = fftshift(fft2(I));
FfB = fftshift(fft2(J));

num = conj(FfA).*FfB;
denom = abs(FfA.*FfB);

lfft = log(abs(num./denom)+1); 
figure; imshow(lfft); colorbar;
title('Log-magnitude of cross-power spectrum')

invFf = ifft2(ifftshift(num./denom));
figure; 
imshow(invFf/max(invFf(:)));
title('IFT plot')

impixelinfo;


%%

I = zeros(300);
J = zeros(300);
I(50:100,50:120) = 255;
J(20:70,120:190) = 255;

% noisy_I = imnoise(I, 'gaussian', 0, 400);
% noisy_J = imnoise(J, 'gaussian', 0, 400);

noisy_I = I + randn(300) * 20;
noisy_J = J + randn(300) * 20;


FfA = fftshift(fft2(noisy_I));
FfB = fftshift(fft2(noisy_J));

num = conj(FfA).*FfB;
denom = abs(FfA.*FfB);

lfft = log(abs(num./denom)+1); 
figure; imshow(lfft); colorbar;
title('Log-magnitude of cross-power spectrum')

invFf = ifft2(ifftshift(num./denom));
figure; 
imshow(invFf/max(invFf(:)));
title('IFT plot')

impixelinfo;






