addpath('input');
addpath('functions');

%% Read the images  %%
Images = dir('input/*.pfm');
filename = ['input/',Images(1).name];
I=getpfmraw(filename);

%% Linear Mapping %%
linear_output = linear_mapping(I);
str=sprintf('%s_linear.bmp', filename);
imwrite(I,str)
figure;imshowpair(I,linear_output,'montage');title('Linear Mapped Image');

%% Reinhard's Tone Mapping ' %%
key = 0.18;
reinhard_output = reinhard_mapping(I,key);
str=sprintf('%s_%d_X.bmp', filename, key);
imwrite(I,str)
figure;imshowpair(I,linear_output,'montage');title('Reinhards Tone Mapped Image');
