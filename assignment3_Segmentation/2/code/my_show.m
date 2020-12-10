function []= my_show(im)
    %
    %
    [~,~,c] = size(im);
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];  
    imagesc ( mat2gray(im)); % phantom is a popular test image
    colormap (myColorScale);
    %colormap jet;
    daspect ([1 1 1]);
    axis tight;
    colorbar ;
    if (c>1) 
       colorbar ;
       colormap(jet ); 
    end    
    
end

