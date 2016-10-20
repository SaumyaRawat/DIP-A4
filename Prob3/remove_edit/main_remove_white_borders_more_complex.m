%% ########################################################################
% ################### retrieve the image filename ######################
% ========================================================================
% This section retrieves all the file name in the image dataset folder
% ########################################################################
clc
close all
clear all

image_dataset_dir = './files_to_remove_white_border';
% image_dataset_dir = './more_difficult';
addpath(image_dataset_dir);
% -------- list all the files in the image dataset directory -------
fileList = fn_getAllFiles(image_dataset_dir);
image_list = cell(length(fileList),2); % first column: imageID, second column: img extenstion
image_cnt = 1;
for i = 1:length(fileList)
    [pathstr, name, ext] = fileparts(fileList{i});
    % User can add the list of valid image extension below:
    if strcmp(ext,'.jpg') || strcmp(ext,'.bmp') %|| strcmp(ext,'.eps') || strcmp(ext,'.gif')
        image_list{image_cnt,1} = name;
        image_list{image_cnt,2} = ext;
        image_cnt = image_cnt + 1;
    end
end
image_list = image_list(1:image_cnt-1,:);

% bigger epsilon --> more image islands produced
% epsilon = 1e-4; % recommended for gray-scale image with > 80% white pixel
% in the frame
% epsilon = 1e-2; % recommended for color image
% So, if the image still contains some white border --> increase the
% epsilon. If the image gets chopped too small --> decrease the epsilon

for i = 1:size(image_list,1)
    imagename = image_list{i,1};
    imageext = image_list{i,2};
    
    
%     % ==== Smart option: pick only the biggest block of the image ====
%     fn_remove_white_border(imagename,imageext); % Using smart option
    
    
    
%     % ==== Smart option with help from user to define epsilon ====
%     % epsilon = 1e-4; % for gray-scale image with 90% white
%     epsilon = 1e-1; % for color image
%     fn_remove_white_border(imagename,imageext, epsilon); % Using smart option
    
    fn_remove_white_border(imagename,imageext, []); % Using smart option, the epsilon is suggested by the program
    
%     fn_remove_white_border(imagename,imageext, [], 0,0); % Using smart option, the epsilon is suggested by the program
    
%     % ==== remove only the outer-most white border ====
%     % epsilon = 1e-4; % for gray-scale image with 90% white
%     epsilon = 1e-2; % for color image
%     fn_remove_white_border(imagename,imageext, epsilon, 0, 0); % remove only the outer-most white border
    
    
%     % ==== user-defined parameters ====
%     epsilon = 1e-5; % bigger epsilon --> more island
%     island_coor_row = 1; % row
%     island_coor_col = 1; % col
%     fn_remove_white_border(imagename,imageext, epsilon, island_coor_row, island_coor_col);
    
end

