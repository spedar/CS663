function [ ] = reconstruction(im,k_val, num)
    %RECONSTRUCTION by Deep Satra
    %   im is string of desired image. k_val vector of k values and num is
    %   desired number of plots of eigenfaces.
    X = [];
    path = '../../ORL/s' ;
    for j=[1:40]
        for i=[1:10]
            x = imread(path+string(j)+'/'+string(i)+'.pgm') ;
            X = [X reshape(x,[],1)];
        end 
    end
    [m,n, ~] = size(x);
    X_bar = mean(X,2);
    X = double(X) - X_bar ;       % deducting mean
    L = (X'*X)/399 ;              % L is a nxn matrix
    [W, D] = eig(L) ;             % W is eigenvector matrix and D is diagonal matrix
    [~, ind] = sort(diag(D));     % currently ascending order
    D = D(ind,ind);
    V = X*W ;                     % dxn
    V = V(:, ind);
    V = V./sqrt((sum(V.^2))) ;    % Normalize

    figure;
    for i = 1:15
        Y = reshape(V(:, 401-i), m, n);
        subplot(3, 5, i);
        imshow(mat2gray(Y));
        label = 'k= '+ string(i);
        title(label);
    end
    
    figure;
    for i = [1:num-15]
        Y = reshape(V(:, 401-i-15), m, n);
        subplot(2, 5, i);
        imshow(mat2gray(Y));
        label = 'k= '+ string(i+15);
        title(label);
    end
    
    
    targ = imread('../../ORL/'+string(im)) ;
    
    for l=[1:length(k_val)]
        coeff = V' * (double(targ(:))- X_bar) ;
        recon = reshape(V(:,400-k_val(l)+1:400)*coeff(400-k_val(l)+1:400) + X_bar, m, n) ;
        figure;
        my_show(recon);
        title('reconstructions using k='+string(k_val(l)));
    end 
    
end

