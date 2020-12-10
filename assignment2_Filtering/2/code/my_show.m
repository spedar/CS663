function []= my_show(im)
    %
    %
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];  
    imagesc ( mat2gray(im)); % phantom is a popular test image
    colormap (myColorScale);
    %colormap jet;
    daspect ([1 1 1]);
    axis tight;
    colorbar
end