% gabor feature extractor implemented by 
% Andrew Otto (2020). 
% Gabor Filter Bank (2D) (https://www.mathworks.com/matlabcentral/fileexchange/71348-gabor-filter-bank-2d), 
% MATLAB Central File Exchange. Retrieved March 14, 2020.

traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;
K = 1000;

% extract gabor features
n_scales = 5;
n_orients = 8;
r = 39;
c = 39;
gaborArray = gaborFilterBank(n_scales, n_orients, r, c);

% extract HOG features
% features = zeros(length(trainImageNames), K);
% addpath('../matlab');
% boundaries = zeros(K+1, 1);
% for k = 2:K+1
%     boundaries(k) = (k-1)/K;
% end
% for i = 1:length(trainImageNames)
%     disp(i/length(trainImageNames))
%     img = imread(strcat('../data/', traintest.train_imagenames{i}));
%     normalizedFeature = zeros(K, 1);
%     feature = extractHOGFeatures(img, 'cellsize', [4 4]);
% %     feature = gaborFeatures(img,gaborArray,4,4);
%     for k = 1:K
%         normalizedFeature(k) = sum(boundaries(k) < feature & feature < boundaries(k+1));
%     end
%     normalizedFeature = normalizedFeature ./ sum(feature);
%     features(i, :) = normalizedFeature;
% end
% save('gaborFeatures.mat', 'features');
% save('hogFeatures.mat', 'features');

% load saved features

% features = load('gaborFeatures.mat');
% features = features.features;

features = load('hogFeatures.mat');
features = features.features;

% evaluate on SVM

featureRes = zeros(length(traintest.test_imagenames), K);
testImagenames = traintest.test_imagenames;

addpath('./libsvm-3.24/matlab');
for i = 1:length(testImagenames)
    disp(i/length(testImagenames))
    img = imread(strcat('../data/', testImagenames{i}));
    
    feature = extractHOGFeatures(img, 'cellsize', [4 4]);
%     feature = gaborFeatures(img,gaborArray,4,4);
    normalizedFeature = zeros(K, 1);
    for k = 1:K
        normalizedFeature(k) = sum(boundaries(k) < feature & feature < boundaries(k+1));
    end
    normalizedFeature = normalizedFeature ./ sum(feature);
    featureRes(i, :) = normalizedFeature;
end
trainFeatures = features;
trainLabels = transpose(traintest.train_labels);
linearSvm = svmtrain(trainLabels, trainFeatures,  '-t 2 -q -c 15000 -g 0.098');
svmpredict(traintest.test_labels', featureRes, linearSvm);