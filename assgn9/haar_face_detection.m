clear all; close all; clc;

load('data/Classifiers.mat')
faceDetector = HaarFeatures(classifiers, 1);
winSize = faceDetector.windowSize;

imgData = single(rgb2gray(imread('data/faceD.jpg')));
imgData = imresize(imgData, 0.5);

size(imgData)

for iter = 1:10
    imgData = imresize(imgData, 0.85);

    figure(1)
    subplot(2, 1, 1)
    imshow(imgData / 255)

    subplot(2, 1, 2)

    resp = faceDetector.classify(imgData);
    imshow(resp / max(resp(:)))

    maxIdx = find(resp == max(max(resp)));
    [row, col] = ind2sub(size(resp), maxIdx);

    subplot(2, 1, 1)
    rectangle('Position', [row(1) col(1) winSize winSize], 'LineWidth', 2, 'EdgeColor', 'r')
    pause
end
