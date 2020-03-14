% gabor feature extractor implemented by 
% Andrew Otto (2020). 
% Gabor Filter Bank (2D) (https://www.mathworks.com/matlabcentral/fileexchange/71348-gabor-filter-bank-2d), 
% MATLAB Central File Exchange. Retrieved March 14, 2020.

n_scales = 5;
n_orients = 8;

r = 39;
c = 39;
gaborArray = gaborFilterBank(n_scales, n_orients, r, c);
% gaborArray = gaborFilterBank(n_scales, n_orients, r, c);
% gaborFilters = cell(n_scales * n_orients,1);
% for i = 1:length(gaborArray)
%     gaborFilters{i} = gaborArray(1, i).FFTkernel;
% end
% 
traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;
alpha = 50;
K = 10000;

% get random dictionary with gaborFilters
% dictionary = getGaborDictionary(trainImageNames, alpha, K, 'random', gaborFilters);
% filterBank = gaborFilters;
% save('dictionaryRandomGabor.mat', 'dictionary', 'filterBank');

% load dictionaryGabor
% load('dictionaryRandomGabor.mat', 'dictionary');

% create visual words
% batchToVisualWords(6, 'randomGabor') ;

% extract gabor features
% features = zeros(length(trainImageNames), K);
% addpath('../matlab');
% for i = 1:length(trainImageNames)
%     wordMap = load(strrep(strcat('../data/dictionaryRandomGabor/', trainImageNames{i}), '.jpg', '.mat'));
%     wordMap = wordMap.wordMap;
%     feature = getImageFeatures(wordMap, K);
%     features(i, :) = feature;
% end
% save('gaborFeatures.mat', 'features');
% 
% features = load('gaborFeatures.mat');
% features = features.features;

% extract gabor features
features = zeros(length(trainImageNames), K);
addpath('../matlab');
for i = 1:length(trainImageNames)
    disp(i/length(trainImageNames))
    img = imread(strcat('../data/', traintest.train_imagenames{i}));
    feature = gaborFeatures(img,gaborArray,4,4);
    feature = feature(1:K);
    features(i, :) = feature;
end
save('gaborFeaturesEx.mat', 'features');

% features = load('gaborFeatures.mat');
% features = features.features;

% evaluate on SVM
% visionSVM = load('visionSVM.mat');

featureRes = zeros(length(traintest.test_imagenames), K);
testImagenames = traintest.test_imagenames;

addpath('../matlab');
addpath('./libsvm-3.24/matlab');

for i = 1:length(testImagenames)
    disp(i/length(testImagenames))
%     wordMap = load(strrep(strcat('../data/dictionaryRandomGabor/', testImagenames{i}), '.jpg', '.mat'));
%     wordMap = wordMap.wordMap;
%     feature = getImageFeatures(wordMap, K);
%     featureRes(i, :) = feature;

    img = imread(strcat('../data/', testImagenames{i}));
    feature = gaborFeatures(img,gaborArray,4,4);
    feature = feature(1:K);
    featureRes(i, :) = feature;
end
trainFeatures = features;
trainLabels = transpose(traintest.train_labels);
disp('svm with linear kernel')
linearSvm = svmtrain(trainLabels, trainFeatures,  '-t 1 -q');
svmpredict(traintest.test_labels', featureRes, linearSvm);

function [dictionary] = getGaborDictionary(imgPaths, alpha, K, method, gobarFilters)
    filterBank = gobarFilters;
    pixelResponses = zeros(alpha * length(imgPaths), 3 * length(filterBank));
    imgPaths = string(imgPaths);
    for i = 1:length(imgPaths)
        disp(strcat('progress: ', string(i/length(imgPaths))));
        imgPath = strcat('../data/', imgPaths(i));
        img = imread(imgPath);
         [~, ~, channelNum] = size(img);
        % only rgb images can be processed
        if channelNum == 1
            img = cat(3, img, img, img);
        end
        filterResponses = extractFilterResponses(img, filterBank);
        if strcmp(method, 'random')
            points = getRandomPoints(img, alpha);
        else
            points = getHarrisPoints(img, alpha, 0.06);
        end
        for pixelIdx = 1:alpha
            pixelResponses(alpha*(i-1)+pixelIdx, :) = filterResponses(points(pixelIdx, 1), points(pixelIdx, 2), :);
        end
    end
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end