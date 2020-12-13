function [x] = selection(y,tab)
n=size(tab);
t=n(1,1);
for m= 2:1:t
     if y>tab(m-1,2) && y<=tab(m,2)
        x=tab(m,1)
     end
end    
end
