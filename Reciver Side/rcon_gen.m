function rcon = rcon_gen (vargin)
%RCON_GEN  Create round constants.
%
%   RCON = RCON_GEN 
%   creates the round constants vector RCON
%   to be used by the function KEY_EXPANSION.
%
%   RCON = RCON_GEN (1)
%   switches verbose mode on, that displays intermediate results.
%
%   RCON_GEN has to be called prior to KEY_EXPANSION.

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
    disp ('*        R C O N   C R E A T I O N         *')
    disp ('*                                          *')
    disp ('********************************************')
    disp (' ')
end

% Define the irreducible polynomial 
% to be used in the modulo operation in poly_mult
mod_pol = bin2dec ('100011011');

% The (first byte of the) first round constant is a "1"
rcon(1) = 1;

% Loop over the rest of the elements of the round constant vector
for i = 2 : 10

    % The next round constant is twice the previous one; modulo 
    rcon(i) = poly_mult (rcon(i-1), 2, mod_pol);
    
end

% The other (LSB) three bytes of all round constants are zeros
rcon = [rcon(:), zeros(10, 3)];

% Display intermediate result if requested
if verbose_mode
    disp_hex ('rcon : ', rcon)
end      
