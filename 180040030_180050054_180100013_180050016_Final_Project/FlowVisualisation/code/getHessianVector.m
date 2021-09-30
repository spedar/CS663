function [H] = getHessianVector(im)
    [fx,fy]=imgradientxy(im);
    [fxx,fxy]=imgradientxy(fx);
    [fyx,fyy]=imgradientxy(fy);
    H = cat(3,fxx,fxy,fyx,fyy);
end