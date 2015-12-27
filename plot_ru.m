% function [p_nml_ru0,p_nml_ru4] = plot_ru(ru0,ru4)

% This function is used to plot the results obtained from the prompt m-file.

clear plot

degree_ru = [10 0 -10 -20];
data = input('Which comparison would you like to plot? Please enter: ''ratio'',''centroid'',or ''both'': ','s');
plottype = input('How would you like your results plotted? Please enter: ''subplot'', ''multiple'', or ''cancel'': ','s');


% calculate average values for centroid and minimum distance
% create normalized data by generating ratio between centroid and minimum
% distance 

        min_ru0 = ru0(1:2:length(ru0),:);
        cendist_ru0 = ru0(2:2:length(ru0),:);
        avg_min_ru0 = mean(min_ru0);
        avg_cendist_ru0 = mean(cendist_ru0);
        e_cendist_ru0 = std(cendist_ru0(:,:));
        ru0_nml = (min_ru0)./(cendist_ru0);
        e_nml_ru0 = std(ru0_nml);
        avg_ru0_nml = mean(ru0_nml);
        
        
        min_ru4 = ru4(1:2:length(ru4),:);
        cendist_ru4 = ru4(2:2:length(ru4),:);
        avg_min_ru4 = mean(min_ru4);
        avg_cendist_ru4 = mean(cendist_ru4);
        e_cendist_ru4 = std(cendist_ru4);
        ru4_nml = (min_ru4)./(cendist_ru4);
        e_nml_ru4 = std(ru4_nml);
        avg_ru4_nml = mean(ru4_nml);

      
        
switch data        
    case 'ratio'
        switch plottype  
          case 'subplot'             
           % generate subplots for ru0 & ru4
            subplot(2,1,1)
            p_nml_ru0 = errorbar(degree_ru, avg_ru0_nml, e_nml_ru0);
            title('Minimum Distance vs Centroid Distance (ru0)')
            xlabel('Degree')
            ylabel('Minimum/Centroid Distance Ratio')
            subplot(2,1,2)
            p_nml_ru4 = errorbar(degree_ru, avg_ru4_nml, e_nml_ru4);
            title('Minimum Distance vs Centroid Distance (ru4)')
            xlabel('Degree')
            ylabel('Minimum/Centroid Distance Ratio')
          case 'multiple'    
            % generate joined graph for ratio comparison
            plot(degree_ru, avg_ru4_nml,'-ok')
            hold on;
            plot(degree_ru, avg_ru0_nml,':ok')
            legend('ru0','ru4');
            xlabel('Degree')
            ylabel('Centroid/Minimum Distance Ratio')
            title('Centroid/Minimum Distance Comparison per frame')
          otherwise
              disp('Command not recognized. Please try again.')
        end
    case 'centroid'
        switch plottype
            case 'subplot'

                subplot(2,1,1)
                errorbar(degree_ru, avg_cendist_ru0, e_cendist_ru0);
                xlabel('Degree')
                ylabel('Centroid Distance (m)')
                title('ru0 Centroid Distance per frame')
                subplot(2,1,2)
                errorbar(degree_ru, avg_cendist_ru4, e_cendist_ru4);
                xlabel('Degree')
                ylabel('Centroid Distance (m)')
                title('ru4 Centroid Distance per frame')
             case 'multiple'
                 plot(degree_ru, avg_cendist_ru0,'-ok')
                 hold on;
                 plot(degree_ru, avg_cendist_ru4,':ok')
                 legend('ru0','ru4');
                 xlabel('Degree')
                 ylabel('Centroid Distance (m)')
                 title('Centroid Distance Comparison per frame') 
        end
        case 'both'  
                subplot(2,1,1)
                plot(degree_ru,avg_cendist_ru0,'-ok', degree_ru, avg_min_ru0,':ok')
                xlabel('degree')
                ylabel('distance (m)')
                legend('centroid distance','minimum distance')
                title('ru0')
                subplot(2,1,2)
                plot(degree_ru, avg_cendist_ru4,'-ok', degree_ru, avg_min_ru4,':ok')
                xlabel('degree')
                ylabel('distance (m)')
                legend('centroid distance','minimum distance')
                title('ru4')
        otherwise
              disp('Command not recognized. Please try again.')
        end



            
             
    
     
        
        
% end