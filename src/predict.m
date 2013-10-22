#! /net/aistaff/basile/local/bin/octave -qf
# command line arguments:
# predict.m model drgfile

more off;

omega = load(argv(){1});
drgfile = argv(){2};
drg = load(drgfile);

list_id = drg(:,1);
X = drg(:,2:size(drg,2)-1);

z =  X * omega.omega;

# add a little random to avoid ties
r = @(i) (i+rand*0.02-0.01);

for id = unique(list_id)'
    indexes = find(list_id==id);
    a(indexes) = floor(ranks(arrayfun(r, z(indexes))));
endfor
ranks = a';


dlmwrite(sprintf('%s.pred', drgfile), ranks)

