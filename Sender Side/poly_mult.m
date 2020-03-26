function ab = poly_mult (a, b, mod_pol)
%POLY_MULT  Polynomial modulo multiplication in GF(2^8).
%
%   AB = POLY_MULT (A, B, MOD_POL)
%   performs a polynomial multiplication of A and B 
%   in the finite Galois field GF(2^8),
%   using MOD_POL as the irreducible modulo polynomial.
%
%   A and B have to be bytes (0 <= A, B <= 255).
%   MOD_POL is of degree 8.

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de

%   Version 1.0     30.05.2001

% Initialize the product term
% to be used on the right-hand side of the XOR-iteration
ab = 0;

% Loop over every bit of the first factor ("a")
% starting with the least significant bit.
% This loop multiplies "a" and "b" modulo 2
for i_bit = 1 : 8

    % If the current bit is set,
    % the second factor ("b") has to be multiplied
    % by the corresponding power of 2
    if bitget (a, i_bit)
    
        % The power-2-multiplication is carried out
        % by the corresponding left shift of the second factor ("b"),
        b_shift = bitshift (b, i_bit - 1);
        
        % and the modulo 2 (XOR) "addition" of the shifted factor
        ab = bitxor (ab, b_shift);
        
    end
        
end

% Loop over the 8 most significant bits of the "ab"-product.
% This loop reduces the 16-bit-product back to the 8 bits
% of a GF(2^8) element by the use of 
% the irreducible modulo polynomial of degree 8.
for i_bit = 16 : -1 : 9
    
    % If the current bit is set,
    % "ab" (or the reduced "ab" respectively) has to be "divided"
    % by the modulo polynomial
    if bitget (ab, i_bit)
    
        % The "division" is carried out
        % by the corresponding left shift of the modulo polynomial,
        mod_pol_shift = bitshift (mod_pol, i_bit - 9);
        
        % and the "subtraction" of the shifted modulo polynomial.
        % Since both "addition" and "subtraction" are 
        % operations modulo 2 in this context,
        % both can be achieved via XOR
        ab = bitxor (ab, mod_pol_shift);
        
    end
        
end