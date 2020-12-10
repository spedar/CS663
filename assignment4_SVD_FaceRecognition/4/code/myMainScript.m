%% MyMainScript

tic;
%% Your code here
clc; clear;
path1 = "../data/ORL";
path2 = "../data/CroppedYale";

%%

figure;
faceRecog(path1);
title('ORL - Variation of accuracy with k using svd');
xlabel('k');
ylabel('accuracy');

%%

figure;
faceRecog1(path1);
title('ORL - Variation of accuracy with k using eig');
xlabel('k');
ylabel('accuracy');

%%
figure;
faceRecog_yale(path2, 'a');
title('Yale - Variation of accuracy with k');
xlabel('k');
ylabel('accuracy');

%%
figure;
faceRecog_yale(path2, 'b');
title('Yale - Variation of accuracy with k');
xlabel('k');
ylabel('accuracy');
toc;
