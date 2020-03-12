% loading the training image paths
traintest = load('../data/traintest.mat');
trainImageNames = traintest.train_imagenames;

alpha = 500;
K = 100;
filterBank = createFilterBank();

dictionary = getDictionary(train_imagenames, alpha, K, 'random');
save('dictionaryRandom.mat', 'filterBank', 'dictionary');

dictionary = getDictionary(train_imagenames, alpha, K, 'harris');
save('dictionaryHarris.mat', 'filterBank', 'dictionary');
