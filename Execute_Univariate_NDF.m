clc, clear

get_values = UnivariateNHB;

if isvalid(get_values)
    waitfor(get_values)
end

tic;
xmin = x_min;
xmax = x_max;
ymin = y_min;
ymax = y_max;
st_l = step_length;
max_step = max_s;
input_fname = input_filename;
output_fname = output_filename;
n_simulations = n_simul;

if limit_95 == 1
    limit95 = 1;
else
    limit95 = 0;
end

if limit_99 == 1
    limit99 = 1;
else
    limit99 = 0;
end

if edge_method == "On"
    edge_m = 1;
else
    edge_m = 0;
end

if sort_method == "On"
    sort_m = 1;
else
    sort_m = 0;
end

if confidence_interval == "On"
    confidence = 1;
else
    confidence = 0;
end

completion = univariateNDF(xmin, xmax, ymin, ymax, st_l, max_step, input_fname, output_fname, n_simulations, limit99, limit95, confidence, sort_m, edge_m);
disp(["=D It took the program this much time..."]);
total_time = toc;
disp(total_time);


