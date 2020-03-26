function plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, vargin)
%INV_CIPHER  Convert 16 bytes of ciphertext to 16 bytes of plaintext.
%
%   PLAINTEXT = INV_CIPHER (CIPHERTEXT, W, INV_S_BOX, INV_POLY_MAT) 
%   converts CIPHERTEXT (back) to the plaintext PLAINTEXT,
%   using the expanded cipher key W, 
%   the inverse byte substitution table INV_S_BOX, and
%   the inverse transformation matrix INV_POLY_MAT.
%
%   PLAINTEXT = INV_CIPHER (CIPHERTEXT, W, INV_S_BOX, INV_POLY_MAT, 1) 
%   switches verbose mode on, that displays intermediate results.

%   CIPHERTEXT has to be a vector of 16 bytes (0 <= CIPHERTEXT(i) <= 255).
%   W has to be a [44 x 4]-matrix of bytes (0 <= W(i,j) <= 255).

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% If there is an optional "verbose mode" argument
if nargin > 4
    
    % Switch the verbose mode flag on
    verbose_mode = 1;
    
% If there is no optional "verbose mode" argument
else
    
    % Switch the verbose mode flag off
    verbose_mode = 0;
    
end

% If the input vector is a cell array or does not have 16 elements
if iscell (ciphertext) | prod (size (ciphertext)) ~= 16

    % Inform user and abort
    error ('Ciphertext has to be a vector (not a cell array) with 16 elements.')
    
end

% If any element of the input vector cannot be represented by 8 bits
if any (ciphertext < 0 | ciphertext > 255)
    
    % Inform user and abort
    error ('Elements of ciphertext vector have to be bytes (0 <= ciphertext(i) <= 255).')
    
end

% If the expanded key array is a cell arrray or does not have the correct size
if iscell (w) | any (size (w) ~= [44, 4])

    % Inform user and abort
    error ('w has to be an array (not a cell array) with [44 x 4] elements.')
    
end

% If any element of the expanded key array can not be represented by 8 bits
if any (w < 0 | w > 255)
    
    % Inform user and abort
    error ('Elements of key array w have to be bytes (0 <= w(i,j) <= 255).')
    
end

% Display headline if requested
if verbose_mode
    disp (' ')
    disp ('********************************************')
    disp ('*                                          *')
    disp ('*       I N V E R S E   C I P H E R        *')
    disp ('*                                          *')
    disp ('********************************************')
    disp (' ')
end

% Copy the 16 elements of the input vector column-wise into the 4 x 4 state matrix
state = reshape (ciphertext, 4, 4);

% Display intermediate result if requested
if verbose_mode
    disp_hex ('Initial state :                  ', state)
end
   
% Copy the last 4 rows (4 x 4 elements) of the expanded key 
% into the current round key.
% Transpose to make this column-wise
round_key = (w(41:44, :))';

% Display intermediate result if requested
if verbose_mode
    disp_hex ('Initial round key :              ', round_key)
end

% Add (xor) the current round key (matrix) to the state (matrix)
state = add_round_key (state, round_key);

% Loop over 9 rounds backwards
for i_round = 9 : -1 : 1
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex (['State at start of round ', num2str(i_round),' :      '], state)
    end
   
    % Cyclically shift the last three rows of the state matrix
    state = inv_shift_rows (state);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('After inv_shift_rows :           ', state)
    end
   
    % Substitute all 16 elements of the state matrix
    % by shoving them through the S-box
    state = sub_bytes (state, inv_s_box);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('After inv_sub_bytes :            ', state)
    end
   
    % Extract the current round key (4 x 4 matrix) from the expanded key
    round_key = (w((1:4) + 4*i_round, :))';

    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('Round key :                      ', round_key)
    end
   
    % Add (XOR) the current round key (matrix) to the state (matrix)
    state = add_round_key (state, round_key);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('After add_round_key :            ', state)
    end
    
    % Transform the columns of the state matrix via a four-term polynomial.
    % Use the same function (mix_columns) as in cipher,
    % but with the inverse polynomial matrix
    state = mix_columns (state, inv_poly_mat);
    
end

% Display intermediate result if requested
if verbose_mode
    disp_hex ('State at start of final round :  ', state)
end
   
% Cyclically shift the last three rows of the state matrix
state = inv_shift_rows (state);
    
% Display intermediate result if requested
if verbose_mode
    disp_hex ('After inv_shift_rows :           ', state)
end
  
% Substitute all 16 elements of the state matrix
% by shoving them through the inverse S-box
state = sub_bytes (state, inv_s_box);

% Display intermediate result if requested
if verbose_mode
    disp_hex ('After inv_sub_bytes :            ', state)
end

% Extract the "first" (final) round key (4 x 4 matrix) from the expanded key
round_key = (w(1:4, :))';

% Display intermediate result if requested
if verbose_mode
    disp_hex ('Round key :                      ', round_key)
end
   
% Add (xor) the current round key (matrix) to the state (matrix)
state = add_round_key (state, round_key);
    
% Display intermediate result if requested
if verbose_mode
    disp_hex ('Final state :                    ', state)
end
   
% reshape the 4 x 4 state matrix into a 16 element row vector
plaintext = reshape (state, 1, 16);


