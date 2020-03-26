function ciphertext = cipher (plaintext, w, s_box, poly_mat, vargin)
%CIPHER  Convert 16 bytes of plaintext to 16 bytes of ciphertext.
%
%   CIPHERTEXT = CIPHER (PLAINTEXT, W, S_BOX, POLY_MAT) 
%   converts PLAINTEXT to CIPHERTEXT,
%   using the expanded cipher key W, 
%   the byte substitution table S_BOX, and
%   the transformation matrix POLY_MAT.
%
%   CIPHERTEXT = CIPHER (PLAINTEXT, W, S_BOX, POLY_MAT, 1) 
%   switches verbose mode on, which displays intermediate results.
%
%   PLAINTEXT has to be a vector of 16 bytes (0 <= PLAINTEXT(i) <= 255).
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
if iscell (plaintext) | prod (size (plaintext)) ~= 16

    % Inform user and abort
    error ('Plaintext has to be a vector (not a cell array) with 16 elements.')
    
end

% If any element of the input vector cannot be represented by 8 bits
if any (plaintext < 0 | plaintext > 255)
    
    % Inform user and abort
    error ('Elements of plaintext vector have to be bytes (0 <= plaintext(i) <= 255).')
    
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
    disp ('*               C I P H E R                *')
    disp ('*                                          *')
    disp ('********************************************')
    disp (' ')
end

% Copy the 16 elements of the input vector 
% column-wise into the 4 x 4 state matrix
state = reshape (plaintext, 4, 4);

% Display intermediate result if requested
if verbose_mode
    disp_hex ('Initial state :                  ', state)
end
   
% Copy the first 4 rows (4 x 4 elements) of the expanded key 
% into the current round key.
% Transpose to make this column-wise
round_key = (w(1:4, :))';

% Display intermediate result if requested
if verbose_mode
    disp_hex ('Initial round key :              ', round_key)
end

% Add (xor) the current round key (matrix) to the state (matrix)
state = add_round_key (state, round_key);

% Loop over 9 rounds
for i_round = 1 : 9
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex (['State at start of round ', num2str(i_round),' :      '], state)
    end
   
    % Substitute all 16 elements of the state matrix
    % by shoving them through the S-box
    state = sub_bytes (state, s_box);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('After sub_bytes :                ', state)
    end
   
    % Cyclically shift the last three rows of the state matrix
    state = shift_rows (state);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('After shift_rows :               ', state)
    end
   
    % Transform the columns of the state matrix via a four-term polynomial
    state = mix_columns (state, poly_mat);
    
    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('After mix_columns :              ', state)
    end
   
    % Extract the current round key (4 x 4 matrix) from the expanded key
    round_key = (w((1:4) + 4*i_round, :))';

    % Display intermediate result if requested
    if verbose_mode
        disp_hex ('Round key :                      ', round_key)
    end
   
    % Add (XOR) the current round key (matrix) to the state (matrix)
    state = add_round_key (state, round_key);
    
end

% Display intermediate result if requested
if verbose_mode
    disp_hex ('State at start of final round :  ', state)
end
   
% Substitute all 16 elements of the state matrix
% by shoving them through the S-box
state = sub_bytes (state, s_box);

% Display intermediate result if requested
if verbose_mode
    disp_hex ('After sub_bytes :                ', state)
end

% Cyclically shift the last three rows of the state matrix
state = shift_rows (state);
    
% Display intermediate result if requested
if verbose_mode
    disp_hex ('After shift_rows :               ', state)
end
  
% Extract the last round key (4 x 4 matrix) from the expanded key
round_key = (w(41:44, :))';

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
ciphertext = reshape (state, 1, 16);