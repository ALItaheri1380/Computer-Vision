clear all; close all; clc;

N = 10;
trees = cell(N, 1);

for n = 0:N-1
    id = sprintf('Tree%d.txt', n);
    trees{n+1} = Tree(id);
end

img = double(imread('Test.jpg'));
I = Cl_Intgrl_img(img);

Y = size(img, 1);
X = size(img, 2);

heat_map = zeros(Y, X);

for y = 1:Y
    disp([y Y]);
    for x = 1:X
        [px, py] = Regress(I, x, y, trees);
        
        px = round(px + x);
        py = round(py + y);
        
        if px >= 1 && px <= X && py >= 1 && py <= Y
            heat_map(py, px) = heat_map(py, px) + 1;
        end
    end
end

heat_map = heat_map / max(max(heat_map));

figure;
subplot(3, 1, 1);
imshow(img / 255);
title('Original Image');

subplot(3, 1, 2);
imshow(I / max(max(max(I))));
title('Integral Image');

subplot(3, 1, 3);
imshow(heat_map);
title('Heat Map');
