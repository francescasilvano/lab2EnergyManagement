function [distortion,power] = hungry_blue(immagine)
    tranf= imread(immagine);
    if(length(tranf(1,1,:))== 3)%if it is colored go on otherwise it is inutile
        x=0;
        %create the vector for the saving
        distortion=zeros(length(0:20:255),1);
        power=zeros(length(0:20:255),1);
        for k= 0:20:255
            %0 20 40 60...
            x=x+1;
            tranf= imread(immagine);
            %1 red 2 green 3 blue, subtract each time more blue
            tranf(:,:,3)=tranf(:,:,3) - k;
            %calculate the name of the image transformed in order to save it
            tmp=immagine;
            array=strsplit(tmp,'.');
            name=strcat(array(1),"_hb",sprintf('%d',k),".",array(2));
            imwrite(tranf,name);
            %for each image calculate the distortion
            distortion(x)=calculate_distortion(immagine,name);
            % and the power saving
            power(x)=power_saving(immagine,name);
        end
        x=0:20:255;
        plot(x,distortion,'b-o',x,power,'r-*');
        title('Hungry blue'+immagine);
        legend('distortion','power');
    else %when the image is b&w there is no blue
        distortion=0;
        power=0;
    end
end