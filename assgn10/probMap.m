function map = probMap(img, hist)
    hsvImg = rgb2hsv(img);
    hueChannel = hsvImg(:, :, 3);

    hueIdx = hueindex(hueChannel);
    map = hist(hueIdx);

    maxVal = max(map(:));
    if maxVal > 0
        map = single(map) / maxVal * 255;
    else
        map = single(map);
    end
end
