function data = dataLoad(filename)
% dataLoad lods the data given by the data-file "filename"
%
% Usage: data = dataLoad(filename) loads
%        the file and remove invalid data
%        and return an error message stating
%        the line(s) of invalid data
%        as descrped in the assignment.
%
% Author: Janus Johansen


data = load(filename);

%  definere, hvad der er gyldigt/ugyldigt udfra givet information fra opgaven
lowtemp=data(:,1)<10;
hightemp=data(:,1)>60;
neggroth = data(:,2)<0;
invalidtype = ~ismember(data(:,3),1:4);

%fjerner ugyldigt data
data = data(~lowtemp & ~hightemp & ~neggroth & ~invalidtype,:);

%finder hvor de ugyldige data er
lowtemp = find(lowtemp)';
neggroth = find(neggroth)';
invalidtype = find(invalidtype)';
hightemp = find(hightemp)';


% errors (skriver hvor der er fejl) hvis der er nogle
if ~isempty(lowtemp)
    fprintf('temperature too low in line nr: %s \n', strjoin(string(lowtemp),', '));
end
if ~isempty(hightemp)
    fprintf('temperature too high in line nr: %s \n', strjoin(string(hightemp),', '));
end
if ~isempty(neggroth)
    fprintf('Growth rate not a posetive nr, in line nr: %s \n', strjoin(string(neggroth),', '));
end
if ~isempty(invalidtype)
    fprintf('Invalid bacteria type in line nr: %s \n', strjoin(string(invalidtype),', '));
end
end
