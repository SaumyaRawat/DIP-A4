function [] = fn_remove_white_border(imagename,imageext, epsilon, island_coor_row, island_coor_col)

if nargin < 4
    smart_option = 'on';
else
    smart_option = 'off';
end

if nargin < 3
    epsilon = [];
end

% ============
fig_image_region = 6000;
% ============

% import an image
img_org = imread([imagename,imageext]);

% Gray scale feature
img_gray = double(rgb2gray(img_org))/255;
img_gray(img_gray > 0.93) = 1; % quantize the white pixels
% figure; imagesc(img_gray);

% --- if user does not know the epsilon
if isempty(epsilon)
    if  mean(img_gray(:)) > 0.7 % gray image with > 70% white
        epsilon = 1e-4;
    else
        epsilon = 1e-1;
    end
end


% add white border just to make sure that the image is surrounded by white
% border
N_added = 7;
img_gray = [ones(N_added, size(img_gray,2) ); img_gray; ones(N_added, size(img_gray,2) )];
img_gray = [ones(size(img_gray,1), N_added), img_gray, ones(size(img_gray,1), N_added)];

row_marg = mean(img_gray,2);
col_marg = mean(img_gray,1);

% figure; plot(row_marg); % for test
% figure; plot(col_marg); % for test

row_marg_quant = 1 - row_marg;
row_marg_quant(row_marg_quant < epsilon) = 0;
row_marg_quant(row_marg_quant >= epsilon) = 1;
% figure; plot(row_marg_quant); % for test
% title('row_marg_quant')

col_marg_quant = 1 - col_marg;
col_marg_quant(col_marg_quant < epsilon) = 0;
col_marg_quant(col_marg_quant >= epsilon) = 1;
% figure; plot(col_marg_quant); % for test
% title('col_marg_quant')

% ======= plot the island region ========
image_region = row_marg_quant*col_marg_quant;
% figure; imagesc(image_region); title('island'); % for test
mask = image_region((N_added+1):(end-N_added),(N_added+1):(end-N_added));
mask(mask==0) = 0.3;
% image_region = double(img_gray).* mask; % gray-scale
image_region = double(img_org)/255 .* repmat(mask,[1,1,3]); % color

figure(fig_image_region); imagesc(image_region); daspect([1 1 1]); % for test
% colormap gray
set(gca,'xtick',[]);
set(gca,'ytick',[]);

% ====== determine the island ======

% -- for the vertical ---
diff_row = diff(row_marg_quant);
edge_pixel = find(diff_row ~= 0);
edge = diff_row(edge_pixel,:);
% figure; plot(diff_row); title('differnce in row');

begin_edge_vertical = edge_pixel(edge==1)+1;
stop_edge_vertical = edge_pixel(edge==-1);

% -- for the horizontal ---
diff_col = diff(col_marg_quant);
edge_pixel = find(diff_col ~= 0);
edge = diff_col(:,edge_pixel);
% figure; plot(diff_col); title('differnce in column');

begin_edge_horizontal = edge_pixel(edge==1)+1;
stop_edge_horizontal = edge_pixel(edge==-1);

% ----- Smart option: find the biggest island ------
if strcmp(smart_option,'on')
    length_v = begin_edge_vertical - stop_edge_vertical;
    length_h = begin_edge_horizontal - stop_edge_horizontal;
    area_island = length_v(:)*length_h(:)';
    [v ind_max] = max(area_island(:));
    [island_coor_row  island_coor_col] = ind2sub(size(area_island),ind_max);
end

% ==== determine the boundary ====
if island_coor_row*island_coor_col == 0
    % -- remove only the outer most white border
    nonwhite_bound_up = begin_edge_vertical(1)-N_added;
    nonwhite_bound_down = stop_edge_vertical(end)-N_added;
    nonwhite_bound_left = begin_edge_horizontal(1)-N_added;
    nonwhite_bound_right = stop_edge_horizontal(end)-N_added;
else
    % -- remove according to the user
    
    nonwhite_bound_up = begin_edge_vertical(island_coor_row)-N_added;
    nonwhite_bound_down = stop_edge_vertical(island_coor_row)-N_added;
    nonwhite_bound_left = begin_edge_horizontal(island_coor_col)-N_added;
    nonwhite_bound_right = stop_edge_horizontal(island_coor_col)-N_added;
end



img_cropped = img_org(nonwhite_bound_up:nonwhite_bound_down, nonwhite_bound_left:nonwhite_bound_right, :);

imwrite(img_cropped,[imagename,'_cropped.jpg'],imageext(2:end));