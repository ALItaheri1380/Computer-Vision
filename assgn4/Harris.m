function [corners, varargout] = Harris(img, level, base_scale, step, factor, threshold)
    dx = [-1 0 1; -1 0 1; -1 0 1];
    dy = dx';
    
    Ix = conv2(img, dx, 'same');
    Iy = conv2(img, dy, 'same');
    
    scale = step^level * base_scale;
    filter_scale = 0.7 * scale;

    g_filter = Gaus2D(filter_scale);
    Gx = conv2(Ix, g_filter, 'same');
    Gy = conv2(Iy, g_filter, 'same');

    g_filter_2 = Gaus2D(scale);
    Gxx = filter_scale^2 * conv2(Gx .* Gx, g_filter_2, 'same');
    Gxy = filter_scale^2 * conv2(Gx .* Gy, g_filter_2, 'same');
    Gyy = filter_scale^2 * conv2(Gy .* Gy, g_filter_2, 'same');

    det = Gxx .* Gyy - Gxy.^2;
    trace = Gxx + Gyy;
    response = det - factor * trace.^2;

    response(response < threshold) = 0;
    corners = Non_max_suppression(response, 3, 3);
    varargout{1} = filter_scale;
    varargout{2} = size(g_filter);
end
