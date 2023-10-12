% 假设你的输入数据为120列特征向量，存储在一个120xN的矩阵data中，其中N是特征向量的数量。
A = feature_all_P2_11hao(14:end,2:end-1);%P2
% A = feature_all_15hao(:,2:end-1);%P1
% 确定哪些元素是NaN或inf
% nan_elements = isnan(A) | isinf(A);
% 
% % 确定哪些列包含NaN或inf
% nan_columns = any(nan_elements, 1);
nan_columns = [10 28 46 64 82 105];
% 从矩阵中删除包含NaN或inf的列
A(:, nan_columns) = [];

% 假设你想将数据降维到3维，调用自适应PCA函数：
data=A;
numDims = 17;
[reducedData, weights] = adaptivePCA(data, numDims);

% reducedData 就是降维后的数据，是一个3xN的矩阵，每列为一个降维后的特征向量。
% weights 是自适应权重，它是一个长度为3的向量，表示每个主成分的权重。
% reducedData(:,end+1)=P1_task_comp;%P1
reducedData(:,end+1)=P2_task_comp;%P2
% reducedData(:,end+1)=NOO(14:end);
%% 
% 输出降维后的特征向量矩阵大小
disp(['降维后的特征向量矩阵大小: ', num2str(size(reducedData))]);
correlation = corr(reducedData);
last_column = correlation(:, end); % 获取相关性矩阵的最后一列

% 获取最大值和最小值的索引
[~, max_indices] = maxk(last_column, 3);
[~, min_indices] = mink(last_column, 3);

% 获取最大值和最小值以及它们所在的行号
max_values = last_column(max_indices);
min_values = last_column(min_indices);
max_row_indices = max_indices;
min_row_indices = min_indices;

disp('最大三个值:');
disp(max_values);
disp('所在列:');
disp(max_row_indices);

disp('最小三个值:');
disp(min_values);
disp('所在列:');
disp(min_row_indices);
reducedData2=reducedData;