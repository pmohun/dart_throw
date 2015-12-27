function [cendist_fe0] = cendist_fe0()

clc
clear

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

end


