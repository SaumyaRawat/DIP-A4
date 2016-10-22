function[output]=lat_thresh(image,m,n)
%SAUVOLA local thresholding.
	k = 0.34;

	% Convert to gray
	image = rgb2gray(image);
	[rows columns] = size(image);   % size of the image

	% calculate mean image from integral image
	padded_image = double(padarray(padarray(image, round([(m+1)/2 (n+1)/2]), 'replicate', 'pre'), round([(m-1)/2 (n-1)/2]), 'replicate', 'post'));
	integral_image = cumsum(cumsum(padded_image),2);
	mean_image = (integral_image(1+m:rows+m, 1+n:columns+n) + integral_image(1:rows, 1:columns)- integral_image(1+m:rows+m, 1:columns) - integral_image(1:rows, 1+n:columns+n) )/(m*n);
	mean = cast(mean_image, class(image));

	% calculate standard deviation image from integral_image
	[rows columns] = size(image.^2); 
	padded_image = double(padarray(padarray(image.^2, round([(m+1)/2 (n+1)/2]), 'replicate', 'pre'), round([(m-1)/2 (n-1)/2]), 'replicate', 'post'));
	integral_image = cumsum(cumsum(padded_image),2);
	mean_image = (integral_image(1+m:rows+m, 1+n:columns+n) + integral_image(1:rows, 1:columns)- integral_image(1+m:rows+m, 1:columns) - integral_image(1:rows, 1+n:columns+n) )/(m*n);
	mean_square = cast(mean_image, class(image));
	deviation = (mean_square - mean.^2).^0.5;

	R = max(deviation(:));
	threshold = mean.*(1 + k * (deviation / R-1));
	output = (image > threshold);
end