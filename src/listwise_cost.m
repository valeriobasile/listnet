function J = listwise_cost(y,z, list_id)
    global CORES
    ly = @(i) y(find(list_id == list_id(i)),:);
    lz = @(i) z(find(list_id == list_id(i)),:);
    
    j = @(i) (-sum(topp(ly(i)) .* log( topp(lz(i)) )));
    J = pararrayfun(CORES, j,1:size(z,1), "VerboseLevel", 0);
end
