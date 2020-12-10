function [ ] = face_recog(path, K, threshold)
    %FACE_RECOG by Deep Satra
    % path is destination to dataset. K is number of top eigenvalues taken.
    % threshold is for determining if person is in dataset.
    
    X = [];        % will contain unrlled train dataset
    cnt = 0;
    for j=[1:32]
        for i=[1:6]
            x = imread(path+string(j)+'/'+string(i)+'.pgm') ;
            X = [X reshape(x,[],1)];
            cnt = cnt + 1;
        end 
    end
    [m,n, ~] = size(x);
    X_bar = mean(X,2);                % mean of train dataset
    X = double(X) - X_bar ;           % deducting mean
    L = (X'*X)/(cnt-1) ;              % L is a nxn matrix
    [W, D] = eig(L) ;                 % W is eigenvector matrix and D is diagonal matrix
    [~, ind] = sort(diag(D), "descend");
    D = D(ind,ind);                   % sorted in descending order
    V = X*W ;                         % dxn
    V = V(:, ind);
    V = V./sqrt((sum(V.^2))) ;        % Normalize. 
    V = V(:,1:K);                     % This is the eigenspace
    
    train_coef = [];
    for j=[1:32]
        for i=[1:6]
            targ = imread(path+string(j)+'/'+string(i)+'.pgm') ;
            train_coef = [train_coef, V'*(double(targ(:))-X_bar) ];
        end 
    end    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                TEST TIME                    %
    
    out_of = 0 ;
    false_negative = 0 ;
    false_positive = 0 ;
    for j=[1:40]
        for i=[1:10]
            if ((j<=32) && (i<=6)) || ((j>32) && (i<=6))
                continue ;
            end 
            out_of = out_of + 1;
            targ = imread(path+string(j)+'/'+string(i)+'.pgm') ;
            test_coef =  V'*(double(targ(:)) - X_bar) ;     % find eigen coefficients
            diff = min(sum((train_coef-test_coef).^2)) ;
            %fprintf('%d %d %d  \n',j,i,diff);
            if (diff >= threshold) && (j<=32)
                false_negative = false_negative +1 ;
                continue ;
            end 
            if (diff < threshold) && (j>32)
                false_positive = false_positive + 1 ;
            end 
        end 
    end 
    
    fprintf('Using threshold %d and k = %d, false positive = %d and false negative = %d out of %d test images. ',threshold,K,false_positive,false_negative,out_of);
    
end

