function [min_cen_ru4] = ru4_dorsal_volar()
% This matlab file is designed to create a matrix and plot in order to
% compare the minimum distance vs the centroid distance of the scaphoid and
% lunate. 
tic
clc
clear

% centroid/minimum distance comparison for fe4
% preallocate memory 
filename = 'centroid_minimum_distance_data.xlsx';
functionname = 'ru4_dorsal_volar';
min_cen_ru4_v = [];
min_cen_ru4_d = [];



% create matrix of equal size for each axis
lunatecoor_x = xlsread('for stats Lunate_37_c.xls', 'Lunat RU', 'X6:AC42');
scaphcoor_x = xlsread('for stats Scaphoid_37_c.xls', 'Scaph RU ALL', 'U6:Z36');
lunatecoor_y = xlsread('for stats Lunate_37_c.xls', 'Lunat RU', 'X43:AC73');
scaphcoor_y = xlsread('for stats Scaphoid_37_c.xls', 'Scaph RU ALL', 'U44:Z74');
lunatecoor_z = xlsread('for stats Lunate_37_c.xls', 'Lunat RU', 'X80:AC110');
scaphcoor_z = xlsread('for stats Scaphoid_37_c.xls', 'Scaph RU ALL', 'U82:Z112');

cendist = zeros([size(lunatecoor_x)]); %preallocate 

cendist = cendist*10.^-3; % convert to meters

% iterate over matrix and compile coordinates in (x,y,z) format 
% determine distance between centroid for each arm at specific degree of
% flexion

[m,n] = size(lunatecoor_x);
[y,z] = size(scaphcoor_x);
if [m,n] ~= [y,z] % check to make sure coordinate arrays match
    disp('ERROR: Vector dimensions of Scaphoid and Lunate coordinates do not match. Please check to make sure your excel sheets are formatted properly. See the README for more details.')
end

for row = 1:m
    for col = 1:n
        lun_xyz = [lunatecoor_x(row,col),lunatecoor_y(row,col),lunatecoor_z(row,col)];
        sca_xyz = [scaphcoor_x(row,col),scaphcoor_y(row,col),scaphcoor_z(row,col)];
        difsq = (lun_xyz-sca_xyz).^2;
        cendist(row,col) = sqrt(sum(difsq));
    end
end

cendist = cendist.*10^-3 % convert to meters

% seperate centroid matrix into dorsal and volarly segmented arms

cendist_v = vertcat(cendist(1:8,:),cendist(10:19,:)); % exclude arm 77 due to lack of minimum distance data
cendist_d = vertcat(cendist(20:21,:),cendist(23:24,:),cendist(26:31,:)); %exclude arms 108,112,127:142 due to lack of minimum distance data

% import minimum distance into matlab for arms 62-95 & arms 105-123
% Note: every other row alternates between intact/cut

min_ru_v = xlsread('minru0ru4volar.xls');
min_ru_d = xlsread('minru0ru4dorsal.xls');

% generate two matricies consisting of only the minimum distance data for
% the intact arms

min_ru4_v = min_ru_v(:,3:2:length(min_ru_v)); % 18 total arms
min_ru4_d = min_ru_d(:,3:2:length(min_ru_d)); % 10 total arms

% transpose for later use

min_ru4_v = transpose(min_ru4_v);
min_ru4_d = transpose(min_ru4_d);

% remove frame 1079 from centroid data due to lack of data in minimum
% distance data

cendist_d = cendist_d(:,1:4);
cendist_v = cendist_v(:,1:4);

% % generate matrix with comparison between minimum distance and centroid
% % distance
% % plot the result for each arm and export to excel
for row = 1:length(min_ru4_v);
        A = min_ru4_v(row,:); % store current arms minimum distance data for concatenation
        B = cendist_v(row,:); % store current arms centroid distance data for concatenation
        min_cen_ru4_v = [min_cen_ru4_v;A;B]; % concatenate
%         plot(min_ru4_v(row,:),cendist_v(row,:));
%         title('RU4 Minimum Distance vs Centroid Distance (volar)');
%         xlabel('Minimum Distance (m)');
%         ylabel('Centroid Distance (m)');
end

for row = 1:length(min_ru4_d);
        D = [min_ru4_d(row,:)]; % store current arms minimum distance data for concatenation
        E = [cendist_d(row,:)]; % store current arms centroid distance data for concatenation
        min_cen_ru4_d = [min_cen_ru4_d;D;E]; % concatenate
%         plot(min_ru4_d(row,:),cendist_d(row,:));
%         title('RU0 Minimum Distance vs Centroid Distance (dorsal)');
%         xlabel('Minimum Distance (m)');
%         ylabel('Centroid Distance (m)');
end

min_cen_ru4 = vertcat(min_cen_ru4_v, min_cen_ru4_d);
xlswrite(filename,min_cen_ru4,functionname)
toc
end