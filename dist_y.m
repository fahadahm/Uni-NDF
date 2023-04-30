% Distance from point to y boundary
function dist_y = dist_y(y, ymin, ymax)
    dist_y = single(min(y - ymin, ymax - y));
end