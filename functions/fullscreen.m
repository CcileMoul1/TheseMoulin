%Procedure to put into fullscreen every open figure

function  fullscreen()	
	figs = findall(gcf,'Type','Figure');
	n = figs.Number;
	
	for i = 1 : n
		fig = figure(i);
		fig.Units = 'normalized';
		fig.Position = [0 0 1 1];
	end
end
