% function [p__nml_fe0,p_nml_fe4] = plot_fe(fe0,fe4)

% This function is used to plot the results obtained from the prompt m-file.

clear plot

degree_fe = [50 40 30 20 10 0 -10 -20 -30];
data = input('Which comparison would you like to plot? Please enter: ''ratio'',''centroid'', or ''both'': ','s');
plottype = input('How would you like your results plotted? Please enter: ''subplot'', ''multiple'', or ''cancel'': ','s');

% calculate average values for centroid and minimum distance
% create normalized data by generating ratio between centroid and minimum
% distance 

        min_fe0 = fe0(1:2:length(fe0),:);
        cendist_fe0 = fe0(2:2:length(fe0),:);
        avg_min_fe0 = mean(min_fe0);
        avg_cendist_fe0 = mean(cendist_fe0);
        e_cendist_fe0 = std(cendist_fe0(:,:));
        fe0_nml = (min_fe0)./(cendist_fe0);
        e_nml_fe0 = std(fe0_nml);
        avg_fe0_nml = mean(fe0_nml);
        
        
        min_fe4 = fe4(1:2:length(fe4),:);
        cendist_fe4 = fe4(2:2:length(fe4),:);
        avg_min_fe4 = mean(min_fe4);
        avg_cendist_fe4 = mean(cendist_fe4(:,:));
        e_cendist_fe4 = std(cendist_fe4(:,:));
        fe4_nml = (min_fe4)./(cendist_fe4);
        e_nml_fe4 = std(fe4_nml(:,:));
        avg_fe4_nml = mean(fe4_nml);
%         
%         
%         

switch data
    case 'ratio'
      switch plottype  
          case 'subplot'
              
        % generate subplots for fe0 & fe4
        subplot(2,1,1)
        p_nml_fe0 = errorbar(degree_fe, avg_fe0_nml, e_nml_fe0);
        title('Minimum Distance vs Centroid Distance (fe0)')
        xlabel('Minimum Distance (m)')
        ylabel('Minimum/Centroid Distance Ratio')
        
        subplot(2,1,2)
        p_nml_fe4 = errorbar(degree_fe, avg_fe4_nml, e_nml_fe4);
        title('Minimum Distance vs Centroid Distance (fe4)')
        xlabel('Minimum Distance (m)')
        ylabel('Minimum/Centroid Distance Ratio')
        
          case 'multiple'
              errorbar(degree_fe, avg_fe0_nml, e_nml_fe0,':ok');
              hold on;
              errorbar(degree_fe, avg_fe4_nml, e_nml_fe4,'-ok')
              xlabel('Degree')
              ylabel('Centroid/Minimum Distance Ratio')
              legend('fe0','fe4')
          otherwise
              disp('Command not recognized. Please try again.')
      end
    case 'centroid'
        switch plottype
            case 'subplot'
                subplot(2,1,1)
                errorbar(degree_fe, avg_cendist_fe0, e_cendist_fe0)
                xlabel('Degree')
                ylabel('Centroid Distance (m)')
                title('fe0 Centroid Distance per frame')
                subplot(2,1,2)
                errorbar(degree_fe, avg_cendist_fe4, e_cendist_fe4)
                xlabel('Degree')
                ylabel('Centroid Distance (m)')
                title('fe4 Centroid Distance per frame')
            case 'multiple'
                plot(degree_fe, avg_cendist_fe0,'-ok')
                hold on;
                plot(degree_fe, avg_cendist_fe4,':ok')
                legend('fe0','fe4');
                xlabel('Degree')
                ylabel('Centroid Distance (m)')
                title('Centroid Distance Comparison per frame')
            otherwise
              disp('Command not recognized. Please try again.')
                
        end
    case 'both'  
                subplot(2,1,1)
                plot(degree_fe,avg_cendist_fe0,'-ok')
                hold on;
                plot(degree_fe, avg_min_fe0,':ok')
                xlabel('degree')
                ylabel('distance (m)')
                legend('centroid distance','minimum distance')
                title('fe0')
                subplot(2,1,2)
                plot(degree_fe, avg_cendist_fe4,'-ok', degree_fe, avg_min_fe4,':ok')
                xlabel('degree')
                ylabel('distance (m)')
                legend('centroid distance','minimum distance')
                title('fe4')
        end
%  otherwise
%         disp('Command not recognized. Please try again.')
%         end
        

        
%         [row,col] = size(cendist_fe0);
%         for i = 1:row
%             e_fe0 = std(cendist_fe0(i,1:col));
%             subplot(row,col,i);
%             p_fe0(i) = plot(min_fe0(i,:),cendist_fe0(i,:));
%             xlswrite(filename,p_fe0,'fe_plot');
%             
%         end
%         
% end