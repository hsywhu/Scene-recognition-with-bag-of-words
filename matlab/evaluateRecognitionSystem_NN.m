% load mat
traintest = load('../data/traintest.mat');
mapping = traintest.mapping;


% Random
visionRandom = load('visionRandom.mat');
K = size(visionRandom.dictionary, 1);
classNum = size(mapping, 2);
randomEuclideanConfusion = zeros(classNum, classNum);
randomChi2Confusion = zeros(classNum, classNum);

resEuclidean = zeros(size(traintest.test_labels));
resChi2 = zeros(size(traintest.test_labels));

for i = 1:length(traintest.test_imagenames)
    imgMatPath = strrep(strcat('../data/dictionaryRandom/', traintest.test_imagenames{i}), '.jpg', '.mat');
    imgMat = load(imgMatPath);
    wordMap = imgMat.wordMap;
    h = getImageFeatures(wordMap, K);
    chi2Distance = getImageDistance(h, visionRandom.trainFeatures', 'chi2');
    euclidean2Distance = getImageDistance(h, visionRandom.trainFeatures', 'euclidean');
    [~, chi2Idx] = min(chi2Distance);
    [~, euclideanIdx] = min(euclidean2Distance);
    resChi2(i) = visionRandom.trainLabels(chi2Idx);
    resEuclidean(i) = visionRandom.trainLabels(euclideanIdx);
    label = traintest.test_labels(i);
    randomChi2Confusion(label, resChi2(i)) = randomChi2Confusion(label, resChi2(i)) + 1;
    randomEuclideanConfusion(label, resEuclidean(i)) = randomEuclideanConfusion(label, resEuclidean(i)) + 1;
end

randomEuclideanAcc = mean(resEuclidean == traintest.test_labels);
randomChi2Acc = mean(resChi2 == traintest.test_labels);
disp('confusion matrix of random dictionary with euclidean distance metric');
disp(randomEuclideanConfusion);
disp('acc of random dictionary with euclidean distance metric');
disp(randomEuclideanAcc);
disp('confusion matrix of random dictionary with chi2 distance metric');
disp(randomChi2Confusion);
disp('acc of random dictionary with chi2 distance metric');
disp(randomChi2Acc);

% Harris
visionHarris = load('visionHarris.mat');
K = size(visionHarris.dictionary, 1);
classNum = size(mapping, 2);
harrisEuclideanConfusion = zeros(classNum, classNum);
harrisChi2Confusion = zeros(classNum, classNum);

resEuclidean = zeros(size(traintest.test_labels));
resChi2 = zeros(size(traintest.test_labels));

for i = 1:length(traintest.test_imagenames)
    imgMatPath = strrep(strcat('../data/dictionaryHarris/', traintest.test_imagenames{i}), '.jpg', '.mat');
    imgMat = load(imgMatPath);
    wordMap = imgMat.wordMap;
    h = getImageFeatures(wordMap, K);
    chi2Distance = getImageDistance(h, visionHarris.trainFeatures', 'chi2');
    euclidean2Distance = getImageDistance(h, visionHarris.trainFeatures', 'euclidean');
    [~, chi2Idx] = min(chi2Distance);
    [~, euclideanIdx] = min(euclidean2Distance);
    resChi2(i) = visionHarris.trainLabels(chi2Idx);
    resEuclidean(i) = visionHarris.trainLabels(euclideanIdx);
    label = traintest.test_labels(i);
    harrisChi2Confusion(label, resChi2(i)) = harrisChi2Confusion(label, resChi2(i)) + 1;
    harrisEuclideanConfusion(label, resEuclidean(i)) = harrisEuclideanConfusion(label, resEuclidean(i)) + 1;
end

harrisEuclideanAcc = mean(resEuclidean == traintest.test_labels);
harrisChi2Acc = mean(resChi2 == traintest.test_labels);
disp('confusion matrix of harris dictionary with euclidean distance metric');
disp(harrisEuclideanConfusion);
disp('acc of harris dictionary with euclidean distance metric');
disp(harrisEuclideanAcc);
disp('confusion matrix of harris dictionary with chi2 distance metric');
disp(harrisChi2Confusion);
disp('acc of harris dictionary with chi2 distance metric');
disp(harrisChi2Acc);