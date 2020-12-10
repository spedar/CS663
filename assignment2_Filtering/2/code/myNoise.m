function ret_img = myNoise(I)
    rng(25);
    %I = imread(im);
    n = size(I);
    n = n(1);
    %disp(n);
    low = min(min(I));
    high = max(max(I));
    %disp(low);
    %disp(high);
    sig = 0.05*(high-low);
    %disp(sig);
    noise = double(randn(n));
    noise = noise.*double(sig);
    ret_img = mat2gray(double(I) + noise);
    %ret_img = imnoise(im,'gaussian',0.001);
end