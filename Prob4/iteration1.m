function[bw] = iteration1(I)
	%J = imadjust(I,stretchlim(I),[]);
	%J = brighten(J,0.4);
	J = I;
	% enhances the contrast of the grayscale image I 
	j = adapthisteq(rgb2gray(J));
	% Global image thresholding using Otsus method.
	% chooses the threshold to minimize the intraclass variance of the pixels
	level = graythresh(j);
	bw = im2bw(j,level);
	%figure;imshow(bw);title('Global Thresholded Image')
end