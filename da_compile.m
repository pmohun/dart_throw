[row,col] = size(da0);
cendist_da0 = [];
a = 1;

cendist_fe0 = cendist_fe0();
cendist_fe4 = cendist_fe4();
cendist_ru0 = cendist_ru0();
cendist_ru4 = cendist_ru4();

for a = 1:row
    if da0(a,:) > 0
        cendist_da0 = [cendist_da0; da0(a,:)];
        n_cendist_fe0 = [cendist_fe0(a,:)];
    end
end
        clear cendist
        clear cendist_fe0
        