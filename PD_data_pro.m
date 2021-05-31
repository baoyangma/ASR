clc,clearvars,close all
load all.mat
% [NUM,TXT,RAW] = xlsread('PD_test.xlsx','PD_character_re-sweep');
% 
% Pout = NUM(:,4);
% PD_DAC = NUM(:,13);
% Pout = Pout(1:239);
% PD_DAC = PD_DAC(1:239);

dataIdx = find(~isnan(Pout));
Pout = Pout(dataIdx);
PD_DAC = PD_DAC(dataIdx);
Pout_mat = reshape(Pout,25,[]);
PD_DAC_mat = reshape(PD_DAC,25,[]);
% PD_DAC_mat(17:end,:) = PD_DAC_mat(17:end,:) + 11.5;

maxPoutLow = max(Pout_mat(1,:));
minPoutLow = min(Pout_mat(end,:));

temperature = zeros(1,500).';

figure,
xx =[];
for m = 1:8
    dx = Pout_mat(:,m);
    dy = PD_DAC_mat(:,m);
%     start = maxPoutLow;
%     stop = minPoutLow;
    start = dx(1);
    stop = dx(end);

    interX = linspace(start,stop,500);
    interY = interp1(dx,dy,interX);
    
%     idx = find(interX > maxPoutLow);
    dataX(:,m) = interX;
    dataY(:,m) = interY;
%     plot3(temperature+m*10,interX,interY),hold on,grid on
%     xx = [xx temperature+(m-3)*20];
    plot(interX,interY),hold on,
    xx = [xx temperature+(6-m)*20];
end
legend({'100℃','80℃','60℃','40℃','20℃','0℃','-20℃','-40℃'})
grid on,
xlabel('Pout power(dbm)'),ylabel('PD\_DAC(db)')

figure
ax = gca;
mesh(xx,dataX,dataY)
xlabel('Temparature(℃)'),ylabel('Pout power(dbm)'),zlabel('PD\_DAC(db)')
set(gca,'XDir','reverse')%对X方向反转
title('PD character under different temperature');

tartPout = 5;

[val,pos] = min(abs(dataX - tartPout));

for m = 1:8
    shadow(m,1) = dataY(pos(m),m);
end
shadow
v00 = interp1(linspace(-8.9,21.9,8),flip(shadow),linspace(-8.9,21.9,500));


x = linspace(-40,100,500);
y = tartPout*ones(1,500);
z = shadow(end)*ones(1,500);
hold on,plot3(x,y,z,'LineWidth',2,'Color','r')

x = linspace(-40,100,500);
y = tartPout*ones(1,500);
% z = 15*ones(1,500);
z = v00;
hold on,plot3(x,y,z,'LineWidth',1,'Color','k')

%
x = 100*ones(1,500);
y = tartPout*ones(1,500);
% z = 15*ones(1,500);
z = linspace(5,shadow(1),500);
hold on,plot3(x,y,z,'LineWidth',2,'Color','m','LineStyle','--')



