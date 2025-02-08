function histCounts = colorHist(img)
    hsvImg = rgb2hsv(img);
    hueChannel = hsvImg(:, :, 1);
    histCounts = zeros(256, 1);
    
    hueIdx = hueindex(hueChannel);
    for i = 1:numel(hueIdx)
        histCounts(hueIdx(i)) = histCounts(hueIdx(i)) + 1;
    end
end
