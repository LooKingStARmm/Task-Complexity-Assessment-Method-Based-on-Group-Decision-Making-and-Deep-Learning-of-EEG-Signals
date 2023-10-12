function [reduced_features, coefficients, explained_variance] = my_pca(data, target_dimension)
    % 标准化数据
    normalized_data = zscore(data);

    % 计算协方差矩阵
    covariance_matrix = cov(normalized_data);

    % 计算特征向量和特征值
    [coefficients, eigenvalues] = eig(covariance_matrix);

    % 将特征值从大到小排序
    [~, indices] = sort(diag(eigenvalues), 'descend');
    coefficients = coefficients(:, indices);
    eigenvalues = eigenvalues(indices, indices);

    % 选择前 target_dimension 个主成分
    selected_components = coefficients(:, 1:target_dimension);

    % 将原始数据投影到新的低维空间
    reduced_features = normalized_data * selected_components;

    % 计算解释方差比例
    total_variance = sum(diag(eigenvalues));
    explained_variance = diag(eigenvalues) / total_variance;

    % 输出降维后的特征向量矩阵大小
    disp(['降维后的特征向量矩阵大小: ', num2str(size(reduced_features))]);
end