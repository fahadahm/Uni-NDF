function d = EuclDistance(x1,y1,x2,y2)
    %d = sqrt((x2-x1)^2 + (y2-y1)^2);
    d = single(sqrt(((x1 - x2)^2) + ((y1 - y2)^2)));
end