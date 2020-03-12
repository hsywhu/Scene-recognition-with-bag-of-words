clear;
% loading the training image paths
traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;

alpha = 50;
K = 100;
filterBank = createFilterBank();

dictionary = getDictionary(trainImageNames, alpha, K, 'random');
save('dictionaryRandom.mat', 'filterBank', 'dictionary');

dictionary = getDictionary(trainImageNames, alpha, K, 'harris');
save('dictionaryHarris.mat', 'filterBank', 'dictionary');
