function rmsd = myRMSD1(A,B)
    dim = size(A);
    sum = 0;
    for i = [1:dim(1)]
        for j = [1:dim(2)]
            sum = sum + (double(A(i,j))*2.55-double(B(i,j))*255)^2;
        end
    end
    sum = sum/(dim(1)*dim(2));
    rmsd = sqrt(sum);
end