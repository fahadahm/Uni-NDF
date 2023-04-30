function output_result(A, B, C, filename)

    B = [0; B(1:end-1)];
    C = [0; C(1:end-1)];
    % Concatenate arrays
    D = [A, B, C];

    % Open the file in write mode
    fileID = fopen(filename, 'w');

    % Write the arrays to the text file as columns
    for i = 1:length(A)
        fprintf(fileID, '%.0f\t%.9f\t%.6f\n', A(i), B(i), C(i));
    end

    % Close the file
    fclose(fileID);
end
