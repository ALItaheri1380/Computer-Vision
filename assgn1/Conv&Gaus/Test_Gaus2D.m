clc; clear; close all;

sigma = 1.5;
kernel = Gaus2D(sigma);

disp('2D Gaussian Kernel:');
disp(kernel);

figure;
imshow(kernel, []);
title(['2D Gaussian Kernel, sigma = ', num2str(sigma)]);
