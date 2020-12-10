function [ret_img, weight, out_wt] = myPatchBasedFiltering(im, window_size, patch_size,sigma, h, wi, wj)
    %MYPATCHBASEDFILTERING Summary of this function goes here
    %   This code is written by Deep Satra 
    %   sigma is to make patches isotropic and h is deviation for kernel
    %   to probe how the weights are initialised at patterns, wi and wj are
    %   coordinates. Correspondingly out_wt is returned.
    %
    [m,n,c] = size(im);
    m = int32(m); n = int32(n); c = int32(c);
    ret_img = zeros([m,n,c]);
    win_sz = int32((window_size-1)/2);
    patch_sz = int32((patch_size-1)/2);
    
    % weight is the mask of ideal size patch_size
    weight = [1:patch_size];
    weight = weight - weight(patch_sz+1);
    weight = weight.^2 ;
    weight = -double((weight' + weight))/sigma; 
    weight = exp(weight);
    weight(patch_sz+1, patch_sz+1) = 0;
    weight = weight/sum(weight,"all");
    
    for ch= [1:c]
        for i= [1:m]
            for j= [1:n]
                % to find intensity at pixel location I find base patch
                % dimension below
                xl = min(patch_sz, j-1);
                xr = min(patch_sz, n-j);
                yt = min(patch_sz, i-1);
                yb = min(patch_sz, m-i);
                
                % Below I find window dimensions around pixel
                win_top = max(1,i-win_sz) ;
                win_bottom = min(m, i+win_sz);
                win_right =  min(n, j+win_sz);
                win_left= max(1,j-win_sz) ;
                
                % pixie is pixel intensities matrix around window
                % pix_w is matrix of pixel weight in window
                pixie = zeros([(win_bottom - win_top + 1), (win_right - win_left + 1)]);
                pix_w = 99999*ones([(win_bottom - win_top + 1), (win_right - win_left + 1)]);
                
                mask = weight(patch_sz+1-yt : patch_sz+1+yb, patch_sz+1-xl : patch_sz+1+xr);
                % base is base patch 
                base = im(i-yt: i+yb, j-xl:j+xr, ch);
                for qy=[win_top:win_bottom]
                    for qx=[win_left:win_right]
                        if (qy==i)&&(qx==j)
                            continue
                        end
                        % below I find for pixels in window, the bounds of
                        % patch size
                        top = max(qy-yt, win_top);
                        bottom = min(qy+yb, win_bottom);
                        left = max(qx-xl, win_left );
                        right= min(qx+xr, win_right);
                        if (top==qy-yt)&&(bottom==qy+yb)&&(left==qx-xl)&&(right==qx+xr)
                            targ = im(top:bottom, left:right, ch);
                            pix_w(qy-win_top+1, qx-win_left+1)= sum(((targ-base).^2).*mask, 'all');
                            pixie(qy-win_top+1, qx-win_left+1)= im(qy,qx,ch);
                        end 
                    end 
                end
                %div = max(pix_w,[],'all');
                % I had tried to automize such that parameter h^2 is some
                % linear function of max of pixel intensity in window
                pix_w = exp(-pix_w/h/h);
                sum_pix_w = sum(pix_w, 'all');
                pix_w = pix_w/sum_pix_w ;
                ret_img(i,j,ch) = sum(pix_w.*pixie, 'all');
                % return the probed weight matrix
                if (i==wi)&&(j==wj)
                    out_wt = pix_w ;
                end
                if isnan(ret_img(i,j,ch))
                    ret_img(i,j,ch) = im(i,j,ch);
                end    
            end
        end    
    end     

end

