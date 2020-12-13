clear all;
  %branchno.  INbus   OUTbus  Resistance(pu) Reactance(pu)
LD=[  1       1      2       0.123         0.4127                                          % i edited the 0 bus to 1 and add +1 to all the bus
      2       2      3       0.014         0.6051 
      3       3      4       0.746         1.205
      4       4      5       0.698         0.6084
      5       5      6       1.983         1.7276
      6       6      7       0.905         0.7886
      7       7      8       2.055         1.164
      8       8      9       4.795         2.716
      9       9      10       5.343         3.0264];  
     
     % bus no     activepowerPU   reactivepowerPU
  BD=[   1         0            0                                   % swing bus
         2         1.840         0.460  
         3         0.980         0.340
         4         1.790         0.446
         5         1.598         1.840
         6         1.610          0.600
         7         0.780         0.110
         8         1.150         0.060
         9         0.980         0.130
         10        1.640         0.200 ] ;
     
F=LD(:,2:3);
M=max(LD(:,2:3));
N=max(M);
f=[1:N]';
for i=1:N
    g=find(F(:,:)==i);
    h(i)=length(g);
end
k(:,1)=f;
k(:,2)=h';
  cent= input('central bus  ');
% this section of the code is to adjust line data to the standard
  NLD=zeros(N,size(LD,2));
[c r]=find(LD(:,2:3)==cent);
for i=1:length(c)
    if r(i)==2
        LD(c(i),2:3)=[LD(c(i),3),LD(c(i),2)];
    end
    
end
NLD=LD(c,:);
LD(c,:)=[];
t=find(k(:,1)==cent);
k(t,2)=k(t,2)-length(c);
j=length(c);
i=1;
while sum(k(:,2))>0
    c=[];
    b=[];
    t=[];
    [c e]=find(LD(:,2:3)==NLD(i,3));
    
    
    if size(c,2)~=0
        b=LD(c,:);
        LD(c,:)=[];
        t=find(k(:,1)==NLD(i,3));
        k(t,2)=k(t,2)-(size(c,1)+1);
        d=find(b(:,3)==NLD(i,3));
        b(d,2:3)=[b(d,3),b(d,2)];
        NLD(j+1:j+size(c,1),:)=b;
        j=j+size(c,1);
    elseif size(c,2)==0 && k(NLD(i,3),2)>0
            k(NLD(i,3),2)=k(NLD(i,3),2)-1;
    end
    i=i+1;
end