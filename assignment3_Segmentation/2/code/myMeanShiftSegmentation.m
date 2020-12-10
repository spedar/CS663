function [B] = myMeanShiftSegmentation(I,d,hs,hr,lr,it,k,K)
%     I = imread(image);
    
%     Gaussian convolution
%     g = fspecial('gaussian', 9, 1);
%     J = imfilter(I, g);
%     
%     % sub-sampling by factor 4
%     [m,n,~] = size(I);
% %     d=2;
%     
%     K = zeros(floor(m/d), floor(n/d), 5);
%     for i = 1:m/d
%         for j = 1:n/d
%             for z = 1:3
%                 K(i,j,z) = J(i*d,j*d,z);
%             end
%             
%                 K(i,j,4) = i;
%                 K(i,j,5) = j;
%         end
%     end
%     
%     A = K;
    
%     imshow(mat2gray(K));
%     I = rgb2xyz(I);
%     cform = makecform('xyz2uvl');
%     I = applycform(I, cform);
%     imshow(K);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     hs = 12;
%     hr = 12;
%     lr = 300;
    
    [m,n,l] = size(K);
%     K = reshape(K, [m*n, l]);
    L = K;
    K(1,1,:);
    win = 12;
%     imshow(mat2gray(K(:,:,1:3)));
    
    for iter = 1:it
        for i = 1:m
            for j = 1:n
%                 if rem(i,100)==0 
%                     disp(i);
%                 end
                left = max(i-win,1);
                right = min(i+win,m);
                top = max(j-win,1);
                bot = min(j+win,n);
                
                K(i,j,:);
%                 idx = knnsearch(K, K(i,:), 'K', 30);
                x = K(i,j,:);
%                 x_i = K(left:right, top:bot, :);
                x_i = K;
%                 x_i = K(idx,:);

                x_spatial = x_i(:,:, 4:end);
                x_rgb = x_i(:, :, 1:3);

                x_spatial_d = (x_spatial - x(4:end))/ hs;
                x_rgb_d = (x_rgb - x(1:3)) / hr;

%                 dist_spat = vecnorm(x_spatial,2,3);
%                 dist_rgb = vecnorm(x_rgb,2,3);
% 
%                 weights_spat = exp(-(dist_spat.^2));
%                 weights_rgb = exp(-(dist_rgb.^2));

                dist_spat = sum(x_spatial_d .* x_spatial_d ,3);
                dist_rgb = sum(x_rgb_d .* x_rgb_d , 3);
                
                weights_spat = exp(-dist_spat);
                weights_rgb = exp(-dist_rgb);

                weights_final = weights_spat .* weights_rgb;

                denom = sum(sum(weights_final));
                num_rgb = sum(sum(x_rgb .* weights_final));
                num_spatial = sum(sum(x_spatial .* weights_final));
                
                update_rgb = (2 / (hr*hr)) * ((num_rgb / denom) - x(1:3));
                update_spatial = (2 / (hs*hs)) * ((num_spatial / denom) - x(4:end));
                
%                 num = sum(x_i .* weights_final);
                L(i,j,1:3) = K(i,j,1:3) + lr*update_rgb;
                L(i,j, 4:end) = K(i,j,4:end) + lr*update_spatial;

%                 L(i,:) = num ./ denom;
                
            end
        end

            K = L;
            K(1,1,:);
            
            L(1,1,:);
            disp(iter);
            
    end
    
%     M = ;
    figure;
    Z = K(:,:,1:3);
    imshow(mat2gray(Z));
    
%     k = 15;
%     M = K(:,:,1:3);
%     [m,n,l] = size(M);
%     M = reshape(M, [m*n, l]);
%     [idx, C] = kmeans(M, k);
%     idx = reshape(idx, [m,n,1]);
%     M = reshape(M, [m,n,l]);

    K1 = K;
    for i = 1:m
        for j = 1:n
            K1(i,j,4) = i;
            K1(i,j,5) = j;
        end
    end

%     k = 15;
    M = K1;
    [m,n,l] = size(M);
    M = reshape(M, [m*n, l]);
    [idx, C] = kmeans(M, k);
%     idx = idx(:,1:3);
    idx = reshape(idx, [m,n,1]);
    M = M(:,1:3);
    M = reshape(M, [m,n,3]);
    
%     color_map = zeros(k,3) -1;
    final = M;
    
    for i = 1:m
        for j = 1:n
%             if color_map(idx(i,j), 1) == -1
%                 color_map(idx(i,j),:) = M(i,j,:);
%             end
            
            final(i,j,:) = C(idx(i,j), 1:3);
                
        end
    end
    
    final1 = final;
    
    for iter = 1:5
        for i = 1:m
            for j = 1:n
    %             left = max(i-1,1);
    %             right = min(i+1,m);
    %             top = max(j-1,1);
    %             bot = min(j+1,n);
                if final(max(i-1,1),j,:) == final(min(i+1,m),j,:) 
                    if (final(i,max(j-1,1),:) == final(i,min(j+1,n),:))
                        final1(i,j,:) = final(max(i-1,1),j,:);
                    end
                end
            end
        end
    end
    
%     imshow(mat2gray(final1));
    
    final2 = final1;
    
    for iter = 1:5
        for i = 2:m-1
            for j = 2:n-1
                
                window = final1(i-1:i+1, j-1:j+1,:);
                inten = reshape(window, [9,3]);
                
                if i==2 && j==2
                    disp(inten);
                end
%                 inten(5) = [];
                
                for ind = 1:9
                    y(ind) = sum(sum(inten == inten(ind,:)))/3;
                    
                    if( y(ind) >= 7)
                        final2(i,j,:) = inten(ind,:);
                        final2(i-1,j-1,:) = inten(ind,:);
                        final2(i-1,j,:) = inten(ind,:);
                        final2(i-1,j+1,:) = inten(ind,:);
                        final2(i,j-1,:) = inten(ind,:);
                        final2(i,j+1,:) = inten(ind,:);
                        final2(i+1,j-1,:) = inten(ind,:);
                        final2(i+1,j,:) = inten(ind,:);
                        final2(i+1,j+1,:) = inten(ind,:);
                        break;
                    end
                end
                
            end
        end
    end
    
%     imshow(mat2gray(final2));
    k;
    
    B = final2;
end

    
    
    
    
    
    
    
    
    