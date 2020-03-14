clear;
traintest = load('../data/traintest.mat');
visionSVM = load('visionSVM.mat');

K = size(visionSVM.dictionary, 1);
featureRes = zeros(length(traintest.test_imagenames), K);
testImagenames = traintest.test_imagenames;

addpath('../matlab');
addpath('./libsvm-3.24/matlab');
IDF = load('IDF.mat');
IDF = IDF.IDF;
for i = 1:length(testImagenames)
    wordMap = load(strrep(strcat('../data/dictionaryRandom/', testImagenames{i}), '.jpg', '.mat'));
    wordMap = wordMap.wordMap;
    feature = getImageFeatures(wordMap, K);
    feature = transpose(IDF) .* feature;
    featureRes(i, :) = feature;
end

disp('svm with linear kernel')
trainLabels = transpose(traintest.train_labels);
trainFeatures = visionSVM.trainFeatures .* IDF;
linearSvm = svmtrain(trainLabels, trainFeatures,  '-t 0 -q');
svmpredict(traintest.test_labels', featureRes, linearSvm);