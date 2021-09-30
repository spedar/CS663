function [denoised_image] = image_denoising(input,win, num_iter,t)

    I = imread(input);
    [m,n,c] = size(I) ;
    J = zeros(m+2*win-2, n+2*win-2, c);
    J(win: win+m-1, win: win+n-1, :) = I;
%     I = J;

    for iter=1:num_iter
        
        y_gradient = zeros(m,n,c); 
        x_gradient = zeros(m,n,c);
        
        for i = 1:3
            [x_gradient(:,:,4-i), y_gradient(:,:,4-i)] = imgradientxy(I(:,:,4-i)) ;
        end
            
        for i=win+1:m-win    
            for j=win+1:n-win
         
                G_struct = zeros(2,2,3);
                
                for k = 1:3
                    I_gradient = [x_gradient(i,j,k); y_gradient(i,j,k)];
                    G_struct(:,:,k) = I_gradient * I_gradient';
                end
                
                G = sum(G_struct,3);
                
                gaussian_filter = fspecial('gaussian',5,1);
                G_final = imfilter(G,gaussian_filter);
            
                [U,D] = eig(G_final);
                [d,indices] = sort(diag(D), 'descend') ;
                Ds = D(indices, indices);
                theta = U(:, indices);
                
                lambda_plus = d(2) ;
                lambda_minus = d(1) ;
                
                s = sqrt(lambda_plus+lambda_minus);
                f_plus = 1/ (1 + s^2);
                f_minus = 1/ sqrt(1 + s^2);
                
                theta_plus = theta(:,1);
                theta_minus = theta(:,2);
                
                T_plus = f_plus * (theta_plus * theta_plus');
                T_minus = f_minus * (theta_minus * theta_minus');
                T = T_plus + T_minus;
%                 H1 = getHessianVector(I(:,:,1));
%                 H2 = getHessianVector(I(:,:,2));
%                 H3 = getHessianVector(I(:,:,3));
                
                T_inv = inv(T) ;
            
                [x,y] = meshgrid(-win:win,-win:win);
                x_vec = [x,y];
                x_vec_t = [x,y]';
                t11 = (x*T(1,1)).*x;
                t22 = (y*T(2,2)).*y; 
                t21 = (y*T(2,1)).*x;
                t12 = (x*T(1,2)).*y;
    
                gauss = exp(-(t11+t22+t12+t21) / (4*t));
                norm_factor = 1/ sum(gauss(:));
                gauss_norm = norm_factor*gauss;
                
                conv_window = I(i-win:i+win,j-win:j+win,:);
                conv2_win = zeros(2*win+1, 2*win+1,3);
                
                conv2_win(:,:,3) = conv2(conv_window(:,:,3), gauss_norm, 'same');
                I(i,j,3) =  conv2_win(1+win,1+win,3);
                conv2_win(:,:,2) = conv2(conv_window(:,:,2), gauss_norm, 'same');
                I(i,j,2) =  conv2_win(1+win,1+win,2);
                conv2_win(:,:,1) = conv2(conv_window(:,:,1), gauss_norm, 'same');
                I(i,j,1) =  conv2_win(1+win,1+win,1);
             
            end
        end
        
%         I = I(win: win+m-1, win: win+n-1, :);
        denoised_image = I;

    end 
end
