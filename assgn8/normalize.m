function p = normalize(p)

   p = p(:, 1:2) ./ repmat(p(:, 3), [1, 2]); 

end