function[] = mySpatiallyVaryingKernel()
    
    I1 = imread("../data/flower.jpg");
    Ia = rgb2gray(I1);
    disp(size(I1));
    imc = Km(I1, 6);
    rng(12);
    edge3 = edge(im2gray(imc),'Canny',[0.3 0.67]);  
    se = strel('disk',5);
    edge4 = imclose(edge3, se);
    I4 = imfill(edge4, 'holes');
    I4(:,1:145) = 0;

    [m,n,~] = size(I1);
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
    
    disp(size(mask));
    
    alpha = 20;
    I = padarray(I1,[alpha,alpha],'both','replicate');
    figure, imshow(mat2gray(I1));
%    I2 = imread("Assignment 3/maskbird.jpg");
%    disp(size(I2));
    D = bwdist(mask);
    disp(size(D));
    [m,n,~] = size(I1);
    final = zeros(m,n,3);
%    disp(m);
%    disp(n);
    for i = 1:m
        for j = 1:n
            %disp(i);
            if(mask(i,j) == 0)
                d = double(D(i,j,1));
                if (d < alpha)
                    F = fspecial('disk',d);
                    [x,~] = size(F);
                    d1 = (x - 1) / 2; 
                    G1 = I(i+alpha-d1:i+alpha+d1,j+alpha-d1:j+alpha+d1,1);
                    G2 = I(i+alpha-d1:i+alpha+d1,j+alpha-d1:j+alpha+d1,2);
                    G3 = I(i+alpha-d1:i+alpha+d1,j+alpha-d1:j+alpha+d1,3);
                    final(i,j,1)  = sum(F .* double(G1),"all");
                    final(i,j,2)  = sum(F .* double(G2),"all");
                    final(i,j,3)  = sum(F .* double(G3),"all");
                else
                    F = fspecial('disk',alpha);
                    G1 = I(i:i+2*alpha,j:j+2*alpha,1);
                    G2 = I(i:i+2*alpha,j:j+2*alpha,2);
                    G3 = I(i:i+2*alpha,j:j+2*alpha,3);
                    final(i,j,1)  = sum(F .* double(G1),"all");
                    final(i,j,2)  = sum(F .* double(G2),"all");
                    final(i,j,3)  = sum(F .* double(G3),"all");
                end
            else
                final(i,j,1) = I1(i,j,1);
                final(i,j,2) = I1(i,j,2);
                final(i,j,3) = I1(i,j,3);
            end
        end
    end

    figure,imshow(mat2gray(final));
    
    
    I1 = imread("../data/bird.jpg");
    I1 = imresize(I1,0.5);
    Ia = rgb2gray(I1);
    disp(size(I1));
    edges = edge(Ia,'approxcanny',[0.1 0.99]);
    %figure, imshow(mat2gray(I));
    se = strel('disk',10);
    I2 = imclose(edges,se);
    I4 = imfill(I2,'holes');
    
    [m,n,~] = size(I1);
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
    
    disp(size(mask));
    
    alpha = 20;
    I = padarray(I1,[alpha,alpha],'both','replicate');
    figure, imshow(mat2gray(I1));
%    I2 = imread("Assignment 3/maskbird.jpg");
%    disp(size(I2));
    D = bwdist(mask);
    disp(size(D));
    [m,n,~] = size(I1);
    final = zeros(m,n,3);
%    disp(m);
%    disp(n);
    for i = 1:m
        for j = 1:n
            %disp(i);
            if(mask(i,j) == 0)
                d = double(D(i,j,1));
                if (d < alpha)
                    F = fspecial('disk',d);
                    [x,~] = size(F);
                    d1 = (x - 1) / 2; 
                    G1 = I(i+alpha-d1:i+alpha+d1,j+alpha-d1:j+alpha+d1,1);
                    G2 = I(i+alpha-d1:i+alpha+d1,j+alpha-d1:j+alpha+d1,2);
                    G3 = I(i+alpha-d1:i+alpha+d1,j+alpha-d1:j+alpha+d1,3);
                    final(i,j,1)  = sum(F .* double(G1),"all");
                    final(i,j,2)  = sum(F .* double(G2),"all");
                    final(i,j,3)  = sum(F .* double(G3),"all");
                else
                    F = fspecial('disk',alpha);
                    G1 = I(i:i+2*alpha,j:j+2*alpha,1);
                    G2 = I(i:i+2*alpha,j:j+2*alpha,2);
                    G3 = I(i:i+2*alpha,j:j+2*alpha,3);
                    final(i,j,1)  = sum(F .* double(G1),"all");
                    final(i,j,2)  = sum(F .* double(G2),"all");
                    final(i,j,3)  = sum(F .* double(G3),"all");
                end
            else
                final(i,j,1) = I1(i,j,1);
                final(i,j,2) = I1(i,j,2);
                final(i,j,3) = I1(i,j,3);
            end
        end
    end

    figure,imshow(mat2gray(final));
end