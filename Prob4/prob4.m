
%% Read the images  %%
Images = dir('images/*.jpg');
filename = ['images/',Images(1).name];
I = im2double(imread(filename));

%% Trial 1 using global adaptive thresholding
output1 = iteration1(I);

%% Trial 2 using local adaptive thresholding
[output2] = iteration2(I);

%% Trial 3 using this paper on local adaptive thresholding : http://staffhome.ecm.uwa.edu.au/~00082689/papers/Shafait-efficient-binarization-SPIE08.pdf
output3 = lat_thresh(I,90,90);

figure;
subplot(1,3,1)
imshow(output1)
title('Global thresholding')

subplot(1,3,2)
imshow(output2)
title('Local Adaptive thresholding')


subplot(1,3,3)
imshow(output3)
title('LAT Using Shafait-efficient-binarization-SPIE08')