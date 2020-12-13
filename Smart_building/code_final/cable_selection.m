clc
close all
Power_T=input('Enter the power to be transmitted: ');
Length=input('Enter the length of Transmission line: ');
pf=input('Enter the Power factor: ');
f=50;
voltage_available=[11 33 66 110 132 166 230];
line.loading=1e06.*[0.024 0.2 0.6 11 20 35 90];
cross.area=[0.1935 0.2580 0.3225 0.3870 0.4515 0.5160 0.5805 0.6450 0.9675 1.290 1.6125];
current_capacity=[100 127 148 170 190 210 230 255 350 425 505];
nominal_area=1e-3.*[161 322 387 484 645 645 805 968 1125 1290 1613];
strands=[30 26 54];
alu_strand=[6 6 6 6 6 7 30 30 30 30 30];
diameter=1e-3.*[708 1005 1097 1227 1417 1458 1654 1814 1956 2013 2347];
radius=diameter/2;
resistance_per_km=1e-4.*[10891 5400 4550 3640 2720 2700 2200 1832 1572 1370 1091];
Ds=[0.826 0.809 0.810];
spacing=[1 1.3 2.6 5 6 8 10.2];
Table_v=[transpose(voltage_available) transpose(line.loading)] ;
Table_Conductor_area=[transpose(cross.area) transpose(current_capacity)];
Table_Nominal_area_selection=[transpose(nominal_area) transpose(cross.area)];
Table_Strand_selection=[transpose(alu_strand) transpose(nominal_area)];
Table_Diameter_selection=[transpose(diameter) transpose(nominal_area)];
Table_Resistance_selection=[transpose(resistance_per_km) transpose(nominal_area)];
Table_Strands_selection=[];
Table_Selection_Ds=[transpose(Ds) transpose(strands)];
Table_Spacing_selection=[transpose(spacing) transpose(voltage_available)] ;
KWKM=Power_T*Length;
Vr=selection(KWKM,Table_v);
p=0;
while p==0 
n=0
Ir=(Power_T/(sqrt(3)*Vr*pf)); 
conductor_area=selection(Ir,Table_Conductor_area); 
Area=selection(conductor_area,Table_Nominal_area_selection);
Strand=selection(Area,Table_Strand_selection);
Diameter=selection(Area,Table_Diameter_selection);
Radius=Diameter/2;
resistance=selection(Area,Table_Resistance_selection); 
Ds=(selection(Strand,Table_Selection_Ds))*(Diameter/2); 
Spacing=selection(Vr,Table_Spacing_selection);
Dm=Spacing*100;
l=((2)*(10^-7)*(log(Dm/Ds)))*160*1000;
Cap=((5.563)*(10^-11)/(log(Dm/(Diameter/2))))*160*1000;
Xl=2*pi*f*l;
Z=(resistance*Length)+(i*Xl);
Y=i*2*pi*f*Cap;
A=1+((Y*Z)/2);
B=Z;
D=A;
C=Y*(1+((Y*Z)/4));
VR=(Vr*1000)/sqrt(3);
I_r=complex(Ir*cos(acos(0.9)),-Ir*sin(acos(0.9)));
V.s=(A*VR)+(B*I_r);
Vs=abs(V.s);
I.s=(C*VR)+(D*I_r);
Is=abs(I.s);
per_Vr=((abs(Vs)- VR))/ VR *100;
angle_Is=angle(I.s);
angle_Vs=angle(V.s);
Vin=sqrt(3)*Vs;
power_factor=cos(angle_Is+angle_Vs);
Pin=(sqrt(3)*Vin*Is*power_factor)/1e3;
efficiency = (Power_T/Pin)*100;
%For corona loss 
vd=21.1*0.85*Radius*(log(Spacing/Radius))*4;%%(dielectric strength(21.1),rad=1,m=0.85)
 Corona_loss1=(21*10^-6*f*(Vr^2)*1)*0.08/(log(Spacing/Radius)^2);%peterson
 Corona_loss2=(244*75*((Radius/Spacing)^1/2)*((Vr-vd)^2)*10^-5);%peeks
if Vr/vd<1.8
   Corona_loss=Corona_loss1;
else
   Corona_loss=Corona_loss2; 
end
if per_Vr<=12.5&&Corona_loss<2
   p=1;
elseif per_Vr>12.5
    Vr=increment(Vr,voltage_available);
elseif Corona_loss>=2
    Spacing=increment(Spacing,spacing);
elseif Corona_loss>=10
    Spacing=increment(Spacing,spacing);
    Vr=decrement(Vr,voltage_available);
end
n=n+1;
if n==20
    break;
end
end
 
