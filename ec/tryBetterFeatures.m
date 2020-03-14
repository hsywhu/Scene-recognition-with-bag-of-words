% gabor feature extractor implemented by 
% Mohammad Haghighat (2020). 
% Gabor Feature Extraction (https://www.github.com/mhaghighat/gabor), GitHub. 
% Retrieved March 14, 2020.

traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;
K = 1000;

% extract gabor features
% n_scales = 5;
% n_orients = 8;
% r = 39;
% c = 39;
% gaborArray = gaborFilterBank(n_scales, n_orients, r, c);
% 
% features = zeros(length(trainImageNames), K);
% for i = 1:length(trainImageNames)
%     disp(i/length(trainImageNames))
%     img = imread(strcat('../data/', traintest.train_imagenames{i}));
%     feature = gaborFeatures(img,gaborArray,4,4);
%     feature = feature(1:K);
%     features(i, :) = feature;
% end
% save('gaborFeatures.mat', 'features');

% load saved features

% features = load('gaborFeatures.mat');
% features = features.features;


% extract HOG features
features = zeros(length(trainImageNames), K);
KLimitation = zeros(K+1, 1);
for Kidx = 2:K+1
    KLimitation(Kidx) = (Kidx-1)/K;
end
for i = 1:length(trainImageNames)
    disp(i/length(trainImageNames))
    img = imread(strcat('../data/', traintest.train_imagenames{i}));
    normalizedFeature = zeros(K, 1);
    feature = extractHOGFeatures(img, 'cellsize', [4 4]);
    for Kidx = 1:K
        chosen = KLimitation(Kidx) < feature & feature < KLimitation(Kidx+1);
        normalizedFeature(Kidx) = sum(chosen);
    end
    normalizedFeature = normalizedFeature ./ sum(feature);
    features(i, :) = normalizedFeature;
end
save('hogFeatures.mat', 'features');

% features = load('hogFeatures.mat');
% features = features.features;

% evaluate gabor on SVM
% featureRes = zeros(length(traintest.test_imagenames), K);
% testImagenames = traintest.test_imagenames;
% 
% addpath('./libsvm-3.24/matlab');
% for i = 1:length(testImagenames)
%     disp(i/length(testImagenames))
%     img = imread(strcat('../data/', testImagenames{i}));
%     feature = gaborFeatures(img,gaborArray,4,4);
%     feature = feature(1:K);
%     featureRes(i, :) = feature;
% end

% evaluate HOG on SVM
featureRes = zeros(length(traintest.test_imagenames), K);
testImagenames = traintest.test_imagenames;

addpath('./libsvm-3.24/matlab');
for i = 1:length(testImagenames)
    disp(i/length(testImagenames))
    img = imread(strcat('../data/', testImagenames{i}));
    
    feature = extractHOGFeatures(img, 'cellsize', [4 4]);
    normalizedFeature = zeros(K, 1);
    for Kidx = 1:K
        chosen = KLimitation(Kidx) < feature & feature < KLimitation(Kidx+1);
        normalizedFeature(Kidx) = sum(chosen);
    end
    normalizedFeature = normalizedFeature ./ sum(feature);
    featureRes(i, :) = normalizedFeature;
end

trainFeatures = features;
trainLabels = transpose(traintest.train_labels);
linearSvm = svmtrain(trainLabels, trainFeatures,  '-b 0 -e 0.0001 -g 0.08 -t 3 -c 8000 -q');
svmpredict(transpose(traintest.test_labels), featureRes, linearSvm);