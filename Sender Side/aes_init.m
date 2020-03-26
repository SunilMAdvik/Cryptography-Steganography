function [s_box, w, poly_mat] = aes_init
% Clear the command window
clc

% Create the S-box and the inverse S-box
[s_box] = s_box_gen (1);

% Create the round constant array
rcon = rcon_gen (1);

% Define an arbitrary 16-byte cipher key in hexadecimal (string) representation
% The following two specific keys are used as examples 
% in the AES-Specification (draft)
key_hex = {'00' '01' '02' '03' '04' '05' '06' '07' ...
           '08' '09' '0a' '0b' '0c' '0d' '0e' '0f'};
% %key_hex = {'2b' '7e' '15' '16' '28' 'ae' 'd2' 'a6' ...
% %           'ab' 'f7' '15' '88' '09' 'cf' '4f' '3c'};


% Convert the cipher key from hexadecimal (string) to decimal representation
key = hex2dec(key_hex);

% Create the expanded key (schedule)
w = key_expansion (key, s_box, rcon, 1);

% Create the polynomial transformation matrix and the inverse polynomial matrix
% to be used in MIX_COLUMNS
[poly_mat] = poly_mat_gen (1);

