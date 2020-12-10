function[] = mycontour()
    
    
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
    final = zeros(m,n);
%    disp(m);
%    disp(n);
    for i = 1:m
        for j = 1:n
            %disp(i);
            if(mask(i,j) == 0)
                d = double(D(i,j,1));
                if (d < alpha)
                    final(i,j) = d;
                else
                    final(i,j) = alpha;
                end
            end
        end
    end

    contour(final);
    
    
    
    
    
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
    final = zeros(m,n);
%    disp(m);
%    disp(n);
    for i = 1:m
        for j = 1:n
            %disp(i);
            if(mask(i,j) == 0)
                d = double(D(i,j,1));
                if (d < alpha)
                    final(i,j) = d;
                else
                    final(i,j) = alpha;
                end
            end
        end
    end

    contour(final);
    
    
end