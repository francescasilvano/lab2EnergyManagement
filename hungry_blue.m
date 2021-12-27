function [distorction,power] = hungry_blue(lista)
    %lista di stringhe da cui prenderemo le immagini
    x=0;
    y=zeros(length(lista));
    z=zeros(length(lista));
    for k= 0:20:255
        %0.5 0.6 0.7 0.8 0.9
        x=x+1;
        for i= 1:length(lista)
            tranf= imread(lista(i));
            tranf(:,:,3)=tranf(:,:,3) - k;
            %salvo l'immagine
            imwrite(tranf,"tmp.bmp")
            %per ogni immagine calcolare la distorsione dall'originale 
            y(x)=y(x)+calculate_distortion(lista(i),"tmp.bmp");
            %e il power saving
            z(x)=z(x)+power_saving(lista(i),"tmp,bmp");
        end
        %average della distorsione e del power saving per ogni k
        y(x)=y(x)/length(lista);
        z(x)=y(x)/length(lista);
    end
    x=0:length(y);
    plot(x,y)
    plot(x,z)
    distorction=y;
    power=z;
end