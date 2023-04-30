function [rndx, rndy] = generate_csr(rndx, rndy, xmin, ymin, xmax, ymax, points)
    
    [rndx, rndy] = gen_poisson(rndx, rndy, xmin, ymin, xmax, ymax, points);
    rndx = sort(rndx);
    rndy = sort(rndy);

end
