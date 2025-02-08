clc ; clear ; close all
img = imread('Test.jpg');

if size(img, 3) == 3
    img = rgb2gray(img);
end

img = im2double(img);

result = Non_max_suppression(img, 3, 3);

subplot(1, 2, 1);
imshow(img);
title('Original Image');

subplot(1, 2, 2);
imshow(result);
title('After Non-Maximum Suppression');
