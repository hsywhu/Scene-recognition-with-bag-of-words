function [points] = getHarrisPoints(I, alpha, k)
    I = double(rgb2gray(I));
    
    % precompute the image's X and Y gradients
    [Ix, Iy] = gradient(I);
    [Ix2, Ixy] = gradient(Ix);
    [Iyx, Iy2] = gradient(Iy);
    
    % compute the covariance matrix
    window = ones(5, 5);
    M11 = conv2(Ix2, window, 'same');
    M12 = conv2(Ixy, window, 'same');
    M21 = conv2(Iyx, window, 'same');
    M22 = conv2(Iy2, window, 'same');
    
    % compute the response function
    detM = M11 .* M22 - M12 .* M21;
    ktrM2 = ((M11 + M21) .^ 2) * k;
    R = detM - ktrM2;
    
    % non-max suppression
    [~, idx] = sort(R(:), 'descend');
    selectedIdx = idx(1:alpha);
    
    % get the result
    [row, col] = ind2sub(size(I), selectedIdx);
    points = [row, col];
end