function rnd_single = rnd_single(min_val, max_val)
    % Generate a random value between min_val and max_val (single)
    
    test = false;
    if min_val == max_val
        rnd_single = min_val;
    else
        while ~test
            rnd_single = ((max_val - min_val + 1) * URnd() + min_val);
            if rnd_single >= min_val && rnd_single <= max_val
                test = true;
            end
        end
    end
end




