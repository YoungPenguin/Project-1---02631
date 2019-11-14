%% main script 
% 
% Udviklet med matlab 2018b
%
%
% Usage: tager imod bruger input og kalder de funktioner der er nødvendige 
%
% Author: Frederik Lykke Andersen

% vi er sikre på at vi starter med tomme værdier (OCD)
data   = [];
data2  = [];
% vi diffinere et default filter der har alle som vi starter ud med
filter = [5,0,0];
while true
    % menu
    dodod = menu('wut u want?','1. Indlæs data.', '2. Filtrer data.',...
        '3. Vis statistik.','4. Generer diagrammer','5. Afslut.');
    switch dodod
        case 1
            %% load data med menu
            [filename,path] = uigetfile('*');
            if isequal(filename,0)
                errordlg('User selected Cancel','File Error');
            else
                disp(['User selected ', fullfile(path,filename)]);
                data = dataLoad(filename);
                disp('file was loaded');
            end
        case 2
            %% filter 
            dodod2 = menu('Wert?','bakterie type', 'growth rate interval');          
            if ~isempty(data)
                switch dodod2
                    case 1
                        % anvender filter i bunden af main script for valg
                        % af bakteris type
                        dodod3 = menu('Wert?','Salmonella enterica', 'Bacillus cereus','Listeria','Brochothrix thermosphacta','All');
                        filter(1) = dodod3;
                    case 2
                        % anvender filter i bunden af main script til valg
                        % af interval af growth rate interval
                        filter(2)= str2double(input('lower limit','s'));
                        filter(3)= str2double(input('upper limit','s'));
                        
                    case 3
                        % default filter // intet filter
                        filter = [5,0,0];
                end
            else
                h=questdlg('Please load data','wut are you doin','OK','OK');
                switch h
                    case 'OK'
                end
            end
        case 3
            %% statestik 
            statdodod = menu('Wert?','Mean Temperature', 'Mean Growth rate',...
                'Std Temperature','Std Growth rate','Rows','Mean Cold Growth rate',...
                'Mean Hot Growth rate');
            if ~isempty(data)
                % gør lige hvad der står
                switch statdodod
                    case 1
                        statistic = 'mean temperature';
                    case 2
                        statistic = 'mean growth rate';
                    case 3
                        statistic = 'std temperature';
                    case 4
                        statistic = 'std growth rate';
                    case 5
                        statistic = 'rows';
                    case 6
                        statistic = 'mean cold growth rate';
                    case 7
                        statistic = 'mean hot growth rate';
                end
                result = dataStatistics(data2, statistic);
                disp(result);
            else
                h=questdlg('Please load data','wut are you doin','OK','OK');
                switch h
                    case 'OK'
                end
            end
        case 4
            if ~isempty(data)
                dataPlot(data2);
            else
                h=questdlg('Please load data','wut are you doin','OK','OK');
                switch h
                    case 'OK'
                end
            end
        case 5
            % alt bliver lukket og stoppet 
            h=questdlg('Are you sure you want to close the application','wut are you doin','OK','OK');
            switch h
                case 'OK'
                    close all;
                    break;
            end
        case 0
            % alt bliver lukket og stoppet blot med brug af de andre afslut
            % knapper
            h=questdlg('Are you sure you want to close the application','wut are you doin','OK','OK');
            switch h
                case 'OK'
                    close all;
                    break;
            end
    end
    %% filter, filter for bakterietype, growth rate og default
    if filter(1)== 5
        tfilter = true(length(data),1);
    else
        tfilter = data(:,3) == filter(1);
    end
    
    if filter(2)
        lfilter = data(:,2)> filter(2);
    else
        lfilter = true(length(data),1);
    end
    
    if filter(3)
        ufilter = data(:,2)< filter(3);
    else
        ufilter = true(length(data),1);
    end
    data2 = data(tfilter & lfilter & ufilter,:);
end