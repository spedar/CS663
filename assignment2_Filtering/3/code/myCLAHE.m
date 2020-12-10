function ret_img = myCLAHE(im, win_sz, threshold)
    % MYCLAHE Summary of this function is below. This function is written by Deep Satra For God's sake do not copy this. 
    %  im is image, win_sz is window size
    %  threshold is parameter to decide noise and contrast
    %  
    % wr is right and bottom half of window 
    % Similarly wl is top and left half
    wr = floor((win_sz-1)/2) ;
    wl = ceil ((win_sz-1)/2) ;
    [m,n,c] = size(im);
    ret_img = zeros([m,n,c], 'uint8');
    base_hist = zeros([c,256]);
    
    % find base histogram. Here rows and colums will keep on adding and
    % subtracting instead of finding whole kxk histogram
    for chanl=[1:c]
        for ii= [1:min(m, 1+wr)]
            for jj= [1: min(n, 1+wr)]
                base_hist(chanl, im(ii, jj, chanl)+1) = base_hist(chanl, im(ii, jj, chanl)+1) + 1 ;
            end
        end
    end
    
    cdf = zeros([1,256]);
    clahe_base_hist = zeros([1,256]); 
    for chnl = [1:c]
        for ii = [1:m]
            for jj=[1:n]
                clahe_base_hist(1,:) = base_hist(chnl,:) ;
                tem = max(clahe_base_hist) * threshold ;
                % spread is area above threshold that need to be
                % distributed evenly
                spread = sum(clahe_base_hist(clahe_base_hist>=tem)) ;
                % remove above threshold
                clahe_base_hist(clahe_base_hist>=tem) = tem ;
                % spread evenly
                clahe_base_hist = clahe_base_hist + ones(1,256) .* floor(spread/256) ;
                % find histogram percent
                clahe_base_hist = clahe_base_hist / sum(clahe_base_hist) ;
                cdf(1,:) = cumsum(clahe_base_hist(1,:)) .* 255 ;
                ret_img(ii,jj,chnl) = floor(cdf(1, im(ii,jj,chnl)+1));
                % following are conditions that check if row/ columns need
                % to be added
                
                % remove left column?
                if ii-wl >= 1
                    for rem = [max(1, jj-wl), min(n, jj + wr)]
                       base_hist(chnl, im(ii-wl, rem, chnl) + 1 ) = base_hist(chnl, im(ii-wl, rem, chnl) + 1 ) - 1 ;
                    end    
                end
                % add right column?
                if ii+wr <= m
                    for rem = [max(1, jj-wl), min(n, jj + wr)]
                       base_hist(chnl, im(ii+wr, rem, chnl) + 1 ) = base_hist(chnl, im(ii+wr, rem, chnl) + 1 ) + 1 ;
                    end
                end   
                % remove top row?
                if jj-wl >= 1
                    for rem = [max(1, ii-wl), min(m, ii + wr)]
                       base_hist(chnl, im(rem, jj-wl, chnl) + 1 ) = base_hist(chnl, im(rem, jj-wl, chnl) + 1 ) - 1 ;
                    end
                end 
                % add bottom row?
                if jj+wr <= n
                    for rem = [max(1, ii-wl), min(m, ii + wr)]
                       base_hist(chnl, im(rem, jj+wr, chnl) + 1 ) = base_hist(chnl, im(rem, jj+wr, chnl) + 1 ) + 1 ;
                    end
                end  
            end    
        end    
    end    
    
end

