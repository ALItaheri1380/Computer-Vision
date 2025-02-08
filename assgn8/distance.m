function dist = distance(p1, p2, H)

    p2_trans = normalize(p2 * H');
    diff = p2_trans - p1(:, 1:2);
    dist = sum(diff.^2, 2);
    
end