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

randomEuclideanAcc = mean(resEuclidean == traintest.test_labels)
randomChi2Acc = mean(resChi2 == traintest.test_labels)


% Harris
visionHarris = load('visionHarris.mat');
K = size(visionHarris.dictionary, 1);
classNum = size(mapping, 2);
randomEuclideanConfusion = zeros(classNum, classNum);
randomChi2Confusion = zeros(classNum, classNum);

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
    randomChi2Confusion(label, resChi2(i)) = randomChi2Confusion(label, resChi2(i)) + 1;
    randomEuclideanConfusion(label, resEuclidean(i)) = randomEuclideanConfusion(label, resEuclidean(i)) + 1;
end

harrisEuclideanAcc = mean(resEuclidean == traintest.test_labels)
harrisChi2Acc = mean(resChi2 == traintest.test_labels)