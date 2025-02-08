clc; clear; close all;

img = im2double(imread('Test.JPG'));

noisy_pepper = Add_Noise(img, 0.1, 'pepper');
noisy_gaussian = Add_Noise(img, 0.05, 'gaussian');

figure;
subplot(1, 3, 1);
imshow(img);
title('Original Image');

subplot(1, 3, 2);
imshow(noisy_pepper);
title('Salt & Pepper Noise');

subplot(1, 3, 3);
imshow(noisy_gaussian);
title('Gaussian Noise');
