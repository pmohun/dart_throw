% function [p_da] = plot_da(da0,da4)

% This function is used to plot the results obtained from the prompt m-file.

clear plot

degree_da = [10 20 30 20 10 0 -10 -20 -30 -20 -10];

% preallocate 

cendist_da0 = [];
cendist_da4 = [];

plottype = input('How would you like your results plotted? Please enter ''subplot'' or ''multiple'': ','s')

% remove empty rows 
[row,col] = size(da0);
for i = 1:row
    if da0(i,1) > 0
        cendist_da0 = [cendist_da0;da0(i,:)];
    end
end

[row,col] = size(da4);
for i = 1:row
    if da4(i,1) > 0
        cendist_da4 = [cendist_da4; da4(i,:)];
    end
end

avg_cendist_da0 = mean(cendist_da0(:,:));
avg_cendist_da4 = mean(cendist_da4(:,:));
e_cendist_da0 = std(cendist_da0(:,:));
e_cendist_da4 = std(cendist_da4(:,:));


switch plottype
    case 'subplot'
        subplot(2,1,1)
        errorbar(degree_da,avg_cendist_da0,e_cendist_da0,'-ok')
        xlabel('Degree of Motion')
        ylabel('Average Centroid Distance da0 (m)')
        subplot(2,1,2)
        errorbar(degree_da,avg_cendist_da4,e_cendist_da4,':ok')
        xlabel('Degree of Motion')
        ylabel('Average Centroid Distance da4 (m)')
        
    case 'multiple'
        plot(degree_da,avg_cendist_da0,'-ok')
        hold on;
        plot(degree_da,avg_cendist_da4,':ok')
        xlabel('Degree')
        ylabel('Centroid Distance (m)')
        legend('da0','da4')
end