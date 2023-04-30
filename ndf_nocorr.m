function [ndf, std_ndf] = ndf_nocorr(x1, y1, st, max_step, points, area, bins)

    pie = 3.14159265358979;
    pie = single(pie);
    points = single(points);

    ndf = zeros(floor(bins), 1); % preallocate ndf vector 
    std_ndf = zeros(floor(bins),1); % preallocate std_ndf vector 

    for i = 2:points
        for j = (i + 1):points

            Distance = EuclDistance(x1(i), y1(i), x1(j), y1(j));

            if (Distance <= max_step)

                bin_class = floor(Distance / st) + 1;
                ndf(bin_class) = ndf(bin_class) + 2;  % + 2 because i to j = j to i
            end
        end
    end

    for i = 1:bins

        w = single(i * st); % True distance not bin no.
        if (i == 0)
            annuli = single((pie * st^2) * single((points-1)));
        else
            annuli = ((pie * (w)^2) - (pie * (w - st)^2)) * single((points-1));
        end

        ndf(i) = single(ndf(i) / annuli);
        std_ndf(i) = single(ndf(i) / (single((points-1)) / area));
    end
end
