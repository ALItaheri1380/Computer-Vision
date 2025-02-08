function img = load_img(num, scale)
    if nargin < 2
        scale = 1;
    end

    imgPath = sprintf('sequence/2043_%06d.jpeg', num + 140);
    img = imread(imgPath);
    
    if scale ~= 1
        img = imresize(img, scale);
    end
end