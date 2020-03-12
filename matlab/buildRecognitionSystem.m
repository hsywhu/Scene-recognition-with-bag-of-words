% load from traintest.mat
traintest = load('../data/traintest.mat');
trainImagenames = traintest.train_imagenames;
trainLabels = traintest.train_labels;

% load dictionary
dictionaryRandom = load('./dictionaryRandom.mat');
dictionaryRandom = dictionaryRandom.dictionary;
dictionaryHarris = load('./dictionaryHarris.mat');
filterBank = dictionaryHarris.filterBank;
dictionaryHarris = dictionaryHarris.dictionary;

trainFeaturesRandom = zeros(length(trainImagenames), size(dictionaryRandom, 1));
trainFeaturesHarris = zeros(length(trainImagenames), size(dictionaryHarris, 1));
for i = 1:length(trainImagenames)
    wordMap = load(strrep(strcat('../data/dictionaryRandom/', trainImagenames{i}), '.jpg', '.mat'));
    wordMap = wordMap.wordMap;
    feature = getImageFeatures(wordMap, size(dictionaryRandom, 1));
    trainFeaturesRandom(i, :) = feature;
    
    wordMap = load(strrep(strcat('../data/dictionaryHarris/', trainImagenames{i}), '.jpg', '.mat'));
    wordMap = wordMap.wordMap;
    feature = getImageFeatures(wordMap, size(dictionaryHarris, 1));
    trainFeaturesHarris(i, :) = feature;
end
save('visionRandom.mat', 'dictionaryRandom', 'filterBank', 'trainFeaturesRandom', 'trainLabels');
save('visionHarris.mat', 'dictionaryHarris', 'filterBank', 'trainFeaturesHarris', 'trainLabels');