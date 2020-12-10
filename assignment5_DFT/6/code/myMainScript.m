%% Assignment 5 Question 6
%
%%
N = 201;
k1 = [0,1,0;1,-4,1;0,1,0];
k1_padded = zeros(N);
k1_padded(100:102,100:102)=k1;
K1 = fftshift(fft2(k1_padded));
logK1 = log(abs(K1)+1);
figure, imshow(logK1, [min(logK1(:)) max(logK1(:))]),
colormap('jet'), colorbar,
title("Log Magnitude of F.T of kernel 1");
figure, surf(logK1), colormap('jet'), colorbar,
title("Log Magnitude of F.T of kernel 1: Surf plot");
%%
N = 201;
k2 = [-1,-1,-1;-1,8,-1;-1,-1,-1];
k2_padded = zeros(N);
k2_padded(100:102,100:102)=k2;
K2 = fftshift(fft2(k2_padded));
logK2 = log(abs(K2)+1);
figure, imshow(logK2, [min(logK2(:)) max(logK2(:))]),
colormap('jet'), colorbar,
title("Log Magnitude of F.T of kernel 2");
figure, surf(logK2), colormap('jet'), colorbar,
title("Log Magnitude of F.T of kernel 2: Surf plot");