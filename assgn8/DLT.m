function H = DLT(X1, X2)

    num_pts = size(X1, 1);
    assert(num_pts == size(X2, 1))
    assert(num_pts >= 4)

    norm_mat1 = normalization_matrix(X1);
    norm_mat2 = normalization_matrix(X2);

    X1 = X1 * norm_mat1';
    X2 = X2 * norm_mat2';

    A = zeros(2 * num_pts, 9);

    for i = 1:num_pts
        A(2*i - 1, 4:6) = -X1(i, 3) * X2(i, :);
        A(2*i - 1, 7:9) = X1(i, 2) * X2(i, :);
        A(2*i, 1:3) = X1(i, 3) * X2(i, :);
        A(2*i, 7:9) = -X1(i, 1) * X2(i, :);
    end

    [~, ~, V] = svd(A);

    h_vec = V(:, end);
    H = reshape(h_vec, 3, 3)';

    H = norm_mat1^-1 * H * norm_mat2;
end 

function norm_mat = normalization_matrix(X)

    norm_mat = eye(3);
    norm_mat(1:2, 3) = -mean(X(:, 1:2))';
    scale = (mean(sqrt(sum((X * norm_mat').^2, 2))) / sqrt(2))^-1;
    norm_mat = scale * norm_mat;
end
