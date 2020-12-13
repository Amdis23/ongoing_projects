clc
tic 
% Read bus & branch data from file excel
bus=xlsread('bus33');
branch=xlsread('branch33');
n=33;
% Initializing load matrix
Pb=bus(:,2);
Qb=bus(:,3);
%Initialize bracnh matrix
Pbr=zeros(n,1);
Qbr=zeros(n,1);
delP=zeros(n,1);
i=0;

while i<n
    i=i+1;
    var=i;
    if Pb(var)~=0||Qb(var)~=0
        while var~=0
       Pbr(var)=Pbr(var)+Pb(i);
       Qbr(var)=Qbr(var)+Qb(i);
       var=branch(var,2);
        end
    end
end
for i=1:n
    delP(i)=((Pbr(i))^2+(Qbr(i))^2)*branch(i,4)/12.66^2;
end

sum(delP)




        