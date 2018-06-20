function [omega, avg_J] = trainNN(list_id, X, y, T, e, quiet=false, init=false)
    % load constants
    source global.m;

    m = size(X,1);
    n_features = size(X,2);
    n_lists = size(unique(list_id),1);

    % linear neural network parameter initialization
    if init == false
        disp('random initialization')
        omega = rand(n_features,1)*INIT_VAR;
    else
        omega = load(init).omega;
    end

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

        % save temporary model
        tmp_model_file = sprintf("tmp/model_%d.m", t);
        save(tmp_model_file, "omega");
    end
end
