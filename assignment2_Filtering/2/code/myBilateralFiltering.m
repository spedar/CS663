
function ret_img = myBilateralFiltering(im, sig_space, sig_int)
    [m,n,~] = size(im);
    ret_img = zeros([m,n]);
    %Neighbourhood size? what is optimal window?
    win = 2*ceil(2*sig_space)+1;
    %%CREATE WINDOW GRID SPATIAL:
    [a,b]=meshgrid(-win:win,-win:win);
    spaceGauss = exp(-(a.^2+b.^2)/(2*sig_space^2));%Non-normalised
    %%Normalisation constant absorbed in the bilateral filter Wp
    for i=[1:m]
        for j=[1:n]
            %Find relevant patch:
            left = max(i-win,1);
            right = min(i+win,m);
            top = max(j-win,1);
            bott = min(j+win,n);
            %Either partial or full window
            patch = im(left:right,top:bott);
            %No meshgrid required, (also non_normalised), intensity subtraction will do:
            intGauss = exp(-(patch-im(i,j)).^2/(2*sig_int^2));
            %Elementwise multiply both
            conv = intGauss.*spaceGauss((left:right)-i+1+win,(top:bott)-j+1+win);
            %normalised sum:
            ret_img(i,j)= sum(conv(:).*patch(:));
            ret_img(i,j)= ret_img(i,j)/sum(conv(:));
        end 
    end
end