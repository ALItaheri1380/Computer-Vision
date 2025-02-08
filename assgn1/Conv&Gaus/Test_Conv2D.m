clc; clear; close all;

img = imread('Test.JPG');
gray_img = rgb2gray(img);

kernel = [-1  2 -1;
          -1  2 -1;
          -1  2 -1];

border = 0;
result = convolution2D(double(gray_img), kernel, border);

figure;
subplot(1, 2, 1);
imshow(gray_img);
title('Original Grayscale Image');

subplot(1, 2, 2);
imshow(uint8(result));
title('Vertical Edge Detection');
