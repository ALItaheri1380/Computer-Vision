close all; clear all; clc;

numImages = 50;
maxIter = 3;

xPos = 506; yPos = 308;
width = 57; height = 47;

img = load_img(0);
patch = img(yPos:yPos + height - 1, xPos:xPos + width - 1, :);

histogramData = colorHist(patch);
probabilityMap = probMap(patch, histogramData);

[xGrid, yGrid] = meshgrid(1:width, 1:height);
xGrid = xGrid - width / 2;
yGrid = yGrid - height / 2;

totalTime = 0;

for frame = 1:numImages
    tic;
    img = load_img(frame);
    patch = img(yPos:yPos + height - 1, xPos:xPos + width - 1, :);
    
    disp([xPos, yPos]);

    for iter = 1:maxIter
        probabilityMap = probMap(patch, histogramData);
        
        denom = sum(probabilityMap(:));
        dx = sum(xGrid(:) .* probabilityMap(:)) / denom;
        dy = sum(yGrid(:) .* probabilityMap(:)) / denom;
        delta = round([dx, dy]);
        
        xPos = xPos + delta(1);
        yPos = yPos + delta(2);
        
        if norm(delta) < 2
            break;
        end
    end
    
    histogramData = colorHist(patch);
    
    totalTime = totalTime + toc;
    
    imshow(img);
    rectangle('Position', [xPos, yPos, width, height], 'EdgeColor', 'r', 'LineWidth', 2);
    drawnow;
end

fprintf('FPS = %.3f\n', numImages / totalTime);
