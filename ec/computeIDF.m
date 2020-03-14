clear;

visionRandom = load('../matlab/visionRandom.mat');
d = sum(visionRandom.trainFeatures > 0, 1);
IDF = log(size(visionRandom.trainLabels, 1) ./ d);
save('IDF.mat', 'IDF');