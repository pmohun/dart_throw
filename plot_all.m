% function [] = plot_all(da0,da4)

degree_fe = [50 40 30 20 10 0 -10 -20 -30]; % 1x9
degree_ru = [10 0 -10 -20]; % 1x4
degree_da = [10 20 30 20 10 0 -10 -20 -30 -20 -10]; % 1x11

clear cendist_fe0 cendist_fe4 cendist_ru0 cendist_ru4


% remove rows from fe and ru data that do not have matching arms in da

cendist_fe0 = cendist_fe0();
cendist_fe4 = cendist_fe4();
cendist_ru0 = cendist_ru0();
cendist_ru4 = cendist_ru4();
% 
% cendist_fe0 = vertcat(cendist_fe0(1:3,:),cendist_fe0(5:7,:),cendist_fe0(10,:),cendist_fe0(16:19,:),cendist_fe0(21:30,:)); % exclude arms 73,77,82, 83, 84, 85, 86
% cendist_fe4 = vertcat(cendist_fe4(1:3,:),cendist_fe4(5:7,:),cendist_fe4(10,:),cendist_fe4(16:19,:),cendist_fe4(21:end-1,:));
% 
% cendist_ru0 = vertcat(cendist_ru0(1:3,:),cendist_ru0(5:7,:),cendist_ru0(10,:),cendist_ru0(16:19,:),cendist_ru0(21:30,:)); % exclude arms 73,77,82, 83, 84, 85, 86
% cendist_ru4 = vertcat(cendist_ru4(1:3,:),cendist_ru4(5:7,:),cendist_ru4(10,:),cendist_ru4(16:19,:),cendist_ru4(21:end-1,1:end-1));

% import da centroid data

da0 = da0_dorsal_volar();
da4 = da4_dorsal_volar();


% remove empty rows 

cendist_da0 = [];
cendist_da4 = [];

[row,col] = size(da0)
for i = 1:row
    if da4(i,1) > 0
        cendist_da0 = [cendist_da0;da0(i,:)];
        cendist_da4 = [cendist_da4; da4(i,:)];
    end
end
