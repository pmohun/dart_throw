function [cendist_da0] = da0_dorsal_volar()
% This matlab file is designed to create a matrix and plot in order to
% compare the minimum distance vs the centroid distance of the scaphoid and
% lunate. 
tic
clc
clear

% centroid/minimum distance comparison for fe4
% preallocate memory 
filename = 'centroid_minimum_distance_data.xlsx';
functionname = 'da0_dorsal_volar';




% create matrix of equal size for each axis
lunatecoor_x = xlsread('for stats Lunate_37_c.xls', 'Lunate DA redone', 'C6:M42');
scaphcoor_x = xlsread('for stats Scaphoid_37_c.xls', 'Scaph DA redone', 'D6:N42');
lunatecoor_y = xlsread('for stats Lunate_37_c.xls', 'Lunate DA redone', 'C43:M79');
scaphcoor_y = xlsread('for stats Scaphoid_37_c.xls', 'Scaph DA redone', 'D43:N79');
lunatecoor_z = xlsread('for stats Lunate_37_c.xls', 'Lunate DA redone', 'C80:M116');
scaphcoor_z = xlsread('for stats Scaphoid_37_c.xls', 'Scaph DA redone', 'D80:N116');

cendist = zeros([size(lunatecoor_x)]); %preallocate 

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

cendist = cendist*10.^-3; % convert to meters

% seperate centroid matrix into dorsal and volarly segmented arms
          
cendist_v = cendist(1:19,:);
cendist_d = cendist(20:31,:);

cendist_da0 = vertcat(cendist_v, cendist_d);
xlswrite(filename,cendist,functionname)
toc
% end