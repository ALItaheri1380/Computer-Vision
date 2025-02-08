function [final_H, p1, p2] = RANSAC(points1, points2, t, T, N)

    num_pts = size(points1, 1);
    assert(num_pts == size(points2, 1))

    points1 = generalize(points1);
    points2 = generalize(points2);

    best_set = [];
    best_count = 0;
    
    for iter = 1:N

        sample_sz = randi([4 num_pts]);
        sample_idx = randsample(num_pts, sample_sz);

        sub_pts1 = points1(sample_idx, :);
        sub_pts2 = points2(sample_idx, :);

        H = DLT(sub_pts1, sub_pts2);

        dists = distance(points1, points2, H);
        mean(sqrt(dists))
        inliers = dists < t;
        num_inliers = sum(inliers);

        if num_inliers > T
            [final_H, p1, p2] = get_result(points1, points2, inliers);
            return
        end

        if best_count < num_inliers
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