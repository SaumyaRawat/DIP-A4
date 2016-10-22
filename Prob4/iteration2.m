function[bw] = iteration2(I)
	grayImage = rgb2gray(I);
	[rows, columns] = size(grayImage);

	% Local Otsu of the gray level image.
	localThresh = blockproc(I, [100 100], @(x) im2bw(x.data, graythresh(x.data)));
	% Weiner filter
	[bw,noise] = wiener2(localThresh,[3 2]);
end

