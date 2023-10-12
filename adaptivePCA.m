function [reducedData, weights] = adaptivePCA(data, numDims)
    % data: 输入数据，每列为一个特征向量
    % numDims: 降维后的维数
    
    % Step 1: 标准化数据
    meanData = mean(data, 1);
    stdData = std(data, 0, 1);
    standardizedData = (data - meanData) ./ stdData;
    
    % Step 2: 计算协方差矩阵
    covarianceMatrix = cov(standardizedData);
    
    % Step 3: 计算特征值和特征向量
    [eigenVectors, eigenValues] = eig(covarianceMatrix);
    
    % Step 4: 计算自适应权重
    eigenValues = diag(eigenValues);
    weights = eigenValues ./ sum(eigenValues);
    
    % Step 5: 选择降维维数
    [~, sortedIndices] = sort(weights, 'descend');
    selectedIndices = sortedIndices(1:numDims);
    selectedEigenVectors = eigenVectors(:, selectedIndices);
    selectedWeights = weights(selectedIndices);
    
    % Step 6: 降维变换
    reducedData = standardizedData * selectedEigenVectors;
    
    % Step 7: 反标准化
    for i = 1:numDims
        reducedData(:, i) = reducedData(:, i) * stdData(selectedIndices(i)) + meanData(selectedIndices(i));
    end
end
