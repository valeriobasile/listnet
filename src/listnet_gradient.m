function grad = listnet_gradient (X, y, z, list_id)
    global CORES
    m = size(X,1);
    p = size(X,2);
    
    lx = @(i) X(find(list_id == list_id(i)),:);
    ly = @(i) y(find(list_id == list_id(i)),:);
    lz = @(i) z(find(list_id == list_id(i)),:);

    s1 = @(i) -(lx(i)' * topp(ly(i)));
    s2 = @(i) (1 / sum(exp(lz(i))));
    s3 = @(i) (lx(i)' * exp(lz(i)));
    

    g = @(i) (s1(i) + s2(i) * s3(i)); % n(i) x 1
    f = @(i) g(i)';

    grad = reshape(pararrayfun(CORES, f, 1:m, "VerboseLevel", 0),p,m)';
end
