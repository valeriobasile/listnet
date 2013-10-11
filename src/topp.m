% topp.m
% 
% This function computes the top-one probabilities of the elements of
% a given vector v

function t = topp(v)
    t = exp(v)/sum(exp(v));
end

