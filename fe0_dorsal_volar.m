function [min_cen_fe0] = fe0_dorsal_volar()

% This matlab file is designed to create a matrix and plot in order to
% compare the minimum distance vs the centroid distance of the scaphoid and
% lunate. 
tic
clc
clear


% centroid/minimum distance comparison for fe0
% preallocate memory 

filename = 'centroid_minimum_distance_data.xlsx';
functionname = 'fe0_dorsal_volar';
min_cen_fe0_v = [];
min_cen_fe0_d = [];



% create matrix of equal size for each axis
lunatecoor_x = xlsread('for stats Lunate_37_c.xls', 'Lunat FE', 'H6:P42');
scaphcoor_x = xlsread('for stats Scaphoid_37_c.xls', 'Scaph FE', 'H6:P42');
lunatecoor_y = xlsread('for stats Lunate_37_c.xls', 'Lunat FE', 'H44:P80');
scaphcoor_y = xlsread('for stats Scaphoid_37_c.xls', 'Scaph FE', 'H44:P80');
lunatecoor_z = xlsread('for stats Lunate_37_c.xls', 'Lunat FE', 'H82:P118');
scaphcoor_z = xlsread('for stats Scaphoid_37_c.xls', 'Scaph FE', 'H82:P118');

cendist_fe0 = zeros([size(lunatecoor_x)]); %preallocate

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
        cendist_fe0(row,col) = sqrt(sum(difsq));
    end
end

cendist_fe0 = cendist_fe0*10.^-3; % convert to meters

% seperate centroid matrix into dorsal and volarly segmented arms

cendist_v = vertcat(cendist_fe0(1:8,:),cendist_fe0(10:19,:)); % exclude arm 77 due to lack of minimum distance data
cendist_d = vertcat(cendist_fe0(20:21,:),cendist_fe0(23:24,:),cendist_fe0(26:31,:)); %exclude arms 108,112,127:142 due to lack of minimum distance data


% import minimum distance into matlab for arms 62-95 & arms 105-123
% Note: every other row alternates between intact/cut

min_fe_v = xlsread('minfe0fe4volar.xls');
min_fe_d = xlsread('minfe0fe4dorsal.xls');

% generate two matricies consisting of only the minimum distance data for
% the intact arms

min_fe0_v = min_fe_v(:,2:2:length(min_fe_v)); % 18 total arms
min_fe0_d = min_fe_d(:,2:2:length(min_fe_d)); % 10 total arms

% transpose for later use

min_fe0_v = transpose(min_fe0_v);
min_fe0_d = transpose(min_fe0_d);

% generate matrix with comparison between minimum distance and centroid
% distance
% plot the result for each arm and export to excel
for row = 1:length(min_fe0_v);
        A = min_fe0_v(row,:); % store current arms minimum distance data for concatenation
        B = cendist_v(row,:); % store current arms centroid distance data for concatenation
        min_cen_fe0_v = [min_cen_fe0_v;A;B]; % concatenate
end
for row = 1:length(min_fe0_d);
        D = [min_fe0_d(row,:)]; % store current arms minimum distance data for concatenation
        E = [cendist_d(row,:)]; % store current arms centroid distance data for concatenation
        min_cen_fe0_d = [min_cen_fe0_d;D;E]; % concatenate
end


toc

min_cen_fe0 = vertcat(min_cen_fe0_v, min_cen_fe0_d);


% write to excel document 
xlswrite(filename,min_cen_fe0,functionname);
cendist_fe0;

end
