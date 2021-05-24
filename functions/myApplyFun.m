function res = myApplyFun(fun,t,x,dim)
	%On initialise
    if dim ==1
        x = x';
    end
	res = fun(t(1),x(:,1));
	n = length(t);
	for i = 2 : n
		res = [res fun(t(i),x(:,i))];
	end
	if dim == 1 
        res = res';
    end
end