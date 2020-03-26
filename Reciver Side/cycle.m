function matrix_out = cycle (matrix_in, direction)
%SHIFT_ROWS  Cyclically shift the rows of the state matrix.
%
%   MATRIX_OUT = CYCLE (MATRIX_IN, 'left') 
%   cyclically shifts the last three rows of the input matrix to the left.
%   The first row is not shifted:                            [1 2 3 4]
%   The second row is cyclically shifted once to the left:   [2 3 4 1]
%   The third row is cyclically shifted twice to the left:   [3 4 1 2]
%   The fourth row is cyclically shifted thrice to the left: [4 1 2 3] 

%   MATRIX_OUT = CYCLE (MATRIX_IN, 'right') 
%   cyclically shifts the last three rows of the input matrix to the right.
%   The first row is not shifted:                             [1 2 3 4]
%   The second row is cyclically shifted once to the right:   [4 1 2 3]
%   The third row is cyclically shifted twice to the right:   [3 4 1 2]
%   The fourth row is cyclically shifted thrice to the right: [2 3 4 1] 

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% If the matrix has to be shifted to the left,
if strcmp (direction, 'left')
    
    % generate the column vector [0 5 10 15]'
    col = (0 : 5 : 15)';
    
% If the matrix has to be shifted to the right,
else
   
    % generate the column vector [16 13 10 7]'
    col = (16 : -3 : 7)';
        
end

% Generate the row vector [0 4 8 12]
row = 0 : 4 : 12;

% Repeat the column to create the matrix [ 0  0  0  0] (left shift)
%                                        [ 5  5  5  5] 
%                                        [10 10 10 10] 
%                                        [15 15 15 15] 
cols = repmat (col, 1, 4);

% Repeat the row to create the matrix [0 4 8 12]
%                                     [0 4 8 12] 
%                                     [0 4 8 12] 
%                                     [0 4 8 12] 
rows = repmat (row, 4, 1);

% Add both matrices,
% fold back into the 0 ... 15 domain,
% and add 1, because Matlab indices do start with 1
% [ 1  5  9 13]
% [ 6 10 14  2]
% [11 15  3  7]
% [16  4  8 12]
ind_mat = mod (rows + cols, 16) + 1;

% Apply the just created index matrix to the input matrix.
% Elements of the index matrix are linear (column-wise) indices.
matrix_out = matrix_in (ind_mat);