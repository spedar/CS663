function [] = restoration()
    I = im2double(imread("eminem.jpg"));
    figure, imshow(I);
    I = I(1:2:end,1:2:end,:);
    [x,y,z] = size(I);
    op = zeros(size(I));
    mask2d = ones(x,y);
    disp(x);
    disp(y);
    disp(z);
    for i = 1:x
        for j = 1:y
            if((mod(i,2) == 0 && mod(j,2) == 0) || (mod(i,2) == 1 && mod(j,2) == 1))
                mask2d(i,j) = 0;
                op(i,j,:) = I(i,j,:);
            end
        end
    end
    im = inpainting(op,mask2d,3,3000,10,1);
    disp(ssim(I,im));
    %figure ; subplot(1,3,1) ; imshow(I) ; subplot(1,3,2) ; imshow(op); subplot(1,3,3) ; imshow(im);
    %figure, imshow(I);
    figure, imshow(op);
    figure, imshow(im);
    
    
    I = im2double(imread("bird.jpg"));
    figure, imshow(I);
    I = I(1:2:end,1:2:end,:);
    [x,y,z] = size(I);
    op = zeros(size(I));
    mask2d = ones(x,y);
    disp(x);
    disp(y);
    disp(z);
    for i = 1:x
        for j = 1:y
            if((mod(i,2) == 0 && mod(j,2) == 0) || (mod(i,2) == 1 && mod(j,2) == 1))
                mask2d(i,j) = 0;
                op(i,j,:) = I(i,j,:);
            end
        end
    end
    im = inpainting(op,mask2d,2,3000,10,1);
    disp(ssim(I,im));
    %figure ; subplot(1,3,1) ; imshow(I) ; subplot(1,3,2) ; imshow(op); subplot(1,3,3) ; imshow(im);
    %figure, imshow(I);
    figure, imshow(op);
    figure, imshow(im);
    
end