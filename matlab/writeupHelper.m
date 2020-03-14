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
% alpha = 500;
% 
% % Load image 1
% img = imread('../data/landscape/sun_bwmhmdvisxfogksv.jpg');
% 
% % getHarrisPoints
% % points = getRandomPoints(img, alpha);
% points = getHarrisPoints(img, alpha, 0.06);
% 
% imshow(img); hold on; plot(points(:, 2), points(:, 1), '.', 'markerSize', 10);

% % test Q2.1
% img = imread('../data/football_stadium/sun_arjxmegqfeavsozz.jpg');
% 
% dictionaryRandom = load('./dictionaryRandom.mat');
% dictionaryRandom = dictionaryRandom.dictionary;
% dictionaryHarris = load('./dictionaryHarris.mat');
% filterBank = dictionaryHarris.filterBank;
% dictionaryHarris = dictionaryHarris.dictionary;
% 
% % random visual words
% wordMap = getVisualWords(img, filterBank, dictionaryRandom);
% figure; imshow(label2rgb(wordMap));
% 
% % harris visual words
% wordMap = getVisualWords(img, filterBank, dictionaryHarris);
% figure; imshow(label2rgb(wordMap));

% Q2.1
batchToVisualWords(6, 'random') ;
batchToVisualWords(6, 'harris') ;
