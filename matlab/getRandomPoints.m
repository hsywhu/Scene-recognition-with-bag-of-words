function [points] = getRandomPoints(I, alpha)
    [rowNum, colNum, ~] = size(I);
    randRows = randi(rowNum, [alpha 1]);
    randCols = randi(colNum, [alpha 1]);
    points = zeros(alpha, 2);
    points(:, 1) = randRows;
    points(:, 2) = randCols;
end