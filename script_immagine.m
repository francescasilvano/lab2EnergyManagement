A= imread("im4.tiff");
%crea l'immagine e la inserisce in una matrice
imshow(A)
%visualizza l'immagine
imwrite(A,"filename.bmp")
%salva l'immagine A in un file immagine
B= uint8(0.8*A);
% B sarà A più dark this save some power
imshow(A(:,:,1))
%red component
imshow(A(:,:,2))
%green component
imshow(A(:,:,3))
%blue component
B(:,:,2)=0; %elimino la componente verde
A2=rgb2hsv(A);
%traduce A da rgb a hsv
Bright= A(:,:,3);
%takes only the brightness
Corr_bright=histeq(Bright);
%correct the brightness consigliata di farlo in modo da modificare poi
%l'immagine per salvare più power
A2(:,:,3)= Corr_bright;
A3=hsv2rgb(A2);
%traduce da hsv a rgb
imshow(A3);
%RedGreenBlue 
%sono valori che variano da 0 a 255
