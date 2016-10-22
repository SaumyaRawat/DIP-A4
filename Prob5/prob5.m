addpath('input');
addpath('functions');

%% Read the images  %%
Images = dir('input/*.pfm');
image_name = Images(5).name;
filename = ['input/',image_name];
output_filename = ['output/',image_name];
I=getpfmraw(filename);

%% Linear Mapping %%
linear_output = linear_mapping(I);
str=sprintf('%s_linear.bmp', output_filename);
imwrite(linear_output,str)
figure;imshowpair(I,linear_output,'montage');title('Linear Mapped Image');

%% Reinhard's Tone Mapping ' %%
key = 0.17;
reinhard_output = reinhard_mapping(I,key);
str=sprintf('%s_%d_X.bmp', output_filename, key);
imwrite(reinhard_output,str)
figure;imshowpair(I,reinhard_output,'montage');title('Reinhards Tone Mapped Image');

%% Reinhard's Dodge And Burn ' %%
key = 0.17;
dodge_and_burn_output = dodge_and_burn(I,key);
str=sprintf('%s_local.bmp', output_filename);
imwrite(dodge_and_burn_output,str)
figure;imshowpair(I,dodge_and_burn_output,'montage');title('Reinhards Dodge And Burn Image');
