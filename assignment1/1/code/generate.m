function [] = generate(img,option)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];

    imagesc (single (255*mat2gray(img))); % phantom is a popular test image
    colormap (myColorScale);
    colormap(option);
    daspect ([1 1 1]);
    axis tight;
    colorbar
end

