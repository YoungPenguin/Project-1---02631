function dataPlot(data)
% dataPlot gets data from user input from "main script"
%
% Usage: dataPlot(data) The two plots:
%
% 1. “Number of bacteria”: Et søjlediagram af antallet af hver af de forskellige typer
%     Bacteria i data.
%
%2. “Growth rate by temperature”: Et diagram med Temperature p?a x-aksen og Growth
%    rate p?a y-aksen. X-aksen skal g?a fra 10 til 60 grader og y-aksen skal starte ved 0.
%    Plottet skal have ´et koordinatsystem med fire grafer, en for hver type Bacteria.
%    De forskellige grafer skal kunne skelnes fra hinanden for eksempel ved brug af
%    forskellige farver, markører eller linje-typer.
%
%
% Author: Janus Johansen

type1=data(data(:,3)==1,:);
type2=data(data(:,3)==2,:);
type3=data(data(:,3)==3,:);
type4=data(data(:,3)==4,:);
plotdata = [length(type1),length(type2),length(type3),length(type4)];

figure(1); clf;
% laver vinduet den ønskede størrelse 
set(gcf,'Position',[300,150,1200,600]);
subplot(1,2,1);

% NOTE: ja vi burde havde lavet dette med histc funktionen 
%       men sådan er det

%% the labeling of the bar chart is indspired from:
%http://fstang.me/utilities/2013/10/01/matlab-draw.html

% Plotter data.
x = 1:length(plotdata);
h = bar(x,plotdata);

%  Reducer aksens størrelse, så alle etiketter passer ind i figuren.
pos = get(gca,'Position');
set(gca,'Position',[pos(1), .25, pos(3) .65]) %skalere plottet 
% X-tick pos
Xt = x;

set(gca,'XTick',Xt);
% Sørg for, at hver streng er af samme længde
algos = ['      Salmonella enterica'; '          Bacillus cereus';
    '                 Listeria'; 'Brochothrix thermosphacta'];
%sætter akserne
ax = axis;
axis(axis);
Yl = ax(3:4);

% fjerner default labels
set(gca,'XTickLabel','')

% sætter det nye lable 
t = text(Xt,Yl(1)*ones(1,length(Xt)),algos(1:length(plotdata),:));
set(t,'HorizontalAlignment','right','VerticalAlignment','top', ...
    'Rotation',45, 'Fontsize', 8);
ylabel('Number of bacteria', 'Fontsize', 13)

%% scatter plot (plot 2)

title('Number of bacteria')
subplot(1,2,2);
hold on; % de 4 scatterplots for hver bakterietype
scatter(type1(:,1),type1(:,2));
scatter(type2(:,1),type2(:,2));
scatter(type3(:,1),type3(:,2));
scatter(type4(:,1),type4(:,2));
grid('on')
xlabel('Temperature', 'Fontsize', 13)
ylabel('Growth rate', 'Fontsize', 13)

%set the legend to the best location on the plot by using 'location' and 'best'
legend('type1','type2','type3','type4','Location','best');
title('Growth rate by temperature')
end