clc
clear
tic
inputdata
[n,~] = size(busdata); 
[b,~] = size(linedata);  
AP = busdata(:,2);  
RP = busdata(:,3);   
fromb = linedata(:,2);
tob = linedata(:,3);
BIBC = zeros(n-1);
BIBC(1,1) = 1;
BCBV = zeros(n-1);
Z = linedata(:,4) + 1j*linedata(:,5); 
BCBV(1,1) = Z(1);
for i=1:b
 PI(i,1)=((linedata(i,2))/(1000*Sn));
    QI(i,1)=((linedata(i,3))/(1000*Sn));
    end
for i = 1:b
    if tob(i)&&fromb(i)>1
        BIBC(:,tob(i)-1) = BIBC(:,fromb(i)-1);
        BIBC(i,i) = 1;
    end
end 
for i = 1:b
    if tob(i)&&fromb(i)>1
        BCBV(tob(i)-1,:) = BCBV(fromb(i)-1,:);
        BCBV(i,i) = Z(i);
    end
end
DLF = BCBV*BIBC;
ibv = (Vn+1j*0)*ones(1,n-1);
k = 0;
ic = 0;
em = inf;
while em>1e-5&&ic<5000
    k = k+1;
    ic = ic+1;
    if k==1
        for j = 2:n
            l_c(k,j-1) = ((AP(j)+1j*RP(j))/ibv(j-1));
        end
    else
        for j = 2:n
            l_c(k,j-1) = ((AP(j)+1j*RP(j))/b_v(k-1,j-1));
        end
    end
    dVoltage = DLF*l_c(k,:)';
    d_vol(k,:) = dVoltage'*1e-3;
    
    if k==1
        b_v(k,:) = Vn - d_vol(k,:);
        e(k,:) = abs(b_v(k,:)-ibv);
        em = max(e(k,:));
    else
        b_v(k,:) = Vn - d_vol(k,:);
        e(k,:) = abs(b_v(k,:)-b_v(k-1,:));
        em = max(e(k,:));
    end
    
end
PL(1,1)=0;
QL(1,1)=0;
Voltage=abs(b_v(k,:))'
Voltage_angle=angle(b_v(k,:))'*(180/pi)
Delta_V=abs(d_vol(k,:))'
Angle_Delta_V=angle(d_vol(k,:))'*(180/pi)
Current=abs(l_c(k,:))'
Current_Angle=angle(l_c(k,:))'*(180/pi)    
table=[Current Current_Angle];
R=linedata(:,4);
X=linedata(:,5);
for ii=1:b
 PI(ii,1)=(table(ii,1)^2)*R(ii,1);
    QI(ii,1)=X(ii,1)*(table(ii,1)^2);
    PL(1,1)=PL(1,1)+PI(ii,1);
    QL(1,1)=QL(1,1)+QI(ii,1);
end
Ploss_kw=(PI)/1000
Qloss_kw=(QI)/1000
toc