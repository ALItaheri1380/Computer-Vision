function f = response(img, r, c, width, height)
    f = img(r+height, c+width) + img(r, c) - img(r+height, c) - img(r, c+width);
end