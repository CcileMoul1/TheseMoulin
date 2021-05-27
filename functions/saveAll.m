%Procedure to save into 'format_fig' every open figures. They are saved into the file named 'dossier'
% If a figure has a name, this name is used for the file's name. Else, the file name is 'figure_i' with i being the number of the figure.
function  saveAll(dossier,format_fig)	
	figs = findall(gcf,'Type','Figure');
	n = figs.Number;
	mkdir(dossier);
	for i = 1 : n
		disp(strcat(int2str(i),'/',int2str(n)))
		f = figure(i);
		name = f.Name;
		if strcmp(name,'')
			name = strcat('figure_',int2str(i));
		end
		saveas(f,strcat(dossier,'/',name),format_fig);
	end
end
