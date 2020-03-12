% Q1.1
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

% % Q1.2
% % Parameters
% alpha = 10;
% 
% % Load image 1
% img = imread('../data/bedroom/sun_ajenyvgoteenliuj.jpg');
% 
% % getHarrisPoints
% points = getRandomPoints(img, alpha);
% % points = getHarrisPoints(img, alpha, 0.04);
% 
% imshow(img); hold on; plot(points(:, 2), points(:, 1), '.', 'markerSize', 20);

%% Load image 1
img = imread('../data/airport/sun_aerinlrdodkqnypz.jpg');

%% Load filterbank and dictionary
load('./dictionaryHarris.mat', 'filterBank');
dict_random = load('./dictionaryRandom.mat');
dict_random = dict_random.dictionary;
dict_harris = load('./dictionaryHarris.mat');
dict_harris = dict_harris.dictionary;

%% Get Visual Words
wordMap = getVisualWords(img, filterBank, dict_random);
figure; imshow(label2rgb(wordMap));

wordMap = getVisualWords(img, filterBank, dict_harris);
figure; imshow(label2rgb(wordMap));

%% Load image 2
img = imread('../data/auditorium/sun_aadrvlcduunrbpul.jpg');

%% Get Visual Words
wordMap = getVisualWords(img, filterBank, dict_random);
figure; imshow(label2rgb(wordMap));

wordMap = getVisualWords(img, filterBank, dict_harris);
figure; imshow(label2rgb(wordMap));

%% Load image 3
img = imread('../data/bedroom/sun_aacyfyrluprisdrx.jpg');

%% Get Visual Words
wordMap = getVisualWords(img, filterBank, dict_random);
figure; imshow(label2rgb(wordMap));

wordMap = getVisualWords(img, filterBank, dict_harris);
figure; imshow(label2rgb(wordMap));

