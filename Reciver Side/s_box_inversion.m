function inv_s_box = s_box_inversion (s_box)
%S_BOX_INVERSION  Invert S-box.
%
%   [INV_S_BOX] = S_BOX_INVERSION (S_BOX) 
%   creates the inverse S-box
%   from the previously created S-box.

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001


% Loop over all byte values
for i = 1 : 256

    % Create the inverse S-box by taking the values 
    % of the elements of the S-Box as indices:
    % e.g.: s_box(00hex) = 63hex   ==>   inv_s_box(63hex) = 00hex
    % (except the fact, that Matlab vectors start at 1...)
    inv_s_box(s_box(i) + 1) = i - 1;

end

