addpath('input');
addpath('functions')

%% Read the images  %%
Images = dir('input/*.pfm');
filename = ['input/',Images(1).name];
I=getpfmraw(filename);

