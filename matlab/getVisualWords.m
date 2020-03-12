function [wordMap] = getVisualWords(I, filterBank, dictionary)
    [rowNum, colNum, channelNum] = size(I);
    if channelNum == 1
        I = cat(3, I, I, I);
    end
    filterResponses = extractFilterResponses(I, filterBank);
    Isize = rowNum * colNum;
    filterResponses = reshape(filterResponses, Isize, []);
    [~, wordMap] = pdist2(dictionary, filterResponses, 'euclidean','smallest',1);
    wordMap = reshape(wordMap, rowNum, colNum);
end