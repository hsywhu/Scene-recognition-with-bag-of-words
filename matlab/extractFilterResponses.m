function [filterResponses] = extractFilterResponses(I, filterBank)
    I = im2double(I);
    [rowNum, colNum, channelNum] = size(I);
    % only rgb images can be processed
    if channelNum == 1
       img = cat(3, img, img, img);
    end
    
    [LRes, aRes, bRes] = RGB2Lab(I(:, :, 1), I(:, :, 2), I(:, :, 3));
    
    % init the fileterResponses
    [n, ~] = size(filterBank);
    filterResponses = zeros(rowNum, colNum, 3 * n);
    
    % fill in the filter response using conv2
    for filterIdx = 1:n
        filter = filterBank{filterIdx, 1};
        filterResponses(:, :, 3 * filterIdx - 2) = conv2(LRes, filter, 'same');
        filterResponses(:, :, 3 * filterIdx - 1) = conv2(aRes, filter, 'same');
        filterResponses(:, :, 3 * filterIdx) = conv2(bRes, filter, 'same');
    end
end