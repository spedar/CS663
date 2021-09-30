function [out] = updateImage(im,T,H)
    %calculates trace of TH and mulriplies it by some learning rate, adding
    %the output to the original image
    out = im;
    out = out + 0.01.*(T(:,:,1).*H(:,:,1) + T(:,:,2).*H(:,:,3) + T(:,:,3).*H(:,:,2) + T(:,:,4).*H(:,:,4)) ;
end