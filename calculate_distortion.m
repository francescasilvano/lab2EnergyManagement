function result = calculate_distortion(stringa1,stringa2)
    transformed=imread(stringa2);
    original=imread(stringa1);
    origLab=rgb2lab(original);
    transLab=rgb2lab(transformed);
    L_o=origLab(:,:,1);
    L_t=transLab(:,:,1);
    a_o=origLab(:,:,2);
    a_t=transLab(:,:,2);
    b_o=origLab(:,:,3);
    b_t=transLab(:,:,3);
    result=0;
    for i = 1:length(L_o)
    result=result + square((L_t(i)-L_o(i))^2 + (a_t(i)-a_o(i))^2 + (b_t(i)- b_o(i))^2);
    end
    
      
end