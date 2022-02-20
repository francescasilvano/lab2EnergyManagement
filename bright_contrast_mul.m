function [distortion,power] = bright_contrast_mul(immagine)
    tranf= imread(immagine);
    x=0;
    if(length(tranf(1,1,:))==3)%if it is colored we can apply modification to brightness and saturation 
        hsv_transf=rgb2hsv(tranf);
        bright=hsv_transf(:,:,3);
        saturation=hsv_transf(:,:,2);
        %diminuire la bright ed aumentare la saturazione
        %i'll create the matrix for the results each row rapresent a value
        %of brightness to be less each column a value of saturation
        distortion=zeros(length(0.3:0.1:0.9),length(1.2:0.1:1.5));
        power=zeros(length(0.3:0.1:0.9),length(1.2:0.1:1.5));
        for k=0.3:0.1:0.9 %bright
            bright=bright*k;
            x=x+1;%bright
            y=0;
            for g=1.2:0.1:1.5 %saturation
                saturation=saturation*g;
                %calculate distortion if ok with constrain save it
                %otherwise go on
                %calculate the name of the image transformed in order to save it
                hsv_transf(:,:,2)=saturation;
                hsv_transf(:,:,3)=bright;
                tmp=immagine;
                array=strsplit(tmp,'.');
                name=strcat(array(1),"_hb",sprintf('%.1f_',k),sprintf('%.1f',g),".",array(2));
                transformed=hsv2rgb(hsv_transf);
                imwrite(transformed,name);
                y=y+1;
                distortion(x,y)=calculate_distortion(immagine,name);
                power(x,y)=power_saving(immagine,name);
                %return to the initial value 
                hsv_transf=rgb2hsv(tranf);
                saturation=hsv_transf(:,:,2);
            end
            %return to the initial value 
            hsv_transf=rgb2hsv(tranf);
            bright=hsv_transf(:,:,3);
        end
        figure
        x=1.2:0.1:1.5;
        plot(x,distortion(1,:),"r-o",x,distortion(2,:),"g-.",x,distortion(3,:),"b-*",x,distortion(4,:),"c-s",x,distortion(5,:),"m-d",x,distortion(6,:),"y-p",x,distortion(7,:),"k-h");
        title('Bright contrast Distortion of the image');
        legend('k=0.3',"k=0.4","k=0.5","k=0.6","k=0.7","k=0.8","k=0.9");
        figure
        %plot della power saving per l'immagine per ogni k
        plot(x,power(1,:),"r-o",x,power(2,:),"g-.",x,power(3,:),"b-*",x,power(4,:),"c-s",x,power(5,:),"m-d",x,power(6,:),"y-p",x,power(7,:),"k-h");
        title('Bright contrast Power saving of the image');
        legend('k=0.3',"k=0.4","k=0.5","k=0.6","k=0.7","k=0.8","k=0.9");
    else
        distortion=zeros(length(0.3:0.1:0.9),1);
        power=zeros(length(0.3:0.1:0.9),1);
        %decrease the brightness
        bright=tranf;
        for k=0.3:0.1:0.9 %bright
            bright=bright*k;
            %calculate the name of the image transformed in order to save it
            tmp=immagine;
            array=strsplit(tmp,'.');
            name=strcat(array(1),"_hb",sprintf('%.1f',k),".",array(2));
            imwrite(bright,name);
            %save the distortion and the power consumption
            x=x+1;
            distortion(x)=calculate_distortion(immagine,name);
            power(x)=power_saving(immagine,name);
            %return to the value
            bright=tranf;
        end
        x=0.3:0.1:0.9;
        %plot distorction and power saving
        plot(x,distortion,'b-o',x,power,'r-*');
        title('Bright contrast');
        legend('distortion','power');

    end
end