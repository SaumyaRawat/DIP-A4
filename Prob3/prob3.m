%% Detect winner of tic-tac-toe %%

%% Winning patterns for X %%
win1X = [2,0,0;0,2,0;0,0,2];
win2X = [0,0,2;0,2,0;2,0,0];
win3X = [2,2,2;0,0,0;0,0,0];
win4X = [0,0,0;2,2,2;0,0,0];
win5X = [0,0,0;0,0,0;2,2,2];
win6X = [2,0,0;0,0,0;2,2,2];


im = imread('tic-tac-toe4.jpg');

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
   disp(euler_no)
   location = [stats(ind(i)).BoundingBox];
   row = ceil(location(2)/200); col = ceil(location(1)/200);
   grid(row,col) = euler_no;
end

winner = 0;
isWon = 0;
for x=1:3
   player_value = grid(x,1);
   if player_value == 0
      continue
   end
   for y=1:3
      current = grid(x,y);
      if (current == 0 || current~=player_value)
         break
      end
      if (y == 3)
         isWon = 1;
         winner = value;
      end
   end
   if isWon==1
      break
   end
end
