function plot_clusters(data, membership)
    % [k, d] = size(centroids);
    [N, k] = size(membership);
    hold on 
    % plot centroids
    % for i = 1:k
    %    scatter(centroids(i, 1), centroids(i, 2), 'd', 'filled');
       
    % end

    for i = 1:k
        points = data(membership(:,i) == 1, :);
        scatter(points(:,1), points(:,2), 'filled');
    end 
    hold off
end