function [sim_d_min, sim_b_max] = calculate_sim_results(data, resolution, server)
    yDiff_serverOption = (y_diff_2queues(data.(server{2}), data.(server{1}), cumsum(data.B0), cumsum(data.B0)));
    sim_b_max = max(yDiff_serverOption(:,2));
    sim_d_min = max(data.(server{1}) - data.(server{2})) / resolution;
end