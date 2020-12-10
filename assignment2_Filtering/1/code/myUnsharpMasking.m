function[] = myUnsharpMasking()
    rng(0);
    F = load("lionCrop.mat");
    F = double(F.imageOrig);
    
    g1 = imadjust(F,stretchlim(F),[0,1]);
    figure, imshow(g1);        
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    imagesc (g1); % phantom is a popular test image
    colormap (myColorScale);
    colormap gray;
    daspect ([1 1 1]);
    axis tight;
    colorbar
    
    
    

    
    g = fspecial('gaussian',3,0.5);
    F1 = F - imfilter(F,g);
    s = 12;
    F2 = F + s*F1;
    %figure, imshow(mat2gray(F2));


    g2 = imadjust(F2,stretchlim(F2),[0,1]);        
    figure, imshow(g2);
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    imagesc (g2); % phantom is a popular test image
    colormap (myColorScale);
    colormap gray;
    daspect ([1 1 1]);
    axis tight;
    colorbar

    
    F = load("superMoonCrop.mat");
    F = double(F.imageOrig);
    
    g3 = imadjust(F,stretchlim(F),[0,1]);
    figure, imshow(g3);        
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    imagesc (g3); % phantom is a popular test image
    colormap (myColorScale);
    colormap gray;
    daspect ([1 1 1]);
    axis tight;
    colorbar    
    
    
    
    g = fspecial('gaussian',5,2);
    F1 = F - imfilter(F,g);
    s = 12;
    F2 = F + s*F1;
    %figure, imshow(mat2gray(F2));


    g4 = imadjust(F2, stretchlim(F2), [0,1]);
    figure, imshow(g4);
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    imagesc (g4); % phantom is a popular test image
    colormap (myColorScale);
    colormap gray;
    daspect ([1 1 1]);
    axis tight;
    colorbar

    
    
    
end