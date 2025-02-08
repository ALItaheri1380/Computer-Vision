function [node_data, leaf_data] = Load_tree(file_path)

    file_id = fopen(file_path);

    num_nodes = textscan(file_id, '%d', 1);
    raw_nodes = textscan(file_id, '%d %d %d %d %d %d %d %d %d %d %d', num_nodes{1});
    node_data = convert_to_matrix(num_nodes{1}, raw_nodes);
    
    node_data(:, 7) = adjust_channel(node_data(:, 7));
    node_data(:, 10) = adjust_channel(node_data(:, 10));
    
    num_leafs = textscan(file_id, '%d', 1);
    raw_leafs = textscan(file_id, '%d %f %f', num_leafs{1});
    leaf_data = convert_to_matrix(num_leafs{1}, raw_leafs);

    fclose(file_id);
end


function matrix = convert_to_matrix(row_count, cell_data)
    matrix = zeros(row_count, numel(cell_data));
    for col = 1:numel(cell_data)
        matrix(:, col) = cell_data{col};
    end
end

function channel = adjust_channel(channel)
    channel(channel == 3) = 2;
    channel = channel + 1;
end
