% Ripley’s supremum determines the (absolute) maximum value of the K-function for each
% value of t over all simulations which are then ranked together with the value calculated
% for the mapped data.  It is a modification of the general Kolmogrov-Smirnov which is
% given by sup |obs - theor| over all t ...

function monte_supremum_result = monte_supremum(list, bins, dens)

    cList = zeros(floor(bins+1), 1);
    sup = 0;

    for i = 1:bins
        cList(i) = list(i) / dens;
        if (abs(cList(i) - 1) > sup)
            sup = abs(cList(i) - 1);
        end
    end

    monte_supremum_result = sup;
    
end