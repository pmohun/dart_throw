% This m-file is used to select the data output for minimum distance and
% centroid comparisons for a number of cadaveric specimens. 

% Define global variables
filename = 'centroid_minimum_distance_data.xlsx';
tic

motion = input('What type of motion are you interested in? Please enter: ''fe'',''ru'',''da'', or ''all'': ','s');
plot = input('Would you also like to see the plots for the associated motion? Please enter [y/n]: ','s');



switch motion
    case 'all'
    disp('Thank you. Please be patient while your data set is generated.')
    fe0 = fe0_dorsal_volar();
    fe4 = fe4_dorsal_volar();
    ru0 = ru0_dorsal_volar();
    ru4 = ru4_dorsal_volar();
    da0 = da0_dorsal_volar();
    da4 = da4_dorsal_volar();
    case 'fe'
    disp('Thank you. Please be patient while your data set is generated.')
    fe0 = fe0_dorsal_volar();
    fe4 = fe4_dorsal_volar();
    case 'ru'
    disp('Thank you. Please be patient while your data set is generated.')
    ru0 = ru0_dorsal_volar();
    ru4 = ru4_dorsal_volar();
    case 'da'     
    disp('Thank you. Please be patient while your data set is generated.')
    da0 = da0_dorsal_volar();
    da4 = da4_dorsal_volar();
    otherwise
    disp('Sorry, your input was not recognized. Please enter a valid motion.')
    break
end

switch plot
    case 'y'
        if strcmp(motion,'all')
            plot_all()
        elseif strcmp(motion,'fe')
            plot_fe(fe0,fe4)
        elseif strcmp(motion,'ru')
            plot_ru(ru0,ru4)
        elseif strcmp(motion,'da')
            plot_da(da0,da4)
        end
end
