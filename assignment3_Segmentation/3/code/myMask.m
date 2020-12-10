function[] = myMask()
    I = imread("../data/bird.jpg");
    disp(size(I));
    I1 = rgb2gray(I);
    edges = edge(I1,'approxcanny',[0.1 0.99]);
    figure, imshow(mat2gray(I));
    se = strel('disk',10);
    I2 = imclose(edges,se);
    I4 = imfill(I2,'holes');
    disp(size(I4));
    disp(size(I));
    [m,n,~] = size(I);
    I3 = zeros(m,n);
    for i = 1:m
        for j = 1:n
            I3(i,j) = 1 - I4(i,j);
        end
    end
    mask = zeros(m,n);
    mask1 = zeros(m,n);
    for i = 1:m
        for j = 1:n
               mask(i,j) = I4(i,j);
               mask1(i,j) = 1 - I4(i,j);
        end
    end
    %figure, imshow(edges);
    %figure, imshow(I2);
    masked = I .* uint8(mask);
    masked1 = I .* uint8(mask1);
    figure, imshow(mask);
    disp(size(mask));
    figure, imshow(masked);
    figure, imshow(masked1);
    
 
    
%path1 = "../data/flower.jpg";
%im3 = imread(path1);
%imc = Km(im3, 6);
%rng(12);
%edge3 = edge(im2gray(imc),'Canny',[0.3 0.67]);
%se = strel('disk',5);
%edge4 = imclose(edge3, se);
%mask2 = imfill(edge4, 'holes');
%mask2(:,1:145) = 0;    
    
    
    im3 = imread("../data/flower.jpg");
    figure,imshow(im3);
    imc = Km(im3, 6);
    
    rng(12);
    edge3 = edge(im2gray(imc), 'Canny', [0.3,0.67]);
    edge4 = imclose(edge3, se);
    se = strel('disk',5);
    mask2 = imfill(edge4, 'holes');
    mask2(:,1:145) = 0;
    disp(size(im3));
%    I1 = rgb2gray(I);
%    edges = edge(I1,'approxcanny',[0.1 0.99]);
%    figure, imshow(mat2gray(I));
%    se = strel('disk',10);
%    I2 = imclose(edges,se);
%    I4 = imfill(I2,'holes');
%    disp(size(I4));
%    disp(size(I));
%    [m,n,~] = size(I);
%    I3 = zeros(m,n);
%    for i = 1:m
%        for j = 1:n
%            I3(i,j) = 1 - I4(i,j);
%        end
%    end
%    mask = zeros(m,n);
%    mask1 = zeros(m,n);
%    for i = 1:m
%        for j = 1:n
%               mask(i,j) = I4(i,j);
%               mask1(i,j) = 1 - I4(i,j);
%        end
%    end
    %figure, imshow(edges);
    %figure, imshow(I2);
    [x,y] = size(mask2);
    mask3 = zeros(x,y);
    for i = 1:x
        for j = 1:y
            mask3(i,j) = 1 - mask2(i,j);
        end
    end
    maskedim = im3 .* uint8(mask2);
    maskedim1 = im3 .* uint8(mask3);
    figure, imshow(mask2);
    %disp(size(mask));
    figure, imshow(maskedim);
    figure, imshow(maskedim1);
    
    
    
    
    
end