function w = key_expansion (key, s_box, rcon, vargin)
%KEY_EXPANSION  Expand the 16-byte cipher key.
%
%   W = KEY_EXPANSION (KEY, S_BOX, RCON) 
%   creates the 44x4-byte expanded key W,
%   using the initial 16-byte cipher KEY, 
%   the predefined byte substitution table S_BOX, and
%   the round constant RCON to be added to every fourth 16-byte sub-key.
%
%   W = KEY_EXPANSION (KEY, S_BOX, RCON, 1) 
%   switches verbose mode on, that displays intermediate results.
%
%   KEY has to be a vector of 16 bytes (0 <= KEY(i) <= 255).
%
%   KEY_EXPANSION has to be called prior to CIPHER and INV_CIPHER.

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% If there is an optional "verbose mode" argument
if nargin > 3
    
    % Switch the verbose mode flag on
    verbose_mode = 1;
    
% If there is no optional "verbose mode" argument
else
    
    % Switch the verbose mode flag off
    verbose_mode = 0;
    
end

% If the key vector is a cell array or does not have 16 elements
if iscell (key) | prod (size (key)) ~= 16

    % Inform user and abort
    error ('Key has to be a vector (not a cell array) with 16 elements.')
    
end

% If any element of the key vector cannot be represented by 8 bits
if any (key < 0 | key > 255)
    
    % Inform user and abort
    error ('Elements of key vector have to be bytes (0 <= key(i) <= 255).')
    
end

% Display headline if requested
if verbose_mode
    disp (' ')
    disp ('********************************************')
    disp ('*                                          *')
    disp ('*        K E Y   E X P A N S I O N         *')
    disp ('*                                          *')
    disp ('********************************************')
    disp (' ')
end

% Copy the 16 elements of the key vector row-wise 
% into the first four rows of the expanded key
w = (reshape (key, 4, 4))';

% Display intermediate result if requested
if verbose_mode
    disp_hex ('w(1:4, :) :       ', w)
end
   
% Loop over the rest of the 44 rows of the expanded key
for i = 5 : 44
    
    % Copy the previous row of the expanded key into a buffer
    temp = w(i - 1, :);

    % Every fourth row is treated differently:
    if mod (i, 4) == 1
    
        % Perform a cyclic (byte-wise) permutation to the buffer
        temp = rot_word (temp);
        
        % Display intermediate result if requested
        if verbose_mode
            disp_hex (['After rot_word :  '], temp)
        end
    
        % Substitute all 4 elements of the buffer
        % by shoving them through the S-box
        temp = sub_bytes (temp, s_box);

        % Display intermediate result if requested
        if verbose_mode
            disp_hex (['After sub_bytes : '], temp)
        end
    
        % Compute the current round constant
        r = rcon ((i - 1)/4, :);

        % Display intermediate result if requested
        if verbose_mode
            disp_hex (['rcon(', num2str(i,'%02d'), ', :) :     '], r)
        end
        
        % Add (XOR) the current rount constant 
        % to every element of the buffer
        temp = bitxor (temp, r);

        % Display intermediate result if requested
        if verbose_mode
            disp_hex (['After rcon xor :  '], temp)
        end
       
    end

    % The new row of the expanded key
    % is the sum (XOR) of the row four rows before
    % and the buffer
    w(i, :) = bitxor (w(i - 4, :), temp);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex (['w(', num2str(i,'%02d'), ', :) :        '], w(i, :))
    end
    
end