function state_out = inv_shift_rows (state_in)
%INV_SHIFT_ROWS  Cyclically shift (back) the rows of the state matrix.
%
%   STATE_OUT = INV_SHIFT_ROWS (STATE_IN) 
%   cyclically shifts the last three rows fo the state matrix to the right.
%   The first row is not shifted:                             [1 2 3 4]
%   The second row is cyclically shifted once to the right:   [4 1 2 3]
%   The third row is cyclically shifted twice to the right:   [3 4 1 2]
%   The fourth row is cyclically shifted thrice to the right: [2 3 4 1]

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Call the function cycle to do the actual right shifting
state_out = cycle (state_in, 'right');
