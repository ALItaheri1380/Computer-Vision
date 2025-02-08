clc; clear; close all;

sigma = 1.5;
kernel = Gaus(sigma);

disp('Gaussian Kernel:');
disp(kernel);

figure;
plot(kernel, 'o-');
title(['Gaussian Kernel, sigma = ' num2str(sigma)]);
grid on;