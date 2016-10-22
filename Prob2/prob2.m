I = imread('bottles.tif');

%% All rectangular bounding box of objects %%
bw = I>40;
% find both black and white regions
stats = [regionprops(bw); regionprops(not(bw))];

% show the image and draw the detected rectangles on it
%figure;imshow(I); 
%hold on;

k = 1;
for i = 1:numel(stats)
	if stats(i).Area>370 && stats(i).Area<50000 && size(stats(i).Area,1)~=0
		bottles(k).Area = stats(i).Area;bottles(k).BoundingBox = stats(i).BoundingBox; bottles(k).Centroid = stats(i).Centroid;
		bottles(k).image = imcrop(I,[bottles(k).BoundingBox]);
%		rectangle('Position', stats(i).BoundingBox, 'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
		k = k+1;
	end
end


for i = 1:numel(bottles)
	im = bottles(i).image;
	range=(im > 0 & im <= 220);
	im(~range)=0;
	im(range)=1; 
	imshow(im)
	bottle_content = sum(im(range));
	ratio = bottle_content/(size(im,1)*size(im,2));
	figure;imshow(bottles(i).image)
	i
	if ( ratio > 0.7 )
		disp('Full!')
	else
		disp('Inadequate!')
	end
end
