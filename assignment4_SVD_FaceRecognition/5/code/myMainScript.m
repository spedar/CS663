%% MyMainScript


%% Your code here
% put the path to ORL folder with desired image number at end as shown, as argument
% to function. Also there is k_val which is the vector of k values used for 
% reconstructin. Also next argument is number of eigenfaces.
% Here top 90 eigenvectors are taken and threhold is set to 6e6
tic;

path = '../../ORL/s17/5.pgm';
im = imread(path) ;
figure, my_show(im); title('original face');

k_val = [2,10,20,50,75,100,125,150,175,200];
reconstruction('s17/5.pgm', k_val, 25);
toc;
%%

