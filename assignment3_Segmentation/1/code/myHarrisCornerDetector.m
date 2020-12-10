function [eigA, eigB, ret_img] = myHarrisCornerDetector(im, win_size, h1, h2, k)
    %MYHARRISCORNERDETECTOR Summary of this function goes here
    %   Detailed explanation goes here
    % This code is written by Deep Satra. 
    % win_size is the size of window, h1 is for smoothing and h2 is
    % gaussian parameter for allowing isotropic-ness. k is the corner-ness
    % parameter. This function returns 2 eigen maps of structure tensor and
    % map of corner-ness values
    
    [m,n,~] = size(im);
    wt = linspace(0,1,10);
    wt = (wt - median(wt)).^2;
    mask = exp(-(wt' + wt)/h1/h1);
    im_smooth = imfilter(im,mask,'replicate'); 
    figure, my_show(im_smooth); title('smooth');
    
    dx = [-1,0,1; -2,0,2; -1,0,1];
    imx = imfilter(im_smooth,dx,'replicate');
    figure, my_show(imx); title('Ix');
    %%
    imy = imfilter(im_smooth,dx','replicate');
    figure, my_show(imy); title('Iy');
    
    win_sz = int32((win_size - 1)/2) ;
    t_wt = linspace(0,1,win_size);
    t_wt = (t_wt - median(t_wt)).^2;
    base_ten_mask = exp(-(t_wt' + t_wt)/h2/h2);
    
    eigA = zeros([m,n]);
    eigB = zeros([m,n]);
    ret_img = zeros([m,n]);
    for i=[1:m]
        for j=[1:n]
            t = max(1, i-win_sz);
            b = min(m, i+win_sz);
            l = max(1, j-win_sz);
            r = min(n, j+win_sz);
            Ix = imx(t:b, l:r);
            Iy = imy(t:b, l:r);
            tensor_mask = base_ten_mask(win_sz+1-(i-t): (b-i)+win_sz+1 , win_sz+1-(j-l): win_sz+1+(r-j));
            tensor_mask = tensor_mask / sum(tensor_mask, 'all');
            Ix2 = sum(((Ix.^2).*tensor_mask), "all");
            Iy2 = sum(((Iy.^2).*tensor_mask), "all");
            Ixy = sum(((Ix.*Iy).*tensor_mask), "all");
            tensor = [Ix2 Ixy; Ixy Iy2];
            eigen = eig(tensor);
            eigA(i,j) = eigen(1);
            eigB(i,j) = eigen(2);
            
            ret_img(i,j) = det(tensor) - k*(trace(tensor)).^2 ;
        end 
    end
    
    %ret_img = (ret_img - min(ret_img,[],'all'))/(max(ret_img,[],'all')-min(ret_img,[],'all'));
end

