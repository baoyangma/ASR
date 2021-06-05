clc,clearvars,close all

% [NUM,TXT,RAW] = xlsread('Different_Channel_PD_character.xlsx',1);
% NUM = NUM(2:end,:);
%
% Pout = NUM(:,5);
% PD_DAC = NUM(:,10);

load all_data.mat

dataIdx = find(~isnan(Pout));
Pout = Pout(dataIdx);
PD_DAC_db = PD_DAC(dataIdx);

Pout = Pout(26:end);
PD_DAC_db = PD_DAC_db(26:end);
Pout_mat = reshape(Pout,25,[]);
PD_DAC_mat = reshape(PD_DAC_db,25,[]);

targetPwr = [1 5 10 15 20];

data_title1 = {};data_title2 = {};
idx = 1;
for n = targetPwr%
    for m = 1:14
        dx = Pout_mat(:,m);
        dy = PD_DAC_mat(:,m);

        start = dx(1);
        stop = dx(end);
        
        interX = linspace(start,stop,500);
        interY = interp1(dx,dy,interX);
        
        [val,pos] = min(abs(interX - n));
        targetPDDAC(m) = interY(pos);
        
        dataX(:,m) = interX;
        dataY(:,m) = interY;
        
        str1 = sprintf('ch = %d',m);
        data_title1{m} = str1;
    end

    str2 = sprintf('Pout=%ddbm',n);
    data_title2{idx} = str2;
    diff_chn_delta(:,idx) = targetPDDAC - targetPDDAC(1);%to channel 1
    idx = idx + 1;
end

fd1 = figure;
for m = 1:14
    plot(Pout_mat(:,m),PD_DAC_mat(:,m),'Marker','*','LineStyle','-');grid on,hold on
end
legend(data_title1,'Location','northeastoutside','FontSize',12)
set(fd1.CurrentAxes.Title,'FontSize',14,'String','Different channel PD\_Character')
set(fd1.CurrentAxes.XLabel,'FontSize',14,'String','Pout(dBm)');
set(fd1.CurrentAxes.YLabel,'FontSize',14,'String','PD\_DAC(dB)','FontAngle','italic');

fd2 = figure;
for m = 1:length(targetPwr)
    plot(diff_chn_delta(:,m),'Marker','*','LineStyle','-');grid on,hold on
end
legend(data_title2,'FontSize',12)
set(fd2.CurrentAxes.Title,'FontSize',14,'String',{'Different channel PD\_DAC\_out delta to ch1'})
set(fd2.CurrentAxes.XLabel,'FontSize',14,'String','Channel');
set(fd2.CurrentAxes.YLabel,'FontSize',14,'String','Delta(dB)','FontAngle','italic');
set(fd2.CurrentAxes,'XTick',1:14)








