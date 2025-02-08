function output = convolution2D(img, kernel, border)

    [X, Y] = size(kernel);
    
    if mod(X, 2) == 0 || mod(Y, 2) == 0
        error('Kernel size must be odd.');
    end

    X = (X - 1) / 2;
    Y = (Y - 1) / 2;

    img = make_border(img, X, Y, border);
    kernel = rot90(kernel, 2);

    [N, M] = size(img);
    output = zeros(N, M);

    for x = (1 + X) : (N - X)
        for y = (1 + Y) : (M - Y)
            output(x, y) = sum(sum(img(x - X : x + X, y - Y : y + Y) .* kernel));
        end
    end

    output = output(1 + X : end - X, 1 + Y : end - Y);
end