clc;
disp('STEGANOGRAPY EXTRACTION FOR THESIS | SDP2');
disp('Stego-Object found');
clear all; 
close all;

Embed_IMAge=imread('Embed_IMAge.tiff'); 
figure,imshow(Embed_IMAge);
impixelinfo;
title('Stego Image');

load('Embed_IMAge.mat')
[LL1,HL1,LH1,HH1]=dwt2(Embed_IMAge,'haar');
dwt_1=[LL1,HL1;LH1,HH1];
figure,imshow(dwt_1,[]);
title('1-level decomposed cover image');

[LL2,HL2,LH2,HH2]=dwt2(LL1,'haar');
b_1=[LL2,HL2;LH2,HH2];
dwt_2=[b_1,HL1;LH1,HH1];
figure,imshow(dwt_2,[]);
title('2-level decomposed cover image');

[LL3,HL3,LH3,HH3]=dwt2(LL2,'haar');
c_1=[LL3,HL3;LH3,HH3];
cc_1=[c_1,HL2;LH2,HH2];
dwt_3=[cc_1,HL1;LH1,HH1];
figure,imshow(dwt_3,[]);
title('3-level decomposed cover image');

[Rows_3 Col_3]=size(HH3);
HH3_16 = (HH3);
Length_2 = 126; 
Length_4 = 1;


%Extraction loop
for D=1:Rows_3
    for E=1:Col_3
        if(Length_4 <= Length_2 )
          Extract(Length_4)= HH3_16(D,E);
        end
        Length_4 =Length_4+1;
    end
end

Extract_Data = uint8(Extract);

idwt_1=idwt2(LL3,HL3,LH3,HH3,'haar');
figure,imshow(idwt_1,[]);
title('3-level embedded image');

idwt_2=idwt2(idwt_1,HL2,LH2,HH2,'haar');
figure,imshow(idwt_2,[]);
title('2-level embedded image');

idwt_3=idwt2(idwt_2,HL1,LH1,HH1,'haar');
figure,imshow(idwt_3,[]);
title('3-level embedded image');

Extract=uint8(idwt_3);
figure(),imshow(Extract,[]);
impixelinfo;
title('Extracted Cover Image');
 
imwrite(Extract,'Extract.tiff');
disp('Stego-Object created');

disp('Text message extracted');
fid=fopen('extraction.txt','w'); 
for F=1:Length_2 
    fprintf(fid,'%c',Extract_Data(F)); 
end
