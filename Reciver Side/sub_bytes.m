function bytes_out = sub_bytes (bytes_in, s_box)
%SUB_BYTES  Nonlinear byte substitution using a substitution table.
%
%   BYTES_OUT = SUB_BYTES (BYTES_IN, S_BOX) 
%   transforms the input array BYTES_IN 
%   into the output array BYTES_OUT
%   using the substitution table S_BOX.
%
%   BYTES_IN has to be an array of bytes (0 <= BYTES_IN(i) <= 255).

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Thanks to Matlab's marvellous matrix manipulation mastery,
% the substitution of a whole array can be formulated 
% in just one statement
bytes_out = s_box (bytes_in + 1);
