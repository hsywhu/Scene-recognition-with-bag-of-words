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
    wordMap = load(strrep(strcat('../data/dictionaryHarris/', testImagenames{i}), '.jpg', '.mat'));
    wordMap = wordMap.wordMap;
    feature = getImageFeatures(wordMap, K);
    feature = transpose(IDF) .* feature;
    featureRes(i, :) = feature;
end

disp('svm with linear kernel')
trainLabels = transpose(traintest.train_labels);
trainFeatures = visionSVM.trainFeatures .* IDF;
linearSvm = svmtrain(trainLabels, trainFeatures,  '-b 0 -e 0.0001 -g 0.1 -t 0 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, linearSvm);

disp('svm with polynomial kernel')
trainLabels = transpose(traintest.train_labels);
trainFeatures = visionSVM.trainFeatures .* IDF;
polynomialSvm = svmtrain(trainLabels, trainFeatures,  '-b 0 -e 0.0001 -g 0.1 -t 1 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, polynomialSvm);

disp('svm with radial basis kernel')
trainLabels = transpose(traintest.train_labels);
trainFeatures = visionSVM.trainFeatures .* IDF;
radialBasisSvm = svmtrain(trainLabels, trainFeatures,  '-b 0 -e 0.0001 -g 0.1 -t 2 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, radialBasisSvm);