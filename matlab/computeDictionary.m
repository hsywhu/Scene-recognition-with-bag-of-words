clear;

alpha = 500;
K = 100;
filterBank = createFilterBank();
% loading the training image paths
traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;

dictionaryRandom = getDictionary(trainImageNames, alpha, K, 'random');
dictionary = dictionaryRandom;
save('dictionaryRandom.mat', 'filterBank', 'dictionary');

dictionaryHarris = getDictionary(trainImageNames, alpha, K, 'harris');
dictionary = dictionaryHarris;
save('dictionaryHarris.mat', 'filterBank', 'dictionary');
