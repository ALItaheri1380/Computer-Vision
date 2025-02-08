function out = Non_max_suppression(inp, w, h)
    rows = size(inp , 1); cols = size(inp , 2);

    w = (w - 1) / 2;
    h = (h - 1) / 2;
    out = zeros(rows, cols);
    
    for i = w+1:rows-w
        for j = h+1:cols-h
            if inp(i, j) ~= 0
                out(i, j) = (max(max(inp(i-w:i+w, j-h:j+h))) == inp(i, j)) * inp(i, j);
            end
        end
    end
end
