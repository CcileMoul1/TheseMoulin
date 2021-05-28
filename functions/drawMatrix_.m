function drawMatrix_(ts,xs,names,colors)	
	taille = length(ts);
	n = length(names);
	nbr = floor(n/12); 
    
	% full figures
	for i = 1:nbr
		figure()
		for j = 1:12
			indice = (i-1)*12+j;
			subplot(4,3,j);
			hold on;
            for k = 1:taille
                t = ts{k};
                x = xs{k};
                color = colors{k};
                plot(t,x(:,indice),color,'LineWidth',2);
            end 
			title(names{indice});
			hold off;
		end
	end
	
	
	if(mod(n,12) ~= 0)
		figure()
		m=n-nbr*12;
		for i = 1:m
			indice=nbr*12+i;
			subplot(4,3,i);
			hold on;
            for k = 1:taille
                t = ts{k};
                x = xs{k};
                color = colors{k};
                plot(t,x(:,indice),color,'LineWidth',2);
            end 
			title(names{indice});
			hold off;
		end
	end
end