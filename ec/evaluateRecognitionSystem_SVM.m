clear;
traintest = load('../data/traintest.mat');
visionSVM = load('visionSVM.mat');

K = size(visionSVM.dictionary, 1);
featureRes = zeros(length(traintest.test_imagenames), K);
testImagenames = traintest.test_imagenames;

addpath('../matlab');
addpath('./libsvm-3.24/matlab');

for i = 1:length(traintest.test_imagenames)
    wordMap = load(strrep(strcat('../data/dictionaryHarris/', testImagenames{i}), '.jpg', '.mat'));
    wordMap = wordMap.wordMap;
    feature = getImageFeatures(wordMap, K);
    featureRes(i, :) = feature;
end
trainLabels = transpose(traintest.train_labels);
disp('svm with linear kernel')
linearSvm = svmtrain(trainLabels, visionSVM.trainFeatures,  '-b 0 -e 0.0001 -g 0.08 -t 1 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, linearSvm);

fprintf(1, '\n');
disp('svm with polynomial kernel')
polynomialSvm = svmtrain(trainLabels, visionSVM.trainFeatures,  '-b 0 -e 0.0001 -g 0.1 -t 2 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, polynomialSvm);

fprintf(1, '\n');
disp('svm with radial basis kernel')
radialBasisSvm = svmtrain(trainLabels, visionSVM.trainFeatures,  '-b 0 -e 0.0001 -g 0.1 -t 3 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, radialBasisSvm);

fprintf(1, '\n');
disp('svm with sigmoid kernel')
sigmoidSvm = svmtrain(trainLabels, visionSVM.trainFeatures,  '-b 0 -e 0.0001 -g 0.1 -t 4 -c 10000 -q');
svmpredict(traintest.test_labels', featureRes, sigmoidSvm);