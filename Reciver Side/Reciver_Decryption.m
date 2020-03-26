clc ;
clear all;
close all;
 
%% 1.Hybrid (AES & RSA)Decryption Algorithm.
% To get the Secret text data for Encryption...

fileID_2 = fopen('extraction.txt','r');
Extract_MSG= fscanf(fileID_2,'%d');
fclose(fileID_2);
Length_5=length(Extract_MSG);

ranka_1 = Extract_MSG(1:16); % Pull odd Part (starts at 1)
rankb_2 = Extract_MSG(17:32); % Pull even Part (starts at 17)

data_text_RSA = ranka_1;
data_text_AES = ranka_1;


%% AES ENCRYPTION ...
% Initialization
[inv_s_box, w,inv_poly_mat] = aes_init;

% Convert the ciphertext back to plaintext
% using the expanded key, the inverse S-box, 
% and the inverse polynomial transformation matrix
Extracted_AES_Text = inv_cipher (data_text_AES, w, inv_s_box, inv_poly_mat, 1);


p = input('\nEnter the value of p: ');
q = input('\nEnter the value of q: ');
[Pk,Phi,d,e] = intialize(p,q);

%Decryption
for G= 1:Length_5
   message(G)= crypt(Extract_MSG(G),Pk,d); 
end
disp('Decrypted ASCII of Message:');
disp(message(17:32));

Extracted_RSA_Text = message(17:32)

Extracted_original_msg = cat(2,Extracted_AES_Text, Extracted_RSA_Text);

disp(['Decrypted Message is: ' Extracted_original_msg]);
disp('Decrypted text file generated');
fid=fopen('readable.txt','w'); 
fprintf(fid,'%c',Extracted_original_msg); 

