function output_result2(d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, filename)

    % ... add data4 through data10
    d2 = [0; d2(1:end-1)];
    d5 = [0; d5(1:end-1)];    
    % Combine all the data arrays into a cell array
    data_arrays = {d1, d2, d3, d4, d5, d6, d7, d8, d9, d10}; 
    
    % Define a function to convert row numbers to Excel ranges
    row_number_to_range = @(col, len) sprintf('%s1:%s%d', col, col, len);
    
    % Write the data arrays to an Excel file column by column
    for idx = 1:length(data_arrays)
        col_letter = char('A' + idx - 1);
        range = row_number_to_range(col_letter, length(data_arrays{idx}));
        writematrix(data_arrays{idx}, 'output.xlsx', 'Sheet', 1, 'Range', range);
    end


end