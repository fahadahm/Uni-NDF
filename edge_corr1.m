% Edge correction for cases where only one border is intersected (from G and P, 1999): Case 1
function edge_corr1 = edge_corr1(d1, d)
    pie = 3.14159265358979;
    pie = single(pie);
    
    aout = 2 * acos(d1 / d);
    
    % return edge correction 1
    edge_corr1 = (2 * pie) / ((2 * pie) - aout);
    
end