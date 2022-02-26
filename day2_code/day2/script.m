clear all

SATURATED = 1;
%read the image
image_read=imread("im9.tiff");
%analisi: più vdd è bassa più saturerà in fretta e il bianco sarà sempre
%meno bianco, prendendo quindi Vdd basse si avrà un ottimo effetto del
%power consuming
%per rendere l'immagine quindi più visibile e risparmiare power (aumentando in questo caso la
%distortion) si può giocare con il prendere b_scaling più alto (sempre <1)
%in modo da aggiungere luminosità (a discapito del nero essendo un valore
%che si aggiunge) in questo caso il pixel saturerà più in fretta
%prendendo invece b_enhancement si aumenta il valore del pixel moltiplicando quindi la retta
%dei valori aumenta il suo coefficiente partendo comunque dal nero (in
%questo caso quindi meglio) ma arrivando al bianco più in fretta e quindi
%saturando prima
%in sintesi più diminuisce Vdd più i valori b_enhancement e b_scaling
%devono aumentare
Vdd = 13;
VddMax=15;
b_brightness_scaling=0.8-Vdd/VddMax;
b_contrast_enhancement=VddMax/Vdd-0.1;
b_mix=Vdd/VddMax;
%transform the image in current
I_cell_sample=rgb2current(image_read);
%get displayed RGB image with cell current and supply voltage with two mode
image_RGB_saturated = displayed_image(I_cell_sample, Vdd, SATURATED); 
image_RGB_saturated=image_RGB_saturated/255;

%brightness_scaling
image_bright_modified=brightness_scaling(image_read,b_brightness_scaling);
imwrite(image_bright_modified,"tmp.jpg");
image_bright_modified=imread("tmp.jpg");
I_cell_sample=rgb2current(image_bright_modified);
image_DVS_BS_saturated=displayed_image(I_cell_sample, Vdd-1, SATURATED);
image_DVS_BS_saturated=image_DVS_BS_saturated/255;
imshow(image_DVS_BS_saturated);

%Contrast enhancement
image_bright_modified=contrast_enhancement(image_read,b_contrast_enhancement);
imwrite(image_bright_modified,"tmp.jpg");
image_bright_modified=imread("tmp.jpg");
I_cell_sample=rgb2current(image_bright_modified);
image_DVS_CE_saturated=displayed_image(I_cell_sample, Vdd-1, SATURATED);
image_DVS_CE_saturated=image_DVS_CE_saturated/255;

%modify both
image_bright_modified=brightness_scaling(image_read,b_brightness_scaling);
image_bright_modified=contrast_enhancement(image_bright_modified,b_mix);
imwrite(image_bright_modified,"tmp.jpg");
image_bright_modified=imread("tmp.jpg");
I_cell_sample=rgb2current(image_bright_modified);
image_DVS_CE_BS_saturated=displayed_image(I_cell_sample, Vdd-1, SATURATED);
image_DVS_CE_BS_saturated=image_DVS_CE_BS_saturated/255;

%histogram equalization
image_histogram=histogram_equalization(image_read);
imwrite(image_histogram,"tmp.jpg");
image_histogram=imread("tmp.jpg");
I_cell_sample=rgb2current(image_histogram);
image_HS_saturated=displayed_image(I_cell_sample, Vdd, SATURATED);
image_HS_saturated=image_HS_saturated/255;

subplot(3,2,1)
image(image_read);                     % display real image
subplot(3,2,2)
image(image_RGB_saturated);       % display saturated RGB image
subplot(3,2,3)
image(image_DVS_BS_saturated);         % display saturated DVS Bright scaling
subplot(3,2,4)
image(image_DVS_CE_saturated);         % display saturated DVS Contrast enhancement
subplot(3,2,5)
image(image_DVS_CE_BS_saturated);         % display saturated both
subplot(3,2,6)
image(image_HS_saturated);         % display saturated HS

%compute power consumption for rgb of the real image
real_power=calculate_power_DVS(image_read,Vdd);
%compute power consumption for rgb of the distorted image
DVS_power=calculate_power_DVS(image_RGB_saturated,Vdd);
%compute the power consmption for the Bright scaling
BS_power=calculate_power_DVS(image_DVS_BS_saturated,Vdd-1);
%compute the power consmption for the Contrast enhancement
CE_power=calculate_power_DVS(image_DVS_CE_saturated,Vdd-1);
%compute the power consmption for the Contrast enhancement and Bright scaling
BS_CE_power=calculate_power_DVS(image_DVS_CE_BS_saturated,Vdd-1);
%compute the power consmption for the histogram equalization
HS_power=calculate_power_DVS(image_HS_saturated,Vdd);
%histogram of the power consumption
figure
histogram('Categories',{'real image power','DVS image power','BS image power','CE image power','BS&CE image power','HE image power'},'BinCounts',[real_power,DVS_power,BS_power,CE_power,BS_CE_power,HS_power],'FaceColor','r');
%histogram('Categories',{'DVS image power','BS image power','CE image power','BS&CE image power','HE image power'},'BinCounts',[DVS_power,BS_power,CE_power,BS_CE_power,HS_power],'FaceColor','r');

%compute distortion between original and DVS modified one
DVS_distortion=calculate_distortion(image_read,image_RGB_saturated);
%compute distortion between original and BS one
BS_distortion=calculate_distortion(image_read,image_DVS_BS_saturated);
%compute distortion between original and CE one
CE_distortion=calculate_distortion(image_read,image_DVS_CE_saturated);
%compute distortion between original and CE&BE one
CE_BS_distortion=calculate_distortion(image_read,image_DVS_CE_BS_saturated);
%compute distortion between original and HS one
HS_distortion=calculate_distortion(image_read,image_HS_saturated);
%histogram of the distortion
figure
histogram('Categories',{'DVS distortion','BS distortion','CE distortion','BS&CE distortion','HE distortion'},'BinCounts',[DVS_distortion,BS_distortion,CE_distortion,CE_BS_distortion,HS_distortion],'FaceColor','g');
