# Problem 1:

## Find maximum square patch of non cloud image 
1. binarize image
2. create a distance matrix that measures the distance between each pixel and its nearest cloud pixel 
3. find the (i,j) index corresponding to the point farthest away from a cloud
4. mark the square area according to this pixel and the total length of the area
 Time Results :
 Cloud1.jpg - 9.339430 seconds
 Cloud2.jpg - 1.366846 seconds
 Cloud3.jpg - 0.389064 seconds

# Problem 2:

Assumptions : Area of liquid covered by bottle from the mid point of shoulder and neck can be accurately measured by the sum of the binarized image and the threshold(min area covered for an adequate bottle) is roughly 0.7. Also the colour of images obtained by the system will more or less be similar

## Detecting inadequately filled bottles on a conveyor belt 
1. Binarize the image 
2. Measure properties of image regions using regionprops
3.  Detect each bottle seperately based on the area covered by the image region that bounds the bottle
4. Segment the image using a threshold based on the colour of the contents of the bottle
5. Calculate the % of bottle filled using ratio of  : bottle_filled/total length of the bottle(in terms of width * height)

# Problem 3:

## Find winner of tic-tac-toe image %%
1. Binarize the image for easier computation (not necessary)
2. Crop image of 3x3 grid into its 9 cells
3. Using Euler numbers of each cell, construct a matrix containing 2 for X, 3 for O and 0 for empty cells
4. Traverse linearly to find winner of the grid using histogram plots of X,O,'blank'
5. If none found, declare TIE

# Problem 4:

## Binarize document images into foreground and background regions 

1. Iteration 1 : Using Otsus method for Global Thresholding
* After doing an adaptive histogram equalization on the image to enhance its contrast, find a global threshold using graythresh such that the intra class variance is minimised.

2. Iteration 2 : Using Otsus method for finding local thresholds instead
* Apply the method in windows of the image, this gets rid of shadows etc but causes a lot of noise in the image even after applying wiener filter

3. Iteration 3 : Using Shafait Efficient Binarization technique of Local Adaptive Thresholding 
* Convert to grayscale and filter noise already present in the image using a wiener filter
* Calculate the integral image, using which find the mean image and std dev image having corr values for each pixel
 the threshold for each pixel is then :  mean.*(1 + k * (deviation / max_deviation-1))

# Problem 5:

## Tone Mapping w/ 3 techniques 
1. Read in the image using getpfmraw function 

2. Linear Mapping :
* Rescale image using min and max values of the given luminance matrix
* Compute output using y = ((x - xMin) ./ (xMax - xMin))*255;

3. Reinhards Approach :
* Lw is given, Compute Lw mean image as exp(mean(mean(log(delta + Lw))))
* Finally Lm is given by (Lw/LwMean) * key, the key value indicates whether the whole scene is going to be light or dark

4. Local Dodge And Burn
% Since HDR images lose important details in global tone mapping after enhancing world luminance
% Local region is defined as the area surrounding the centre pixel in question where no large contrast changes occur
% Dodging : Light is witheld from a region
% Burning : Light is added to that region
% Equivalent to finding a new key value for every pixel
% Calculate Lm as before
% V1 is the average of the centre pixel according to neighbourhood region defined by Sm
% Sm is chosen after iterating for every pixel using the response function
% V(x,y,Sm) < threshold
% Once this Sm is computed for a pixel (x,y) Ldisplay is computed as : L(x,y) / 1 + V1(x,y,Sm)
% Dark Pixel (L) on light V1 : lowers Ld more, hence increases contrast (dodging) 
% Light Pixel (L) on dark V1 : lowers Ld less, hence increases contrast (burning)

