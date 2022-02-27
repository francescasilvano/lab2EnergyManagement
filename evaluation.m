function evaluation(immagini,distortion)
%for each image do the 5 transformation
    for i=1:length(immagini)
        image=imread(string(immagini(i)));
        array=strsplit(string(immagini(i)),'.');
        [distortion_pw,power_pw]=pixel_wise(image,distortion); %return a vector for distortion and power
        [distortion_hb,power_hb]=hungry_blue(image,distortion); %return vector for distortion and power (0 for b&w)
        [distortion_he,power_he]=histogram_equalization(image,array(2)); %return a distortion and a power
        [distortion_bs,power_bs]=brightness_scaling(image,distortion,array(2)); %return a vector of distortion and power
        [distortion_ce,power_ce]=contrast_enhancement(image,distortion,array(2)); %return a vector of distoriton and power (0 for b&w)
        [distortion_bc,power_bc]=bright_contrast(image,distortion,array(2));
        
        figure
        plot(power_pw,distortion_pw,"r-o",power_hb,distortion_hb,"g-.",power_he,distortion_he,"b-*",power_bs,distortion_bs,"c-s",power_ce,distortion_ce,"m-d",power_bc,distortion_bc,"k-p");
        title('Pareto curve power, average distortion');
        legend('pixel wise',"hungry blue","histogram equalization","brightness scaling","contrast enhancement","bright contrast");
       
    end
end