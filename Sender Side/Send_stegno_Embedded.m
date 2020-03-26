clc;
clear all;
close all;


%% Read Cipher_Text File..

fid_2 = fopen('cipher.txt','rb');    
Str = fread(fid_2, [1, inf], 'char'); 
fclose(fid_2);        
Str=(Str); 
%% READ COVER IMAGE...

[filename, pathname] = uigetfile( ...
       {'*.jpg;*.tif;*.tiff;*.png;*.bmp', 'All image Files (*.jpg, *.tif, *.tiff, *.png, *.bmp)'}, ...
        'Pick a file');
fIle_1 = fullfile(pathname, filename);
disp('Reading Cover image');
disp('Cover Medium found');
%hide_pic=imread(f);  
IMAge=imread(fIle_1); 
figure,imshow(IMAge);
impixelinfo;
title('Input Cover Image');

imwrite(IMAge,'original.jpeg');

[Rows_1 Col_1 Dim]= size(IMAge);
if Dim == 3
    IMAge=rgb2gray(IMAge);
    figure,imshow(IMAge);
    impixelinfo;
    title('Input Gray Image');
end 

histogram(IMAge);


[ll1,hl1,lh1,hh1]=dwt2(IMAge,'haar');
DWT_1=[ll1,hl1;lh1,hh1];
figure,imshow(DWT_1,[]);
title('1-level decomposed cover image');

[ll2,hl2,lh2,hh2]=dwt2(ll1,'haar');
b=[ll2,hl2;lh2,hh2];
DWT_2=[b,hl1;lh1,hh1];
figure,imshow(DWT_2,[]);
title('2-level decomposed cover image');

[ll3,hl3,lh3,hh3]=dwt2(ll2,'haar');
c=[ll3,hl3;lh3,hh3];
cc=[c,hl2;lh2,hh2];
DWT_3=[cc,hl1;lh1,hh1];
figure,imshow(DWT_3,[]);
title('3-level decomposed cover image');

[Rows_2 Col_2]=size(hh3);
hh3_16 = (hh3);
Length_2 = numel(Str); 
Length_3 = 1;

%embedding loop
for B=1:Rows_2
    for C=1:Col_2
        if(Length_3 <= Length_2)
            EMBED_16(B,C) = Str(Length_3);
        else 
            EMBED_16(B,C) = hh3_16(B,C);
        end
        Length_3 =Length_3+1;
    end
end

EMBED = (EMBED_16);

IDWT_1=idwt2(ll3,hl3,lh3,EMBED,'haar');
figure,imshow(IDWT_1,[]);
title('3-level embedded image');

IDWT_2=idwt2(IDWT_1,hl2,lh2,hh2,'haar');
figure,imshow(IDWT_2,[]);
title('2-level embedded image');

IDWT_3=idwt2(IDWT_2,hl1,lh1,hh1,'haar');
figure,imshow(IDWT_3,[]);
title('3-level embedded image');

Embed_IMAge=(IDWT_3);
save('Embed_IMAge.mat','Embed_IMAge')

Embed_IMAge=uint8(IDWT_3);
histogram(Embed_IMAge);
figure(),imshow(Embed_IMAge,[]);
impixelinfo;
title('Embedded Cover Image');

imwrite(Embed_IMAge,'Embed_IMAge.tiff');
disp('Stego-Object created');

PSNR =psnr(IMAge,Embed_IMAge);
SSIM=ssim(IMAge,Embed_IMAge);
err = immse(IMAge,Embed_IMAge);
Correlation = corr2(IMAge,Embed_IMAge);

fprintf('PSNR= %f - SSIM= %f\n MSE= %f\n',PSNR,SSIM,err);
fprintf('Correlation= %f \n',Correlation);

