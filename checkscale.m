% Check max step length vs. plot size and warn if larger than critical threshold.

function checkscale(max_step, xmin, xmax, ymin, ymax)

    if (max_step > (min_val(xmax - xmin, ymax - ymin) / 2))

        error('The maximum distance exceeds 1/2 the size of the shortest dimension. Estimates beyond this point may be suspect ...');

    end

end