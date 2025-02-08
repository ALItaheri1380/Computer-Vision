close all; clear all; clc;

x = 506;
y = 308;
w = 57;
h = 47;

img = load_img(0);
crop = img(y:y + h - 1, x:x + w - 1, :);

histData = colorHist(crop);
probMapImg = probMap(crop, histData);

figure(1);
subplot(2, 1, 1);
bar(histData);
xlim([0 256]);
title('Histogram');

ax = subplot(2, 1, 2);
imshow(probMapImg / 255);
colormap(ax, hot);
title('Probability Map');
