%%% Main Script
function complete = univariateNDF(x_min, x_max, y_min, y_max, st_l, max_st, input_fname, output_fname, n_simulations, limit99, limit95, confidence, sort_m, edge_m)
    
    % load data 
    data = importdata(input_fname);
    x1 = data(:,1);
    y1 = data(:,2);
    % st is the enter Step length (w)
    st = single(st_l);
    max_step = single(max_st);
    xmin = single(min(x1));
    xmax = single(max(x1));
    ymin = single(min(y1));
    ymax = single(max(y1));
    points = int32(length(x1));
    n_simul = int32(n_simulations);
    
    % choose method of edge correction, Sorting, Bygroups, Label
    method = edge_m;
    sort_method = sort_m;
    % bygroups_method = ChooseBygroups();
    confidenceintervals_method = confidence;

    if confidenceintervals_method == 1
        if limit99 == 1
            limit = .01;
        elseif limit95 == 1
            limit = .05;
        else
            limit = 1;
        end
    end
    
    % Check if the input scale is valid
    % checkscale(max_step, xmin, xmax, ymin, ymax);
    
    area = single((xmax - xmin) * (ymax - ymin));
    mean_dens = (single(points))/(single(area));
    an_bins = ceil(max_step/st) + 1;
    
    if ((an_bins*st) > (max_step+st))
        an_bins = an_bins - 1;
    end
    
    % Sort if sort method is true)
    % && (bygroups_method == 0)
    if (sort_method == 1) 
        x1 = sort(x1);
    end
    
    %elseif (sort_method == 1) && (bygroups_method == 1)
     %   x1 = sort(x1);
     %   y1 = sort(y1);
        % bygroups method not implemented yet 
        % sort_points(x1, y1, points, xcol, 1, strow);
    %end
    
    % perform NDF analysis 
    if method == 1 % NDF with edge corrections 
        [ndf, std_ndf] = ndf_ew(x1, y1, st, max_step, points, xmin, xmax, ymin, ymax, an_bins);
    else % without edge corrections 
        [ndf, std_ndf] = ndf_nocorr(x1, y1, st, max_step, points, area, an_bins);
    end
    
    if (confidenceintervals_method == 1) && (n_simul > 1)
    
        % Initialize variables
        buffer_ndf = zeros(an_bins, 1);
        std_buffer_ndf = zeros(an_bins, 1);
        all_rep_buffer = -999999999 * ones(an_bins, n_simul);
        cramer_list = zeros(n_simul, 1);
        supremum_list = zeros(n_simul, 1);
        rndx = zeros(points, 1);
        rndy = zeros(points, 1);
    
        cramer = monte_cramer(ndf, an_bins, mean_dens);
        supremum = monte_supremum(ndf, an_bins, mean_dens);
    
        for rep = 1:n_simul
    
            [rndx, rndy] = generate_csr(rndx, rndy, xmin, ymin, xmax, ymax, points);
    
            buffer_ndf = zeros(an_bins, 1);
            std_buffer_ndf = zeros(an_bins, 1);
    
            if edge_m == 0
                [buffer_ndf, std_buffer_ndf] = ndf_nocorr(rndx, rndy, st, max_step, points, area, an_bins);
            elseif edge_m == 1
                [buffer_ndf, std_buffer_ndf] = ndf_ew(rndx, rndy, st, max_step, points, xmin, xmax, ymin, ymax, an_bins);
            end
    
            for c = 1:an_bins
                all_rep_buffer(c, rep) = buffer_ndf(c);
            end
    
            cramer_list(rep) = monte_cramer(buffer_ndf, an_bins, mean_dens);
            supremum_list(rep) = monte_supremum(buffer_ndf, an_bins, mean_dens);
        end
    
        sorted_all_rep = sortrows(all_rep_buffer);
        all_rep_buffer = sorted_all_rep;
    
        lo_ndf = zeros(an_bins, 1);
        hi_ndf = zeros(an_bins, 1);
        std_lo_ndf = zeros(an_bins, 1);
        std_hi_ndf = zeros(an_bins, 1);
    
        [lo_ndf, hi_ndf] = extract_limits(all_rep_buffer, lo_ndf, hi_ndf, an_bins, n_simul, limit);
    
        cramer_list = sort(cramer_list, 'descend');
        position_cramer = find(cramer_list == cramer);
    
        supremum_list = sort(supremum_list, 'descend');
        position_supremum = find(supremum_list == supremum);
    
        cramer_p = monte_p2t(position_cramer, n_simul);
        cramer_ave = mean(cramer_list);
        cramer_var = var(cramer_list);
    
        supremum_p = monte_p2t(position_supremum, n_simul);
        supremum_ave = mean(supremum_list);
        supremum_var = var(supremum_list);
    
        for c = 1:an_bins
            std_lo_ndf(c) = lo_ndf(c) / mean_dens;
            std_hi_ndf(c) = hi_ndf(c) / mean_dens;
        end

        cramer_var = cramer_var^0.5;
        supremum_var = supremum_var^0.5;
        name_c = 'Cramer-von-Mises';
        name_s = 'Supremum';
        name_result_cramer = {name_c; cramer; cramer_p; cramer_ave; cramer_var};
        name_result_supremum = {name_s; supremum; supremum_p; supremum_ave; supremum_var};
        name_result_column = {''; 'Obs. Value'; 'p-value'; 'Sim. Average'; 'Sim. SD'};
    end
    
    
    st_max_step_intervals = (0:st:max_step)';
    

    
    if (confidenceintervals_method == 1) && (n_simul > 1)
    
        output_result2(st_max_step_intervals, ndf, lo_ndf, hi_ndf, std_ndf, std_lo_ndf, std_hi_ndf,name_result_column, name_result_supremum, name_result_cramer, output_fname );
        %, name_result_column, name_result_supremum, name_result_cramer, output_fname);
    
    else
        output_result(st_max_step_intervals, ndf, std_ndf, output_fname);
    
    end
    
    disp(['Analysis Complete, File has been saved locally as ' output_fname]);

    complete = 1;

end


