%% ########################################################################
% ################### retrieve the image filename ######################
% ========================================================================
% This section retrieves all the file name in the image dataset folder
% ########################################################################
clc
close all

epsilon = 1e-3;

% image_dataset_dir = './files_to_remove_white_border';
image_dataset_dir = './more_difficult';
addpath(image_dataset_dir);
% -------- list all the files in the image dataset directory -------
fileList = fn_getAllFiles(image_dataset_dir);
image_list = cell(length(fileList),2); % first column: imageID, second column: img extenstion
image_cnt = 1;
for i = 1:length(fileList)
    [pathstr, name, ext] = fileparts(fileList{i});
    % User can add the list of valid image extension below:
    if strcmp(ext,'.jpg') || strcmp(ext,'.bmp')
        image_list{image_cnt,1} = name;
        image_list{image_cnt,2} = ext;
        image_cnt = image_cnt + 1;
    end
end
image_list = image_list(1:image_cnt-1,:);

for i = 1%1:size(image_list,1)
    imagename = image_list{i,1};
    imageext = image_list{i,2};
    
    % import an image
img_org = imread([imagename,imageext]);
Ncol = size(img_org,2);
Nrow = size(img_org,1);

img_RGB = double(img_org); % converted to double precision

% Gray scale feature
img_gray = rgb2gray(img_org)/255;

row_marg = mean(img_gray,2);
col_marg = mean(img_gray,1);

% figure; plot(row_marg); % for test
% figure; plot(col_marg); % for test

row_marg_quant = 1 - row_marg;
row_marg_quant(row_marg_quant < epsilon) = 0;
row_marg_quant(row_marg_quant >= epsilon) = 1;
% figure; plot(row_marg_quant); % for test

col_marg_quant = 1 - col_marg;
col_marg_quant(col_marg_quant < epsilon) = 0;
col_marg_quant(col_marg_quant >= epsilon) = 1;
% figure; plot(col_marg_quant); % for test

% image_region = row_marg_quant*col_marg_quant;
% figure; imagesc(image_region); % for test

% ==== determine the boundary ====
nonwhite_bound_up = min(find(row_marg_quant ~= 0));
nonwhite_bound_down = max(find(row_marg_quant ~= 0));
nonwhite_bound_left = min(find(col_marg_quant ~= 0));
nonwhite_bound_right = max(find(col_marg_quant ~= 0));

img_cropped = img_org(nonwhite_bound_up:nonwhite_bound_down, nonwhite_bound_left:nonwhite_bound_right, :);

imwrite(img_cropped,[imagename,'_cropped'],imageext(2:end));

end

