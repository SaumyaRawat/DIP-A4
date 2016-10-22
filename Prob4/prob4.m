
%% Read the images  %%
Images = dir('images/*.jpg');
filename = ['images/',Images(1).name];
I = im2double(imread(filename));

%% Trial 1 using global adaptive thresholding
output1 = iteration1(I);

%% Trial 2 using this paper on local adaptive thresholding : http://staffhome.ecm.uwa.edu.au/~00082689/papers/Shafait-efficient-binarization-SPIE08.pdf
output2 = lat_thresh(I,90,90);

figure;
imshowpair(output1, output2, 'montage')
title('Adaptive thresholding vs Local Adaptive thresholding')