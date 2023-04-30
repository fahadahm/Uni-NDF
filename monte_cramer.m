% CVM = integrates the squares of the deviations from zero of the K-function for each
% value of t for all simulations. The integrals are then ranked together with the value
% calculated from the mapped data.

function monte_cramer_result = monte_cramer(list, bins, dens)

    deviations = zeros(floor(bins+1), 1);
    cList = zeros(floor(bins+1), 1);

    i = 1;
    while i <= bins 
        cList(i) = list(i) / dens;
        deviations(i) = (cList(i) - 1) ^ 2;
        i = i + 1;
    end

    monte_cramer_result = sum(deviations);
    
end
