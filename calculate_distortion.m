function result = calculate_distortion(original,transformed)
    if(length(original(1,1,:))== 3)
        origLab=rgb2lab(original);
        transLab=rgb2lab(transformed);
        L_o=origLab(:,:,1);
        L_t=transLab(:,:,1);
        a_o=origLab(:,:,2);
        a_t=transLab(:,:,2);
        b_o=origLab(:,:,3);
        b_t=transLab(:,:,3);
        result=0;
        for i = 1:length(L_o(:,1))
            for j=1:length(L_o(1,:))
                result=result + sqrt((L_t(i,j)-L_o(i,j))^2 + (a_t(i,j)-a_o(i,j))^2 + (b_t(i,j)- b_o(i,j))^2);
            end
        end
        max= sqrt(100^2+255^2+255^2);
        result=  100* result/( length(transformed(:,1,1))* length(transformed(1,:,1))*max);
    else
        result=0;
        %for each pixel
        for i = 1:length(transformed(:,1))%column
            for j=1:length(transformed(1,:))%row
            result=result +sqrt((double(transformed(i,j))-double(original(i,j)))^2);
            end
        end
        max= sqrt(100^2+255^2+255^2);
        result=  100* result/( length(transformed(:,1))* length(transformed(1,:))*max);
    end
      
end