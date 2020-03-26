function b_inv = find_inverse (b_in, mod_pol)
%FIND_INVERSE  Find the multiplicative inverse in GF(2^8).
%
%   B_INV = FIND_INVERSE (B_IN, MOD_POL) 
%   finds the multiplicative inverse of B_IN 
%   in the finite Galois field GF(2^8)
%   with respect to the predefined (irreducible modulo polynomial.
%
%   B_IN has to be a byte (0 <= B_IN <= 255).
%
%   This implementation is extremely simple, uneconomic, and slow;
%   but it works and clearly demonstrates the definition of the inverse.
%   Smarter implementations e.g. use the "extended Euclidean algorithm".

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Loop over all possible "test" bytes.
% The inverse of zero is defined as zero
for i = 1 : 255
    
    % "Test-wise" compute the polynomial multiplication 
    % of the input byte and the current "test byte"
    prod = poly_mult (b_in, i, mod_pol);

    % If the polynomial modulo multiplication leaves a remainder of "1"
    % we have found the inverse
    if prod == 1
    
        % Declare (save and return) the current test byte as inverse,
        b_inv = i;
        
        % and abort the search
        break
        
    end
    
end
