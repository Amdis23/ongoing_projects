clc;
clear all;
format short;
tic
m=[1 0 0
    2 100 60
    3 90 40
    4 120 80
    5 60 30
    6 60 20
    7 200 100
    8 200 100
    9 60 20
    10 60 20
    11 45 30
    12 60 35
    13 60 35
    14 120 80
    15 60 10
    16 60 20
    17 60 20
    18 90 40
    19 90 40
    20 90 40
    21 90 40
    22 90 40
    23 90 50
    24 420 200
    25 420 200
    26 60 25
    27 60 25
    28 60 20
    29 120 70
    30 200 600
    31 150 70
    32 210 100
    33 60 40];

%ln|fb|tb|r(ohm)|x(ohm)|type (neglect for your case)|status (open or closed closed=1, open=0)%%
l=[1 1 2 0.0922 0.0470 0 1
    2 2 3 0.4930 0.2511 0 1
    3 3 4 0.3660 0.1864 0 1
    4 4 5 0.3811 0.1941 0 1
    5 5 6 0.8190 0.7070 0 1
    6 6 7 0.1872 0.6188 0 1
    7 7 8 0.7114 0.2351 0 1
    8 8 9 1.0300 0.7400 0 1
    9 9 10 1.0440 0.74 0 1
    10 10 11 0.1966 0.0650 0 1
    11 11 12 0.3744 0.1238 0 1
    12 12 13 1.4680 1.1550 0 1
    13 13 14 0.5416 0.7129 0 1
    14 14 15 0.7463 0.5450 0 1
    15 15 16 0.7463 0.5450 0 1
    16 16 17 1.2890 1.7210 0 1
    17 17 18 0.7320 0.574 0 1
    18 2 19 0.1640 0.1565 0 1
    19 19 20 1.5042 1.3554 0 1
    20 20 21 0.4095 0.4784 0 1
    21 21 22 0.7089 0.9373 0 1
    22 3 23 0.4512 0.3083 0 1
    23 23 24 0.8980 0.7091 0 1
    24 24 25 0.8960 0.7011 0 1
    25 6 26 0.2030 0.1034 0 1
    26 26 27 0.2842 0.1447 0 1
    27 27 28 1.0590 0.9337 0 1
    28 28 29 0.8042 0.7006 0 1
    29 29 30 0.5075 0.2585 0 1
    30 30 31 0.9744 0.9630 0 1
    31 31 32 0.3105 0.3619 0 1
    32 32 33 0.3410 0.5302 0 1];
br=length(l);
no=length(m);
MVAb=100;
KVb=11;
Zb=(KVb^2)/MVAb;
% Per unit Values
for i=1:br
    R(i,1)=(l(i,4))/Zb;
    X(i,1)=(l(i,5))/Zb;
end
for i=1:no
    P_ankit(i,1)=((m(i,2))/(1000*MVAb));
    Q(i,1)=((m(i,3))/(1000*MVAb));
end
for i=1:br
    a=l(i,2);
    b=l(i,3);
    for j=1:no
        if a==j
            C(i,j)=-1;
        end
        if b==j
            C(i,j)=1;
end
end
end
e=1;
for i=1:no
    d=0;
    for j=1:br
        if C(j,i)==-1
            d=1;
end
end
    if d==0
        endnode(e,1)=i;
        e=e+1;
end
end
h=length(endnode);
for j=1:h
    e=2;
    
    f=endnode(j,1);
   % while (f~=1)
   for s=1:no
  if (f~=1)
       k=1;  
  for i=1:br
if ((C(i,f)==1)&&(k==1))
                f=i;
                k=2;
 end
 end
       k=1;
       for i=1:no
       if ((C(f,i)==-1)&&(k==1));
                f=i;
                g(j,e)=i;
                e=e+1;
                k=3;
end            
end
end
end
end
for i=1:h
    g(i,1)=endnode(i,1);
end
g;
w=length(g(1,:));
for i=1:h
    j=1;
    for k=1:no 
        for t=1:w
            if g(i,t)==k
                g(i,t)=g(i,j);
                g(i,j)=k;
                j=j+1;
end
end
end
end
g;
for k=1:br
    e=1;
    for i=1:h
    for j=1:w-1
    if (g(i,j)==k) 
    if g(i,j+1)~=0
     adjb(k,e)=g(i,j+1);            
     e=e+1;
    else
  adjb(k,1)=0;
end
end
end
end
end
adjb;
for i=1:br-1
 for j=h:-1:1
 for k=j:-1:2
  if adjb(i,j)==adjb(i,k-1)
  adjb(i,j)=0;
  end
  end
 end
end
adjb;
x=length(adjb(:,1));
ab=length(adjb(1,:));
for i=1:x
for j=1:ab
if adjb(i,j)==0 && j~=ab
if adjb(i,j+1)~=0
                adjb(i,j)=adjb(i,j+1);
                adjb(i,j+1)=0;
end
end
if adjb(i,j)~=0
            adjb(i,j)=adjb(i,j)-1;
end
end
end
adjb;
for i=1:x-1
    for j=1:ab
        adjcb(i,j)=adjb(i+1,j);
end
end
b=length(adjcb);
% voltage current program
for i=1:no
    vb(i,1)=1;
end
for s=1:10
for i=1:no
    nlc(i,1)=conj(complex(P_ankit(i,1),Q(i,1)))/(vb(i,1));
end
nlc;
for i=1:br
    Ibr(i,1)=nlc(i+1,1);
end
Ibr;
xy=length(adjcb(1,:));
for i=br-1:-1:1
for k=1:xy
 if adjcb(i,k)~=0
            u=adjcb(i,k);
            %Ibr(i,1)=nlc(i+1,1)+Ibr(k,1);
            Ibr(i,1)=Ibr(i,1)+Ibr(u,1);
 end
 end      
end
Ibr;
for i=2:no
      g=0;
 for a=1:b 
 if xy>1
 if adjcb(a,2)==i-1 
                u=adjcb(a,1);
                vb(i,1)=((vb(u,1))-((Ibr(i-1,1))*(complex((R(i-1,1)),X(i-1,1)))));
                g=1;
            end
 if adjcb(a,3)==i-1 
                u=adjcb(a,1);
                vb(i,1)=((vb(u,1))-((Ibr(i-1,1))*(complex((R(i-1,1)),X(i-1,1)))));
                g=1;
 end
 end
 end
 if g==0
            vb(i,1)=((vb(i-1,1))-((Ibr(i-1,1))*(complex((R(i-1,1)),X(i-1,1)))));
 end
end
s=s+1;
end
nlc;
Ibr;
vb;
vbp=[abs(vb) angle(vb)*180/pi];
toc;
for i=1:no
    va(i,2:3)=vbp(i,1:2);
end
for i=1:no
    va(i,1)=i;
end
va;
Current_and_angle=[abs(Ibr) angle(Ibr)*180/pi];
PL(1,1)=0;
QL(1,1)=0;
% losses
R
for f=1:br
    P_ankit(f,1)=(Current_and_angle(f,1)^2)*R(f,1);
    Ql(f,1)=X(f,1)*(Current_and_angle(f,1)^2);
    PL(1,1)=PL(1,1)+P_ankit(f,1);
    QL(1,1)=QL(1,1)+Ql(f,1);
end
Plosskw=(P_ankit)*100000
Qlosskw=(Ql)*100000
Total_Active_Power_loss=(PL)*100000
Total_Reactive_Power_loss=(QL)*100000
voltage = vbp(:,1)*12.66
Voltage_angle = vbp(:,2)*(pi/180)
Current=Current_and_angle(:,1)
Current_angle=Current_and_angle(:,2)
