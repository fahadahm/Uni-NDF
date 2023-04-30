function [x_list, y_list] = gen_poisson(x_list, y_list, xmin, ymin, xmax, ymax, points)
    % Generate univariate CSR event set (homogeneous Poisson)

    for i = 1:points
        x_list(i) = rnd_single(xmin, xmax);
        y_list(i) = rnd_single(ymin, ymax);
    end
end
