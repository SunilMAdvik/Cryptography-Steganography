function state_out = shift_rows (state_in)
%SHIFT_ROWS  Cyclically shift the rows of the state matrix.
%
%   STATE_OUT = SHIFT_ROWS (STATE_IN) 
%   cyclically shifts the last three rows of the state matrix to the left.
%   The first row is not shifted:                            [1 2 3 4]
%   The second row is cyclically shifted once to the left:   [2 3 4 1]
%   The third row is cyclically shifted twice to the left:   [3 4 1 2]
%   The fourth row is cyclically shifted thrice to the left: [4 1 2 3] 

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Call the function cycle to do the actual left shifting
state_out = cycle (state_in, 'left');
