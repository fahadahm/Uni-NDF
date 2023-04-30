% Assess which of the three edge correction methods to use ...
function assess_edge = assess_edge(dij, dx, dy, dx2, dy2)

    % variables
    d1 = single(min(dx, dy));
    d2 = single(max(dx, dy));
    d3 = single(min(dx2, dy2));
    d4 = single(max(dx2, dy2));

    % logical statements for type of edge correction
    if (dij <= d1) % No correction
        assess_edge = 0;
    elseif (dij > d1 && dij <= d2 && dij <= d3 && dij <= d4) % Case 1
        assess_edge = 1;
    elseif (dij >= d1 && dij >= d2 && dij <= d3 && dij <= d4) % Case 2
        assess_edge = 2;
    elseif (dij >= d1 && dij >= d3 && dij <= d2 && dij <= d4) % Case 2
        assess_edge = 2;
    elseif (dij >= d1 && dij >= d2 && dij >= d3 && dij <= d4) % Case 3
        assess_edge = 3;
    end

end