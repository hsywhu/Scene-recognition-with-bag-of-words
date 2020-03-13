function [dist] = getImageDistance(hist1, histSet, method)
    hist = repmat(hist1, 1, size(histSet, 2));
    if strcmp(method, 'chi2')
        diff = hist - histSet;
        total = hist + histSet;
        tmp = fillmissing((diff .^ 2) ./ total, 'constant', 0);
        dist = sum(tmp) / 2;
    elseif strcmp(method, 'euclidean')
        dist = pdist2(hist1', histSet', 'euclidean');
    end
end