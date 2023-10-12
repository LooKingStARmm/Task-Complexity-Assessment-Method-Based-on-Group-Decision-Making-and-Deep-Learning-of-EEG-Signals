% 假设您的训练数据存储在train_features和train_labels矩阵中
% 假设您的验证数据存储在val_features和val_labels矩阵中
train_features=klk_P2(:,1:16);
train_labels=klk_P2(:,17);
val_features=klk_P1(:,1:12);
val_labels=klk_P1(:,13);
% 定义超参数
num_heads = 4;
model_size = 128;
feed_forward_size = 512;
num_layers = 4;
max_epochs = 10;
learning_rate = 0.001;
batch_size = 32;


fc_layer = fullyConnectedLayer(1, 'Name', 'fc');
output_layer = regressionLayer('Name', 'output');

transformer_model = [
    input_layer
    sequence_input_layer
    transformer_layers
    fc_layer
    output_layer
];

% 初始化权重
transformer_model = initializeWeights(transformer_model);

% 定义优化器
optimizer = adamOptimzer(learning_rate);

% 训练模型
num_samples = size(train_features, 1);
num_batches = floor(num_samples / batch_size);

for epoch = 1:max_epochs
    shuffled_indices = randperm(num_samples);
    
    for batch = 1:num_batches
        batch_indices = shuffled_indices((batch-1)*batch_size+1 : batch*batch_size);
        batch_features = train_features(batch_indices, :)';
        batch_labels = train_labels(batch_indices)';
        
        % 前向传播
        % ...
        
        % 计算损失
        % ...
        
        % 反向传播
        % ...
        
        % 更新权重
        % ...
    end
    
    % 验证模型
    % ...
end

% 在验证集上进行预测
val_predictions = zeros(size(val_labels));
for i = 1:size(val_features, 1)
    val_sequence = val_features(i, :)';
    
    % 前向传播
    % ...
    
    % 得到预测值
    % ...
    
    val_predictions(i) = predicted_value;
end

% 计算验证误差等其他指标
% ...

% 显示预测结果和真实标签的对比
figure;
plot(val_labels, 'DisplayName', 'True Labels');
hold on;
plot(val_predictions, 'DisplayName', 'Predicted Labels');
legend('show');
title('True vs. Predicted Labels');
xlabel('Sample');
ylabel('Label Value');
