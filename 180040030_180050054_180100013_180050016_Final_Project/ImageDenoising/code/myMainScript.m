img1 = 'noisy_train.jpeg';
img2 = 'noisy_taj.jpeg';
img3 = 'guy_head.png';
img4 = 'noisy_lenna2.jpg';

%%
orig_img = imread(img1);
denoised_img = image_denoising(img1,1,1,15);

figure ; 
subplot(1,2,1) ; imshow(orig_img);
title('Original image');

subplot(1,2,2) ; imshow(denoised_img);
title('De-noised image');

%%

orig_img = imread(img2);
denoised_img = image_denoising(img2,1,1,5);

figure ; 
subplot(1,2,1) ; imshow(orig_img);
title('Original image');

subplot(1,2,2) ; imshow(denoised_img);
title('De-noised image');


%%
orig_img = imread(img3);
denoised_img = image_denoising(img3,3,1,5);

figure ; 
subplot(1,2,1) ; imshow(orig_img);
title('Original image');

subplot(1,2,2) ; imshow(denoised_img);
title('De-noised image');

%%
orig_img = imread(img4);
denoised_img = image_denoising(img4,5,2,5);

figure ; 
subplot(1,2,1) ; imshow(orig_img);
title('Original image');

subplot(1,2,2) ; imshow(denoised_img);
title('De-noised image');
