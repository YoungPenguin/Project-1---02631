function result = dataStatistics(data, statistic)
% dataStatistics outputs a certent statistic for the data
%
% Usage: result = dataStatistics(data, statistic)
%                 calculate and return diffrent statistics
%                 descriping the loaded data
%
% Author: Frederik Lykke Andersen

switch(statistic)
    %% beregner de nødventige ting der er beskrevet i opgaven
    case "mean temperature"
        result = mean(data(:,1));
    case "mean growth rate"
        result = mean(data(:,2));
    case "std temperature"
        result = std(data(:,1));
    case "std growth rate"
        result = std(data(:,2));
    case "rows"
        result = length(data);
    case "mean cold growth rate"
        result = mean(data(data(:,1)<20,2));
    case "mean hot growth rate"
        result = mean(data(data(:,1)>50,2));
    otherwise
        % fail value
        result = 'Error';
end
end