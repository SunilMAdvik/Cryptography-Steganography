# Cryptography-Steganography
Secure Medical Data Transmission Model for IoT-based Healthcare Systems using Cryptography-Steganography Techniques. The transmission of data through any channel of communication needs strong encryption techniques for the purpose of data security.

A method to combine 2D Discrete Wavelet Transform 3 Level (2D-DWT-3L) steganography technique with a proposed cryptography (hybrid encryption AES+RSA) scheme. The proposed hybrid encryption schema is built using a combination of Advanced Encryption Standard (AES), and Rivest, Shamir, and Adleman (RSA) algorithms. The proposed model starts by encrypting the secret data; then it hides the result in a cover image using 2D-DWT-3L. 

PROPOSED METHODOLOGIES.
Encryption(cryptography):
Algorithm (1): Hybrid (AES & RSA) Algorithm.
               Inputs: secret plain Stext message.
               Output: main_cipher message , key s
Algorithm-: 
               Throughout the encryption process, the plain text T is divided into odd-part (T-ODD) even-parts (T-EVEN). 
               The AES is used to encrypt T-ODD using a secret public key s.
               The RSA is used to encrypt T-EVEN using a secret public key m.


Steganography:
Algorithm (2): Embedding 2D-DWT-2L Algorithm.
Algorithm-: Haar-DWT
            2D-DWT-2L can be formulated as a consecutive transformation using low-pass and high-pass filters.
