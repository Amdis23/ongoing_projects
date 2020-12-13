clear all;
clc;
solarmean=0.657;
stdsolar=0.284;
beta=(1-solarmean)*(((solarmean*(1+solarmean))/stdsolar^2)-1);
alpha=(solarmean*beta)/(1-solarmean);
vmean=8;
k=2;
c=vmean/0.9;
fun1=@(v) (k./(c))*((v/c)^(k-1))*exp(-(v/c)^k);
fun2=@(x) ((gamma(alpha+beta))/(gamma(alpha)*gamma(beta)))*x^(alpha-1)*(1-x)^(beta-1);
% fun2=@(x) 1*x^(alpha-1)*(1-x)^(beta-1);
test= ((gamma(alpha+beta))/(gamma(alpha)*gamma(beta)));
vmin=0;
vmax=1;
delv=1;
ii=0;
vcin=3;
vcut=25;
vrated=12;
Prated=1;
while vmax<=30
    ii=ii+1;
    fv(ii)=integral(fun1,vmin,vmax,'ArrayValued',true);
    v_str(ii)=0.5*(vmin+vmax);
    
    if v_str(ii)<vcin || v_str(ii)>vcut
        Pw(ii)=0;
    elseif v_str(ii)>=vcin && v_str(ii)<=vrated
        Pw(ii)=Prated*(v_str(ii)-vcin)/(vrated-vcin);
    else
        Pw(ii)=Prated;
        
    end
    
    vmin=vmin+delv;
    vmax=vmax+delv;
    
    
    
    
end
xmin=10^-6;
delx=0.05;
xmax=xmin+delx;
sump=0;
ii=0;
while xmax<1.0
       ii=ii+1;
       x(ii)=0.5*(xmin+xmax);                                                                                                                                                                                                                                                                               
       fs1(ii)=integral(fun2,xmin,xmax,'ArrayValued',true);
       sump=sump+fs1(ii);
       xmin=xmin+delx;
       xmax=xmin+delx;
       PS(ii)=0.186*40*x(ii)*10;
end

solartab=[transpose(PS) transpose(fs1)]
Windtab=[transpose(Pw) transpose(fv)]
    
%%Load Uncertainity
loadmean=20;
stddev=1;
ii=0;
fun3=@(l) (1/(stddev*2.506))*exp(-((l-loadmean)^2/(2*stddev^2)));
while ii<25
    ii=ii+1;
    if x>loadmean-3.5*stddev && x<loadmean-2.5*stddev
      pl(ii)=loadmean-3*stddev;
      f(ii)=integral(fun3,loadmean-3.5*stddev,loadmean-2.5*stddev,'ArrayValued',true); 
    elseif x>loadmean-3.5*stddev && x<loadmean-2.5*stddev
      pl(ii)=loadmean-3*stddev;
      f(ii)=integral(fun3,loadmean-3.5*stddev,loadmean-2.5*stddev,'ArrayValued',true);
    elseif x>loadmean-2.5*stddev && x<loadmean-1.5*stddev
      pl(ii)=loadmean-2*stddev;
      f(ii)=integral(fun3,loadmean-2.5*stddev,loadmean-1.5*stddev,'ArrayValued',true);
    elseif x>loadmean-1.5*stddev && x<loadmean-0.5*stddev
      pl(ii)=loadmean-stddev;
      f(ii)=integral(fun3,loadmean-1.5*stddev,loadmean-0.5*stddev,'ArrayValued',true); 
    elseif x>loadmean-0.5*stddev && x<loadmean+0.5*stddev
      pl(ii)=loadmean;
      f(ii)=integral(fun3,loadmean-0.5*stddev,loadmean+0.5*stddev,'ArrayValued',true);  
    elseif x>loadmean+0.5*stddev && x<loadmean+1.5*stddev
      pl(ii)=loadmean+stddev;
      f(ii)=integral(fun3,loadmean+0.5*stddev,loadmean+1.5*stddev,'ArrayValued',true);  
    elseif x>loadmean+1.5*stddev && x<loadmean+2.5*stddev
      pl(ii)=loadmean+2*stddev;
      f(ii)=integral(fun3,loadmean+1.5*stddev,loadmean+2.5*stddev,'ArrayValued',true);
    elseif x>loadmean+2.5*stddev && x<loadmean+3.5*stddev
      pl(ii)=loadmean+3*stddev;
      f(ii)=integral(fun3,loadmean+2.5*stddev,loadmean+3.5*stddev,'ArrayValued',true);
    else
      pl(ii)=loadmean+3*stddev;
      f(ii)=integral(fun3,loadmean+2.5*stddev,loadmean+3.5*stddev,'ArrayValued',true);  
    end
end






