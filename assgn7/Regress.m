function [px, py] = Regress(img, x, y, trees)
    px = 0;
    py = 0;
    num_trees = numel(trees);
    
    for n = 1:num_trees
        if isempty(trees{n})
            continue;
        end
        [ox, oy] = trees{n}.pred(img, x, y);
        px = px + ox;
        py = py + oy; 
    end
    
    if num_trees > 0
        px = px / num_trees;
        py = py / num_trees;
    else
        px = 0;
        py = 0;
    end
end
