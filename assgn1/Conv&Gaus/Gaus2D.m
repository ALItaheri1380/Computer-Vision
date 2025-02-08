function out = Gaus2D(sigma)
    size = round(3 * sigma);
    half_size = floor(size / 2);
    
    [X, Y] = meshgrid(-half_size:half_size, -half_size:half_size);
    
    out = exp(-0.5 * (X.^2 + Y.^2) / sigma^2);
    out = out / sum(out(:));
end
