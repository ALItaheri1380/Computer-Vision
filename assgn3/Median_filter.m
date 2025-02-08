function out = Median_filter(img, filter_size)
    if numel(filter_size) == 1
        h = filter_size;
        w = filter_size;
    else
        h = filter_size(1);
        w = filter_size(2);
    end
    
    pad_h = floor(h / 2);
    pad_w = floor(w / 2);
    
    img_padded = padarray(img, [pad_h, pad_w], 'symmetric');
    out = zeros(size(img));  
    
    for i = 1:size(img, 1)
        for j = 1:size(img, 2)
            patch = img_padded(i:i+h-1, j:j+w-1);
            out(i, j) = median(patch(:));
        end
    end
end
