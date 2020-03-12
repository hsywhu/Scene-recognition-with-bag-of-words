function [dictionary] = getDictionary(imgPaths, alpha, K, method)
    filterBank = createFilterBank();
    imgPaths = string(imgPaths);
    pixelResponses = zeros(alpha * length(imgPaths), 3 * length(filterBank));
    for i = 1:length(imgPaths)
        disp(strcat('progress: ', string(i/length(imgPaths))));
        imgPath = strcat('../data/', imgPaths(i));
        img = imread(imgPath);
         [~, ~, channelNum] = size(img);
        % only rgb images can be processed
        if channelNum == 1
            img = cat(3, img, img, img);
        end
        filterResponses = extractFilterResponses(img, filterBank);
        if (strcmp(method, 'random'))
            points = getRandomPoints(img, alpha);
        elseif (strcmp(method, 'harris'))
            points = getHarrisPoints(img, alpha, 0.04);
        end
        for pixelIdx = 1:alpha
            pixelResponses(alpha*(i-1)+pixelIdx, :) = filterResponses(points(pixelIdx, 1), points(pixelIdx, 2), :);
        end
    end
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
end