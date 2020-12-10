function[] = myhelper()
    H1 = fspecial('disk',4);
    H2 = fspecial('disk',8);
    H3 = fspecial('disk',12);
    H4 = fspecial('disk',16);
    H5 = fspecial('disk',20);
    figure,imshow(mat2gray(H1));
    figure,imshow(mat2gray(H2));
    figure,imshow(mat2gray(H3));
    figure,imshow(mat2gray(H4));
    figure,imshow(mat2gray(H5));

    H6 = fspecial('disk',8);
    H7 = fspecial('disk',16);
    H8 = fspecial('disk',24);
    H9 = fspecial('disk',32);
    H10 = fspecial('disk',20);
    figure,imshow(mat2gray(H6));
    figure,imshow(mat2gray(H7));
    figure,imshow(mat2gray(H8));
    figure,imshow(mat2gray(H9));
    figure,imshow(mat2gray(H10));    
    
end