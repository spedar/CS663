%% MyMainScript

%% Your code here
tic;
path = '../data/boat.mat';
im = load(path).imageOrig ;
im = (im - min(im,[],"all"))/(max(im,[],'all')-min(im,[],"all"));
%figure, my_show(im); title('boat');

[eigA, eigB, cornerness] = myHarrisCornerDetector(im, 3, 0.2, 0.7, 0.244);      

figure, my_show(eigA); title('eigen A');
figure, my_show(eigB); title('eigen B');
figure, my_show(cornerness); title('corner-ness');
cornerness(cornerness<0.5)=0 ;

[y,x] = find( cornerness > 0) ;
figure, my_show(im); title('corner-ness marked'); hold on;
plot(x,y,'r+', 'MarkerSize', 8, 'LineWidth', 2 );

toc;
%%
