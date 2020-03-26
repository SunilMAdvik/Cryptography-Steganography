function b_out = aff_trans (b_in)
%AFF_TRANS  Apply an affine transformation over GF(2^8).
%
%   B_OUT = AFF_TRANS (B_IN)
%   applies an affine transformation to the input byte B_IN.
%   
%   The transformation consists of 
%   1. a polynomial modulo multiplication 
%      by a predefined multiplication polynomial
%      using a predefined modulo polynomial over GF(2^8) and
%   2. the addition (XOR) of a predefined addition polynomial
% 
%   B_IN has to be a byte (0 <= B_IN <= 255).

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001


% Define the modulo polynomial 
% to be used in the modulo operation in poly_mult
mod_pol = bin2dec ('100000001');

% Define the multiplication polynomial
% In the Rijndael AES Proposal 
% they say they use the polynomial '11110001',
% which is wrong.
mult_pol = bin2dec ('00011111');

% Define the addition polynomial
add_pol = bin2dec ('01100011');

% Modular polynomial multiplication 
% of the input byte and the fixed multiplication polynomial
temp = poly_mult (b_in, mult_pol, mod_pol);

% Add (XOR) the constant (addition polynomial)
b_out = bitxor (temp, add_pol);
