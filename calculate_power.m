function result = calculate_power(A)
    w0=1.48169521*10^(-6);
    wr=2.13636845*10^(-7);
    wg=2.13636845*10^(-7);
    wb=2.14348309*10^(-7);
    gamma=0.7755;
    if(length(A(1,1,:))< 3)
        R_array=A;
        G_array=A;
        B_array=A;
    else
        R_array=A(:,:,1);
        G_array=A(:,:,2);
        B_array=A(:,:,3);
    end
        result= w0;
        for i = 1:length(B_array(:,1))
            for j= 1:length(B_array(1,:))
                result=result+ wr*(double(R_array(i,j)))^(gamma)+ wg*(double(G_array(i,j)))^(gamma)+wb*(double(B_array(i,j)))^(gamma);
            end
        end
end



