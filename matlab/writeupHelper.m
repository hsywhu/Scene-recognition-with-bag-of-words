% Q1
clear;
% [filterBank] = createFilterBank();
% image = imread('../data/campus/sun_dsrzpdstrwqbspik.jpg');
% image=double(image) / 255;
% H=size(image,1);
% W=size(image,2);
%  
% [filterResponses] = extractFilterResponses(image, filterBank);
% 
% for i=1:size(filterResponses,3)
%      result=reshape(filterResponses(:,:,i),H,W);   
% %      size(result)
%      m = max(max(result));
%      result = result / m;
%      result = uint8(result * 255);
%      figure;
%      imshow(result)
% end

% Parameters
alpha = 200;
k = 0.04;

% Load image 1
img = imread('../data/campus/sun_bqeqcysqtvxgmkas.jpg');

% getHarrisPoints
points = getRandomPoints(img, alpha);
imshow(img); hold on; plot(points(:, 2), points(:, 1), '.', 'markerSize', 10);

