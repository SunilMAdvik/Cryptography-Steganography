function [poly_mat, inv_poly_mat] = poly_mat_gen (vargin)
%POLY_MAT  Create polynomial coefficient matrices.
%
%   [POLY_MAT, INV_POLY_MAT] = POLY_MAT_GEN 
%   creates the polynomial coefficient matrices
%   to be used by the function MIX_COLUMNS.
%
%   [POLY_MAT, INV_POLY_MAT] = POLY_MAT_GEN (1)
%   switches verbose mode on, that displays intermediate results.
%
%   POLY_MAT_GEN has to be called prior to CIPHER and INV_CIPHER.

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
    disp ('*    P O L Y _ M A T   C R E A T I O N     *')
    disp ('*                                          *')
    disp ('********************************************')
    disp (' ')
end

% Define the first row of the polynomial coefficient matrix
% to be used in MIX_COLUMNS in hexadecimal representation.
% Small values are chosen for computational speed reasons
row_hex = {'02' '03' '01' '01'};

% Convert the polynomial coefficients to decimal "numbers"
% row = [2 3 1 1]
row = hex2dec (row_hex)';

% Construct a matrix with identical rows
% rows = [2 3 1 1]
%        [2 3 1 1]
%        [2 3 1 1]
%        [2 3 1 1]
rows = repmat (row, 4, 1);

% Construct the polynomial matrix
% by cyclically permuting the rows to the right
% poly_mat = [2 3 1 1]
%            [1 2 3 1]
%            [1 1 2 3]
%            [3 1 1 2]
poly_mat = cycle (rows, 'right');

% Define the first row of the inverse polynomial coefficient matrix
% to be used in INV_MIX_COLUMNS in hexadecimal representation.
inv_row_hex = {'0e' '0b' '0d' '09'};

% Convert the polynomial coefficients to decimal "numbers"
inv_row = hex2dec (inv_row_hex)';

% Construct a matrix with identical rows
inv_rows = repmat (inv_row, 4, 1);

% Construct the polynomial matrix
inv_poly_mat = cycle (inv_rows, 'right');

% Display intermediate result if requested
if verbose_mode
    disp_hex ('    poly_mat : ', poly_mat)
    disp_hex ('inv_poly_mat : ', inv_poly_mat)
end      
