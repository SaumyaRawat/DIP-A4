function[bw] = iteration1(I)
	%J = imadjust(I,stretchlim(I),[]);
	%J = brighten(J,0.9);
	J = I;
	% Obtain a sharp bw image to easily distinguish windows using Adaptive Histogram Equalization and Oshos Thresholding.
	j = adapthisteq(rgb2gray(J));
	level = graythresh(j);
	bw = im2bw(j,level);
	%figure;imshow(bw);title('Adaptive Thresholded Image')
end