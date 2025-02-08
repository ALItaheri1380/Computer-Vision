function result = Cl_Intgrl_img(image)
    
    height = size(image, 1);
    width = size(image, 2);
    
    result = zeros(size(image));
    result(1, 1, :) = image(1, 1, :);

    for row = 2:height
        result(row, 1, :) = result(row-1, 1, :) + image(row, 1, :);
    end

    for col = 2:width
        result(1, col, :) = result(1, col-1, :) + image(1, col, :);
    end

    for row = 2:height
        row_sum = image(row, 1, :);
        for col = 2:width
            row_sum = row_sum + image(row, col, :);
            result(row, col, :) = row_sum + result(row-1, col, :);
        end
    end
end
