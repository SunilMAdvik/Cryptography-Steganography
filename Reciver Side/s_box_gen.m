function [s_box, inv_s_box] = s_box_gen (vargin)
%S_BOX_GEN  Create S-box and inverse S-box.
%
%   [S_BOX, INV_S_BOX] = S_BOX_GEN 
%   creates the S-box and the inverse S-box 
%   to be used by the function SUB_BYTES.
%   The S-box is created in two steps:
%   1. Take the multiplicative inverse of the finite field GF(2^8).
%   2. Apply an affine transformation.
%
%   [S_BOX, INV_S_BOX] = S_BOX_GEN (1) 
%   switches verbose mode on, that displays intermediate results.
%
%   S_BOX_GEN has to be called prior to 
%   KEY_EXPANSION, CIPHER, and INV_CIPHER.
%
%   In the AES Specification Standard the S-boxes are depicted
%   as arrays. For the sake of indexing-simplicity they are internally 
%   stored as vectors in this implementation.

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% If there is an optional "verbose mode" argument
if nargin > 0
    
    % Switch the verbose mode flag on
    verbose_mode = 1;
    
% If there is no optional "verbose mode" argument
else
    
    % Switch the verbose mode flag off
    verbose_mode = 0;
    
end

% Display headline if requested
if verbose_mode
    disp (' ')
    disp ('********************************************')
    disp ('*                                          *')
    disp ('*       S - B O X   C R E A T I O N        *')
    disp ('*                                          *')
    disp ('*   (this might take a few seconds ;-))    *')
    disp ('*                                          *')
    disp ('********************************************')
    disp (' ')
end

% Define the irreducible polynomial 
% to be used in the modulo operation in poly_mult, 
% called by find_inverse
mod_pol = bin2dec ('100011011');

% The polynomial multiplicative inverse of zero is defined here as zero.
% Matlab vectors start with an index of "1"
inverse(1) = 0;

% Loop over all remaining byte values
for i = 1 : 255
    
    % Compute the multiplicative inverse of the current byte value
    % with respect to the specified modulo polynomial
    inverse(i + 1) = find_inverse (i, mod_pol);
    
end

% Loop over all byte values
for i = 1 : 256

    % Apply the affine transformation 
    s_box(i) = aff_trans (inverse(i));

end

% Create the inverse S-box by taking the values 
% of the elements of the S-Box as indices:
inv_s_box = s_box_inversion (s_box);

% Display intermediate result if requested
if verbose_mode
    
    % Display the s_box and the inverse s_box in 16x16 matrix format.
    % Notice the transpose character for row-wise matrix representation
    s_box_mat = reshape (s_box, 16, 16)';
    disp_hex ('    s_box : ', s_box_mat)
    inv_s_box_mat = reshape (inv_s_box, 16, 16)';
    disp_hex ('inv_s_box : ', inv_s_box_mat)
    
end