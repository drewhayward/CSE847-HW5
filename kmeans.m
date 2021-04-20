function [centroids, membership] = kmeans(data, k, iterations)
    [N, d] = size(data);
    
    % init centroids
    centroid_indices = randperm(N, k);

    centroids = data(centroid_indices, :);
    membership = get_membership(data, centroids);

    % Alternate procedure
    errors = [];
    prev_error = -1;
    for i = 1:iterations
        centroids = get_centroids(data, membership);
        membership = get_membership(data, centroids);
        err = sse(data, centroids, membership);
        if prev_error == err
            break
        end
        prev_error = err;
        errors(end + 1) = err;

        clf;
        plot_clusters(data, membership);
        shg
        % input('Press enter')
    end
    savefig clusters

    % clf;
    % iters = numel(errors);
    % plot(linspace(1, iters, iters), errors);
    % savefig errors
    % clf;
end

function error = sse(data, centroids, membership)
    [N, d] = size(data);
    [k, d] = size(centroids);
    % Calculate dists
    dists = zeros(N, k);
    for group = 1:k
        dists(:, group) = vecnorm(data - centroids(group, :), 1, 2);
    end

    error = sum(membership .* dists, 'all');
end

function centroids = get_centroids(data, membership)
    [N, d] = size(data);

    centroids = ((membership' * data)' ./ sum(membership))';
end

function membership = get_membership(data, centroids)
    [N, d] = size(data);
    [k, d] = size(centroids);

    % Calculate centroid-point dists
    dists = zeros(N, k);
    for group = 1:k
        dists(:, group) = vecnorm(data - centroids(group, :), 1, 2);
    end
    [values, idxs] = min(dists');

    % make binary membership matrix
    membership = zeros(N, k);
    for i = 1:N
        membership(i, idxs(i)) = 1;
    end
end