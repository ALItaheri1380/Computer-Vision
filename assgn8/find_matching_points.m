function [matched1, matched2] = find_matching_points(img1, img2)

    [kp1, desc1] = vl_sift(img1);
    [kp2, desc2] = vl_sift(img2);
    [pair_idx, match_scores] = vl_ubcmatch(desc1, desc2);

    [matched1, matched2] = match_points(kp1, kp2, pair_idx);   
end

function [pts1, pts2] = match_points(kp1, kp2, pair_idx)

    pts1 = kp1(1:2, pair_idx(1, :))';
    pts2 = kp2(1:2, pair_idx(2, :))';    
end
