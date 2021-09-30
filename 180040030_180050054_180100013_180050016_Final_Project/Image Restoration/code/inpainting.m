function [ret_img] = inpainting(img, mask, win_size ,time, iter, sigma)
    %INPAINTING Summary of this function goes here
    %   Detailed explanation goes here

    [m,n,c] = size(img);
    win_sz = int32((win_size - 1)/2) ;
    gauss_smooth = fspecial('gaussian',3 ,sigma);
    
    [xi, yi] = find(mask(:,:,1) > 0);
    
    grad_x = zeros(size(img));
    grad_y = zeros(size(img));
    [grad_x(:,:,1),grad_y(:,:,1)] = imgradientxy(img(:,:,1)) ;
    [grad_x(:,:,2),grad_y(:,:,2)] = imgradientxy(img(:,:,2)) ;
    [grad_x(:,:,3),grad_y(:,:,3)] = imgradientxy(img(:,:,3)) ;
    
    ret_img = img;
    for lo=[1:iter]
        for ind=[1:length(xi)]
            i = xi(ind);  j = yi(ind); 
            
            t = max(1, i-win_sz);
            b = min(m, i+win_sz);
            l = max(1, j-win_sz);
            r = min(n, j+win_sz);
            
            Ix = grad_x(i, j, :);
            Iy = grad_y(i, j, :);
            
            Ix2 = sum(Ix.^2, 'all');
            Iy2 = sum(Iy.^2, 'all');
            Ixy = sum(Ix.*Iy,'all');
            G_sigma = [Ix2 Ixy; Ixy Iy2];
            G_sigma = imfilter(G_sigma, gauss_smooth);
            [V,D] = eig(G_sigma);
            [D,perm] = sort(diag(D), 'descend') ;
            V = V(:, perm) ;
            one_s2 = D(1) + D(2) + 1; 
            T = 1/(sqrt(one_s2)).*V(:,2)*V(:,2)' + 1/(one_s2).* V(:,1)*V(:,1)'  ;
            
            GTt = zeros([b-t+1, r-l+1]);
            [m1,n1,~] = size(GTt);
            for i1=[1:m1]
                for j1=[1:n1]
                    pos = double([t-1+i1-i , l-1+j1-j]);
                    temp = pos*(T\(pos')) ;
                    GTt(i1,j1) = 1/4/pi/time .* exp(-temp/4/time ); % T\x is same as inv(T) * x  
                end
            end
            GTt = GTt/(sum(GTt,'all'));
            base = img(t:b,l:r,:) ;
            temp1 = conv2(base(:,:,1), GTt,'same');
            ret_img(i,j,1) = temp1(i-t+1, j-l+1) ;
            temp2 = conv2(base(:,:,2), GTt,'same');
            ret_img(i,j,2) = temp2(i-t+1, j-l+1) ;
            temp3 = conv2(base(:,:,3), GTt,'same');
            ret_img(i,j,3) = temp3(i-t+1, j-l+1) ; 
        end
        img = ret_img ;
        time = time - 0.5 ;
    end
end

