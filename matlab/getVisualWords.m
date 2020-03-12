% function [wordMap] = getVisualWords(I, filterbank, dictionary)
% 
%     [H, W, ~] = size(I);
%     filterResponses = reshape(extractFilterResponses(I, filterbank),H*W,[]);
%     dist = pdist2(filterResponses, dictionary); 
%     [~, wordMap] = min(dist, [], 2);
%     wordMap = reshape(wordMap, H, W);
% 
% end