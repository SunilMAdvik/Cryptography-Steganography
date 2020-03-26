clc ;
clear all;
close all;

%% 1.Hybrid (AES & RSA) Algorithm.
% To get the Secret text data for Encryption...
[file path]=uigetfile('*.txt','choose txt file');
if isequal(file,0) || isequal(path,0)
    warndlg('User Pressed Cancel');
else
    data1=fopen(file,'r');
    D=fread(data1);
    fclose(data1);
end
% ascii_value = uint8(D);
ranka = D(1:16); % Pull odd Part (starts at 1)
rankb = D(17:32); % Pull even Part (starts at 17)

data_text_AES = ranka;
data_text_RSA = rankb;

%% AES ENCRYPTION ...
[s_box, w, poly_mat] = aes_init;

% Convert plaintext from hexadecimal (string) to decimal representation
plaintext_AES = data_text_AES;
% Convert the plaintext to ciphertext,
% using the expanded key, the S-box, and the polynomial transformation matrix
ciphertext_AES = cipher (plaintext_AES, w, s_box, poly_mat, 1);
%%  RSA ENCRYPTION...
disp('Implementation of RSA Algorithm');
p = input('\nEnter the value of p: ');
q = input('\nEnter the value of q: ');
[Pk,Phi,d,e] = intialize(p,q);
[N,Phi,d,e] = intialize(p,q);
MAsg = data_text_RSA;
Length_1=length(MAsg);
% % %Encryption
for A= 1:Length_1
   cipher_RSA(A)= crypt(MAsg(A),N,e); 
end
disp('Cipher_RSA Text of the entered Message:');
disp(cipher_RSA);

%% Hybrid BOTH CIPHER TEXT..
Cipher_Test = cat(2,ciphertext_AES, cipher_RSA);

disp('Cipher Text of the Original Message:');
disp(Cipher_Test);

disp('Cipher text generated');
fid_1=fopen('cipher.txt','w'); 
fprintf(fid_1,'%d ',Cipher_Test); 