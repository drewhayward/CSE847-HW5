load USPS

[N, d] = size(A);

[V,D] = eig(A'*A);
%[U, S, V] = svd(A);

ks = [10 50 100 200];

for i = 1:numel(ks)
    P = V(:, d - (ks(i) - 1):end);
    
    reconstructed = A*P*P';

    error = mean(sum((reconstructed - A).^2,2))

    A1 = reshape(reconstructed(2,:), 16, 16);
    filename1 = sprintf("digit_1_%d", i);
    imshow(A1','InitialMagnification', 'fit');
    savefig(filename1);

    A2 = reshape(reconstructed(2,:), 16, 16);
    filename2 = sprintf("digit_2_%d", i);
    imshow(A2', 'InitialMagnification', 'fit');
    savefig(filename2);
end