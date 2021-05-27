function [d] = myCopyContainersMap(c)
    d = containers.Map();
    cle = keys(c);
    n = length(cle);
    for i = 1:n
        d(cle{i}) = c(cle{i});
    end
end