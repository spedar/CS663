function [Us,S,Vs] = MySVD(A)

    [m,n] = size(A);
    
    if(m>=n)
        [U1,S1,V1] = svd(A);
        prod = U1*S1*V1';
%         disp(prod);

        A;

        left = A*A';
        [U,D] = eig(left);
        [d,ind] = sort(diag(D), 'descend');
        Ds = D(ind,ind);
        Us = U(:,ind);

    %     right = A'*A;
    %     [V,D] = eig(right);
    %     [d,ind] = sort(diag(D), 'descend');
    %     Ds = D(ind,ind)
    %     Vs = V(:,ind)
    
        Vs = A'* Us;
        Vs = Vs ./ (sum(Vs.^2,1).^0.5);
        S = real(Ds.^0.5);
        S = S(1:m, 1:n);
        Vs = Vs(1:n,1:n);

%         mysvd = Us* S *Vs';
%         disp(mysvd);
    
    else
        [Vs,S,Us] = MySVD(A');
        S = S';
%         Vs = Vs(1:n,1:n);
%         S = S(1:m, 1:n);
        
    end
    
%     Us; 
%     S;
%     Vs;
%     mysvd = Us* S *Vs';
%     disp(mysvd);
end

