function f = feature1(img, r, c, width, height)
    f = response(img, r, c, width/2 - 1, height - 1) ...;
        + response(img, r, c+width/2, width/2 - 1, height-1);
end