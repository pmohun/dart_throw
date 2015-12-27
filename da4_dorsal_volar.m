function [cendist_da4] = da4_dorsal_volar()
% This matlab file is designed to create a matrix and plot in order to
% compare the minimum distance vs the centroid distance of the scaphoid and
% lunate. 
tic
clc
clear

% centroid/minimum distance comparison for fe4
% preallocate memory 
filename = 'centroid_minimum_distance_data.xlsx';
functionname = 'da4_dorsal_volar';




% create matrix of equal size for each axis
lunatecoor_x = xlsread('for stats Lunate_37_c.xls', 'Lunate DA redone', 'AI6:AT42');
scaphcoor_x = xlsread('for stats Scaphoid_37_c.xls', 'Scaph DA redone', 'AJ6:AU42');
lunatecoor_y = xlsread('for stats Lunate_37_c.xls', 'Lunate DA redone', 'AI43:AT79');
scaphcoor_y = xlsread('for stats Scaphoid_37_c.xls', 'Scaph DA redone', 'AJ43:AU79');
lunatecoor_z = xlsread('for stats Lunate_37_c.xls', 'Lunate DA redone', 'AI80:AT116');
scaphcoor_z = xlsread('for stats Scaphoid_37_c.xls', 'Scaph DA redone', 'AJ80:AU116');

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
cendist_d = cendist(20:end,:);

cendist_da4 = vertcat(cendist_v, cendist_d);
cendist_da4 = cendist_da4(:,1:(end-1)); % remove last frame (origin coordinates for da0)
xlswrite(filename,cendist,functionname)
toc
end