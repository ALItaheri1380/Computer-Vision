function result = Harris_laplace(img, n, s0, k, alpha, t)
    [xSize, ySize] = size(img);
    corners = zeros(xSize, ySize, n);
    logs = cell(n, 2);
    
    for l = 1:n
        [c, sigmaD, mask_size] = Harris(img, l-1, s0, k, alpha, t);
        corners(:, :, l) = c;
        logs{l, 1} = flipud(fliplr(fspecial('log', mask_size, sigmaD)));
        logs{l, 2} = sigmaD;
    end
    
    pad = (size(logs{end, 1}) - 1) / 2;
    img = padarray(img, pad, 0, 'both');
    
    final_corners = zeros(size(img));
    
    for x = 1 + pad(1):xSize + pad(1)
        for y = 1 + pad(2):ySize + pad(2)
            if nnz(corners(x - pad(1), y - pad(2), :))
                r = compute_response(img, x, y, logs, n);
                final_corners(x, y) = max(r); % انتخاب بزرگ‌ترین مقدار
            end
        end
    end
    
    result = final_corners;
end

function r = compute_response(img, x, y, logs, n)
    r = zeros(n, 1);
    for k = 1:n
        log_filter = logs{k, 1};
        sigmaD = logs{k, 2};
        pad = (size(log_filter) - 1) / 2;
        
        region = img(x - pad(1):x + pad(1), y - pad(2):y + pad(2));
        r(k) = sigmaD^2 * sum(sum(region .* log_filter)); % محاسبه برای هر مقیاس
    end
end
