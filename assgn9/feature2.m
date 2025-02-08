function f = feature2(img, x, y, width, height)
    f = response(img, r, c, width-1, height/2 - 1) ...
        + response(img, r+height/2, c, width-1, height/2 - 1);
end