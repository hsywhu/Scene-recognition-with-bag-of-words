function [ h ] = getImageFeatures(wordMap, dictionarySize)
    % init h with the dictionary size
    h = zeros(dictionarySize, 0);
    for i = 1:dictionarySize
        h(i) = sum(wordMap(:) == i);
    end
    
    % normalize h
    h = transpose(h / max(h));
end