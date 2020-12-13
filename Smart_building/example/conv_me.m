function [ h,nh ] = conv_me( x,xn,y,yn )
nyb = xn(1) + yn(1);
nye = xn(end) + yn(end);
nh = (nyb:nye);
h = conv(x,y);
end