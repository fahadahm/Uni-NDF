function [lo_ndf, hi_ndf] = extract_limits(all_rep_buffer, lo_ndf, hi_ndf, an_bins, n_simul, limit)

    % Calculate limit_n
    limit_n = ceil((limit / 2) * (n_simul + 1));

    % Ensure limit_n is at least 1
    if limit_n < 1
        limit_n = 1;
    end

    % Loop through bins and populate lo_ndf and hi_ndf
    for i = 1:an_bins
        lo_ndf(i) = all_rep_buffer(i, limit_n);
        hi_ndf(i) = all_rep_buffer(i, ((n_simul + 1) - limit_n));
    end

end



