%% Find maximum square patch of non cloud image %%
clear; tic;
imrgb= imread('cloud3.jpg');
% binarize image
im = im2bw(rgb2gray(imrgb));    
% create a distance matrix that measures the distance between each pixel and its nearest cloud pixel 
acc_matrix = imdist(im);
max_index = max(acc_matrix(:));
% find the (i,j) index corresponding to the point farthest away from a cloud
[i,j] = ind2sub(size(im),find(acc_matrix==max_index));
% mark the square area according to this pixel and the total length of the area
imrgb(round(i-max_index+1:i),round(j-max_index+1:j),1) = 0;
imrgb(round(i-max_index+1:i),round(j-max_index+1:j),2) = 255;
imrgb(round(i-max_index+1:i),round(j-max_index+1:j),3) = 255;
figure;imshow(imrgb);
imwrite(imrgb,'result3.jpg')
toc;