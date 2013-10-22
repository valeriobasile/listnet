function [omega, avg_J] = trainNN(list_id, X, y, T, e, quiet=false)
    % load constants
    source global.m;

    m = size(X,1);
    n_features = size(X,2);
    n_lists = size(unique(list_id),1);

    % linear neural network parameter initialization
    omega = rand(n_features,1)*INIT_VAR;

    for t = 1:T
        if quiet == false
            fprintf("iteration %d: ", t)
        end
        
        % forward propagation
        z =  X * omega;
         
        % cost
        if quiet == false
            fprintf("computing cost... ")
        end

        % with regularization
        J = listwise_cost(y,z, list_id) + ((z.*z)'.*LAMBDA);
        % without regularization
        %J = listwise_cost(y,z, list_id);
        
        % gradient
        if quiet == false
            fprintf("computing gradient...")
        end

        grad = listnet_gradient(X, y, z, list_id);
        
        % parameter update
        omega = omega - (e .* sum(grad',2));
        
        if quiet == false
            fprintf("\n")
        end
    end
end

