function [final_H, p1, p2] = adaptive_RANSAC(points1, points2, t)

    num_pts = size(points1, 1);
    assert(num_pts == size(points2, 1))

    points1 = generalize(points1);
    points2 = generalize(points2);

    max_iter = realmax;
    iter_count = 0;

    best_set = [];
    best_size = 0;
    while max_iter >= iter_count;

        sample_sz = randi([4 num_pts]);
        sample_idx = randsample(num_pts, sample_sz);

        sub_pts1 = points1(sample_idx, :);
        sub_pts2 = points2(sample_idx, :);

        H = DLT(sub_pts1, sub_pts2);

        dists = distance(points1, points2, H);
        mean(sqrt(dists))
        inliers = dists < t;
        num_inliers = sum(inliers);

        ratio = num_inliers / num_pts;
        max_iter = log(0.01) / log(1 - ratio^sample_sz);
        iter_count = iter_count + 1;

        if best_size < num_inliers
            best_set = inliers;
        end

    end

    [final_H, p1, p2] = get_result(points1, points2, best_set);

end


function [H, p1, p2] = get_result(p1, p2, inliers)
    p1 = p1(inliers, :);
    p2 = p2(inliers, :);
    H = DLT(p1, p2);

    p1 = normalize(p1);
    p2 = normalize(p2);
end
