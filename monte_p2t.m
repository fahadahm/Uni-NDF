% p value from confidence intervals (Monte Carlo evalution)
% p = (1+# random values larger than the observed value) / (1 + R).
% This is a two-tailed test. Following Crowley (1992) we use the lower of the
% counts greater and counts less than observed and divide by total no. of data arrangements.

function monte_p2t = monte_p2t(higher, reps)
    % Convert input arguments to single
    p = 0;
    higher = single(higher);
    reps = single(reps);
    counts = min(higher, (reps + 1) - higher);

    % Calculate p
    if (p < 0)
        p = 1;
    else
        p = counts / (1 + reps);
    end

    monte_p2t = p;

end
