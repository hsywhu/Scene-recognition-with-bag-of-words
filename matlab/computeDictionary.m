clear;

alpha = 500;
K = 100;
filterBank = createFilterBank();
% loading the training image paths
traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;

dictionaryRandom = getDictionary(trainImageNames, alpha, K, 'random');
save('dictionaryRandom.mat', 'filterBank', 'dictionaryRandom');
dictionaryHarris = getDictionary(trainImageNames, alpha, K, 'harris');
save('dictionaryHarris.mat', 'filterBank', 'dictionaryHarris');
