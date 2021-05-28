function drawMatrix(t,x,names,color)
	n = length(names);
	nbr = floor(n/12);
    
	%full figures
	for i = 1:nbr
		figure()
		for j = 1:12
			indice = (i-1)*12+j;
			subplot(4,3,j);
			plot(t,x(:,indice),color,'LineWidth',2);
			title(names{indice});
		end
	end
	
	
	if(mod(n,12) ~= 0)
		figure()
		m=n-nbr*12;
		for i = 1:m
			indice=nbr*12+i;
			subplot(4,3,i);
			plot(t,x(:,indice),color,'LineWidth',2);
			title(names{indice});
		end
	end
end
