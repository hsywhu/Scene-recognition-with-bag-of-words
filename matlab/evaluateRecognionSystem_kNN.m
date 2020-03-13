clear;
% random & chi2 works the best
% load vision random
traintest = load('../data/traintest.mat');
visionRandom = load('visionRandom.mat');

% init
trainFeatures = visionRandom.trainFeatures;
trainLabels = visionRandom.trainLabels;
testLabels = traintest.test_labels;
classNum = size(traintest.mapping, 2);
confusions = zeros(40, classNum, classNum);
kRes = zeros([40 size(traintest.test_labels, 2)]);
K = size(visionRandom.dictionary, 1);
imageNum = length(traintest.test_imagenames);

for i = 1:imageNum
    imgMatPath = strrep(strcat('../data/dictionaryRandom/', traintest.test_imagenames{i}), '.jpg', '.mat');
    imgMat = load(imgMatPath);
    wordMap = imgMat.wordMap;
    h = getImageFeatures(wordMap, K);
    
    % calculate confusion matrix for each k
    for k = 1:40
        chi2Distance = getImageDistance(h, transpose(trainFeatures), 'chi2');
        [~, sortedIdx] = sort(chi2Distance);
        kRes(k, i) = mode(trainLabels(sortedIdx(1:k)));
        testLabel = testLabels(i);
        confusions(k, testLabel, kRes(k, i)) = confusions(k, testLabel, kRes(k, i)) + 1;
    end
end

accList = mean(kRes == traintest.test_labels, 2);
[~, bestK] = max(accList);

figure;
plot(1:40, accList);
xlabel('k');
ylabel('acc');

acc = accList(bestK);
confusion = zeros(classNum, classNum);
confusion(:, :) = confusions(bestK, :, :);