function [y] = increment(x,Vl)
con=0;
ii=0;
while con==0
     ii=ii+1;
    if x==Vl(ii)
        y=Vl(ii+1);
        con=1;
    end
end
end
