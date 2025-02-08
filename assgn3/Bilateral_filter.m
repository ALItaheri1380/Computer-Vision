function out = Bilateral_filter(img, sigma)
    pad_size = round(1.5 * sigma);
    img = padarray(img, [pad_size, pad_size], 'symmetric');
    out = zeros(size(img) - 2 * pad_size);

    for i = 1:size(out, 1)
        for j = 1:size(out, 2)
            patch = img(i:i + 2 * pad_size, j:j + 2 * pad_size);
            out(i, j) = apply_bilateral(patch, sigma);
        end
    end
end

function pixel = apply_bilateral(patch, sigma)
    [X, Y] = meshgrid(-floor(size(patch, 2) / 2):floor(size(patch, 2) / 2), ...
                      -floor(size(patch, 1) / 2):floor(size(patch, 1) / 2));

    space_w = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
    center_val = patch(ceil(end / 2), ceil(end / 2));
    range_w = exp(-(patch - center_val).^2 / (2 * sigma^2));

    weights = space_w .* range_w;
    pixel = sum(patch(:) .* weights(:)) / sum(weights(:));
end
