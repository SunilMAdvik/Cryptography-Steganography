function disp_hex (string, hex_array)
%DISP_HEX  Display an array in hexadecimal form.
%
%   DISP_HEX (STRING, HEX_ARRAY)
%   displays the hexadecimal representation 
%   of the array (matrix) HEX_ARRAY 
%   displaying STRING as the array name (title).
%
%   This is just a quick-and-dirty implementation
%   without any sophisticated error management.

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Find the numbers of rows and columns of the array to be displayed
[n_hex_array, m_hex_array] = size (hex_array);

% Find the length of the "title" string
n_string = length (string);

% Create an empty string of the length of the title string
empty_string = ones (1, n_string)*' ';

%Loop over every row of the array
for i = 1 : n_hex_array

    % If we are talking about the first row,
    if i == 1
    
        % display the title string (later)
        line = string;
        
    % If we are not talking about the first row,
    else
        
        % do not display the title string (later)
        line = empty_string;
        
    end
    
    % Loop over every column of the array
    for j = 1 : m_hex_array
    
        % Append the hexadecimal representation of the current array element
        line = [line, lower(dec2hex(hex_array(i,j),2)), ' '];

    end

    % Display the assembled line
    disp (line)
    
end

% Display an empty (separating) line
disp (' ')