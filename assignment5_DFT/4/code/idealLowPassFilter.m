function [ret_img,H] = idealLowPassFilter(img,D)
    %IDEALLOWPASSFILTER Summary of this function goes here
    %   img, D are given
    
    [m,n,c] = size(img);
    H = zeros([m + 2*D, n + 2*D]);
    for i=[1:m + 2*D]
        for j=[1:n + 2*D]
            if((i - D - m/2)^2 + (j - D- n/2)^2 <= D^2)
                H(i,j) = 1 ;
            end 
        end 
    end 
    
    im = padarray(img, [D,D]);
    F_img = fftshift(fft2(im));
    F_ret = F_img .* H ;
    ret_img = abs(ifft2(ifftshift(F_ret)));
    ret_img = ret_img(D+1:m+D,D+1:n+D);
    H = log(abs(H) + 1);
        
end

