function [inv_s_box, w,inv_poly_mat] = aes_init;
%AES_INIT  Initialisation of AES-components.
%
%   [S_BOX, INV_S_BOX, W, POLY_MAT, INV_POLY_MAT] = AES_INIT
%   initializes AES-components 
%   to be used by subsequent functions.
%
%   In the initialization step the S-boxes (S_BOX and INV_S_BOX) 
%   and the polynomial matrices (POLY_MAT and INV_POLY_MAT)
%   are created and
%   an example cipher key is expanded into 
%   the round key schedule (W).

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Clear the command window
clc

% Create the S-box and the inverse S-box
[s_box, inv_s_box] = s_box_gen (1);

% Create the round constant array
rcon = rcon_gen (1);

% Define an arbitrary 16-byte cipher key in hexadecimal (string) representation
% The following two specific keys are used as examples 
% in the AES-Specification (draft)
key_hex = {'00' '01' '02' '03' '04' '05' '06' '07' ...
           '08' '09' '0a' '0b' '0c' '0d' '0e' '0f'};
%key_hex = {'2b' '7e' '15' '16' '28' 'ae' 'd2' 'a6' ...
%           'ab' 'f7' '15' '88' '09' 'cf' '4f' '3c'};

% Convert the cipher key from hexadecimal (string) to decimal representation
key = hex2dec(key_hex);

% Create the expanded key (schedule)
w = key_expansion (key, s_box, rcon, 1);

% Create the polynomial transformation matrix and the inverse polynomial matrix
% to be used in MIX_COLUMNS
[poly_mat, inv_poly_mat] = poly_mat_gen (1);