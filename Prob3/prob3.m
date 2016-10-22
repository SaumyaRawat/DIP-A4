%% Detect winner of tic-tac-toe %%

bin_array = [0,2,3];
im = imread('tic-tac-toe1.jpg');

%% All rectangular bounding box of objects %%
bw = im2bw(im);

% find both black and white regions
stats = [regionprops(bw); regionprops(not(bw))]

% show the image and draw the detected rectangles on it
figure;imshow(bw); 
hold on;

for i = 1:numel(stats)
    rectangle('Position', stats(i).BoundingBox, ...
    'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
end

%% find objects of crosses and zeroes %%
[val,ind] = find([stats.Area]<2500);

grid = zeros(3,3);
row = 1;
col = 1;

%% Store the first x pixel row value of the image 
start = [stats(ind(1)).Centroid];
startX = start(1); startY = start(2);

%% empty cell = 0, X = 2 and O = 3

for i=1:size(ind,2)
   image_patch = imcrop(im,[stats(ind(i)).BoundingBox]);
   euler_no = bweuler(im2bw(image_patch));
   location = [stats(ind(i)).BoundingBox];
   row = ceil(location(2)/200); col = ceil(location(1)/200);
   grid(row,col) = euler_no;
end

winner = -1;
%% Check column wise
for i=1:3
   N=hist(grid(:,i),[0 2 3]);
   ind=find(N==3);
   if(size(ind,2)==0)
      continue
   else
      winner = grid(ind)
      break
   end
end

%% Check row wise
if winner == -1
   for i=1:3
      N=hist(grid(i,:),[0 2 3]);
      [ind]=find(N==3)
      if(size(ind,2)==0)
         continue
      else
         winner = grid(ind)
         break
      end
   end
end

%% Check diagonals
if winner == -1
   diag_left = diag(grid)
   l_ind = find(hist(diag_left,[0 2 3])==3)
   if(size(l_ind,2)==0)
      %% check right diagonal
      diag_right = diag(fliplr(grid))' %'
      r_ind = find(hist(diag_left,[0 2 3])==3)
      if(size(r_ind,2)==0)
         winner = -1;
      else
         winner = bin_array(diag_right(r_ind));
      end
   else
      winner = bin_array(diag_left(l_ind));
   end
end

if winner == 2
   disp('X WON!')
elseif winner == 3
   disp('O WON!')
else
   disp('TIE!')
end

