function [centroids, membership] = spectral_kmeans(data, k, iterations)
    % Use spectral relaxation to map the d-dimensional features to a k-dim space
    [N, d] = size(data);
    data = data';

    gram_matrix = data' * data;
    [V, D] = eig(gram_matrix);


    vectors = V(:, (end-(k-1)):end);

    % Recover the clusters using standard kmeans
    [centroids, membership] = kmeans(vectors, k, iterations);
end