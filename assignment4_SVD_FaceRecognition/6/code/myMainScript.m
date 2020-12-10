%% MyMainScript


%% Your code here
% put the path to ORL folder with 's' char at end, as argument to function. Also there is k, and threshold.
% Here top 90 eigenvectors are taken and threhold is set to 6e6
tic;
path = '../../ORL/s' ;
face_recog(path, 90, 6e6);

toc;
