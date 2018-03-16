#!/usr/bin/env octave
% command line arguments:
% usage: cross-validation.m test_set model

% suppress output
more off;

% pararrayfun is in the 'general' package
pkg load general;

% load constants
source global.m;

% read arguments on the command line
arg_list = argv ();
test_file = arg_list{1,1};
model_file = arg_list{2,1};

disp(sprintf('loading model file %s', model_file));
omega = load(model_file).omega;

disp('loading cross-validation data...')
data_dev = load(test_file);

list_id_dev = data_dev(:,1);
Xdev = data_dev(:,2:size(data_dev,2)-1);
y_dev = data_dev(:,size(data_dev,2));

disp('cross-validation...')
z_dev =  Xdev * omega;

% average Kendall's tau
tau = 0;

for i = (1:size(unique(list_id_dev)))
    id = list_id_dev(i);
    y_rank = ranks(y_dev(find(list_id_dev == list_id_dev(i)),:));
    z = ranks(z_dev(find(list_id_dev == list_id_dev(i)),:));

    if size(y_rank,1)==1
        tau = tau + 1;
    else
        k = kendall(y_rank, z);
        if isnan(k)
            k = 0;
        end
        tau = tau + k;
    end
end

tau = tau / size(unique(list_id_dev),1)
