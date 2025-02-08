clc; clear; close all

img = zeros(100, 100);
img(40:60, 40:60) = 1;

level = 3;
s0 = 1.6;
k = 1.2;
alpha = 0.04;
t = 0.01;

corners = Harris_laplace(img, level, s0, k, alpha, t);

figure;
subplot(1, 2, 1);
imshow(img, []);
title('Original Image');

subplot(1, 2, 2);
imshow(corners, []);
title('Detected Corners');
