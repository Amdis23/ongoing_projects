xn = -1:1;
yn = -2:1;
x = [31,32,33];
y = [32,33,34,35];
[h,nh] = conv_me(x,xn,y,yn);
figure, stem(nh,h)
hold on
stem(yn,y)
stem(xn,x)
hold on
