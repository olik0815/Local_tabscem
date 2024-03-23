function [result, possible_bottlenecks] = nc_calc_iterativ(timestamps_in, packet_sizes_in, timestamps_out, packet_sizes_out, resolution)
    timestamps_in = timestamps_in./resolution;
    timestamps_out = timestamps_out./resolution;
    arrival_rate = (sum(packet_sizes_in))/(timestamps_in(end) - timestamps_in(1));
    output_rate = (sum(packet_sizes_out))/(timestamps_out(end) - timestamps_out(1));
    out_timestamps = [];
    out_packets = [];
    backlog = 0;
    result.max_burst = 0;
    result.mean_arrival_rate = arrival_rate;
    result.mean_output_rate = output_rate;
    result.max_delay = 0;
    result.max_backlog = 0;
    result.min_service_rate = Inf;
    result.max_service_rate = 0;
    result.mean_service_rate = [];
    result.min_latency = Inf;
    result.max_latency = 0;
    prev_latency = 0;
    possible_bottlenecks = [];

    % iterate through all packets
    for k=1:length(timestamps_in)
        % fill backlog with each incoming packet; have backlog queue for
        % timestamps and packet sizes
        backlog = backlog + packet_sizes_in(k);
        out_timestamps(end+1) = timestamps_out(k);
        out_packets(end+1) = packet_sizes_out(k);
        first_while_loop_iteration = false;
        % remove packets from backlog as long there timestamp is older than
        % the one of the latest incoming packet (current one in for loop)
        while length(out_timestamps) > 1 && (out_timestamps(1) <= timestamps_in(k) || k == length(timestamps_in))
            window_size = length(out_timestamps) - 1;
            % compute parameters in window
            [window_result] = nc_calc_iterativ_window(timestamps_in(k-window_size:k), packet_sizes_in(k-window_size:k), timestamps_out(k-window_size:k), packet_sizes_out(k-window_size:k), backlog, arrival_rate, k);
            % refresh backlog
            backlog = backlog - out_packets(1);
            out_packets = out_packets(2:end);
            out_timestamps = out_timestamps(2:end);
            if (window_result.burst > result.max_burst); result.max_burst = window_result.burst; end
            if (window_result.delay > result.max_delay); result.max_delay = window_result.delay; end
            if (window_result.backlog > result.max_backlog); result.max_backlog = window_result.backlog; end
            if (window_result.service_rate < result.min_service_rate); result.min_service_rate = window_result.service_rate; end
            if (window_result.service_rate > result.max_service_rate); result.max_service_rate = window_result.service_rate; end
            if (window_result.latency < result.min_latency); result.min_latency = window_result.latency; end
            if (window_result.latency > result.max_latency); result.max_latency = window_result.latency; end
            if (~isnan(window_result.service_rate) && isfinite(window_result.service_rate)); result.mean_service_rate(end+1) = window_result.service_rate; end

            % 1. a_r > s_r
            % 2. Latency ist im Window wieder gestiegen
            % 3. Backlog auch gerade am Steigen gewesen (also erste Runde
            % in while loop)
            if window_result.service_rate < arrival_rate && first_while_loop_iteration == false && window_result.latency > prev_latency
                first_while_loop_iteration = true;
                possible_bottlenecks(end+1) = k;
            end
            prev_latency = window_result.latency;
        end
    end
    result.mean_service_rate = mean(result.mean_service_rate);
end

function [result] = nc_calc_iterativ_window(timestamps_in, packet_sizes_in, timestamps_out, packet_sizes_out, backlog, arrival_rate, k1)
    curr_arrived_bytes = 0;
    burst = packet_sizes_in(1);
    delay = 0;
    min_neg_burst_diff = -packet_sizes_in(1);
    max_post_burst_diff = 0;
    %arrival_rate = total_bytes/(timestamps_in(end) - timestamps_in(1));
    % go through packets of window and adjust the burst
    for k=1:length(timestamps_in)
        curr_arrived_bytes = curr_arrived_bytes + packet_sizes_in(k);
        expected_value = arrival_rate * (timestamps_in(k) - timestamps_in(1)) + burst;
        if expected_value < curr_arrived_bytes && curr_arrived_bytes - expected_value > max_post_burst_diff
            max_post_burst_diff = curr_arrived_bytes - expected_value;
        elseif expected_value > curr_arrived_bytes && curr_arrived_bytes - expected_value > min_neg_burst_diff
            min_neg_burst_diff = curr_arrived_bytes - expected_value;
        end
        % take maximum delay of window as window delay
        if timestamps_out(k) - timestamps_in(k) > delay
            delay = timestamps_out(k) - timestamps_in(k);
        end
    end
    % adjust burst based on whether it needs to be increased or decreased
    if max_post_burst_diff > 0
        burst = burst + max_post_burst_diff;
    else
        burst = burst + min_neg_burst_diff;
    end

    % for cases where burst exceeds backlog; adjust backlog
    if backlog < burst
        backlog = burst;
    end
    % increase burst as long as delay is smaller than latency
    latency_smaller_than_delay = false;
    while latency_smaller_than_delay ~= true && burst + 1 < backlog
        latency = (backlog - burst)/arrival_rate;
        if latency < delay
            latency_smaller_than_delay = true;
        end
        %burst = burst + (backlog - burst)/2;
        burst = burst + 1;
    end
    if latency >= 0 && burst ~= 0 && delay ~= 0
        service_rate = burst/(delay - latency);
    elseif burst == 0 || delay == latency || delay == 0
        service_rate = Inf;
    else
        service_rate = NaN;
    end

    result.burst = burst;
    result.arrival_rate = arrival_rate;
    result.delay = delay;
    result.backlog = backlog;
    result.service_rate = service_rate;
    result.latency = latency;
end