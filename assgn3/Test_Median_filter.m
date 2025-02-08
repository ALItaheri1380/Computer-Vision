clc; clear; close all;

img = im2double(rgb2gray(imread('Test.JPG')));
noisy_img = Add_Noise(img, 0.1, 'pepper');
filtered_img = Median_filter(noisy_img, 3);

figure;
subplot(1, 3, 1);
imshow(img);
title('Original');

subplot(1, 3, 2);
imshow(noisy_img);
title('Noisy Image');

subplot(1, 3, 3);
imshow(filtered_img);
title('Filtered');
