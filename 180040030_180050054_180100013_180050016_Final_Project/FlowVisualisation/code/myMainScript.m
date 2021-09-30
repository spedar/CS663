
im1 = imread('man.png');
im2 = imread('bird.jpg');
im3 = imread('spiral.jpg');

[out1,out2] = flowViewer(im1,100);
figure, imshow(im1), title("Original Image");
figure, imshow(out1), title("Image Under Flow 1");
figure, imshow(out2), title("Image Under Flow 2"); 

[out1,out2] = flowViewer(im2,75);
figure, imshow(im2), title("Original Image");
figure, imshow(out1), title("Image Under Flow 1");
figure, imshow(out2), title("Image Under Flow 2");

[out1,out2] = flowViewer(im3,50);
figure, imshow(im3), title("Original Image");
figure, imshow(out1), title("Image Under Flow 1");
figure, imshow(out2), title("Image Under Flow 2");