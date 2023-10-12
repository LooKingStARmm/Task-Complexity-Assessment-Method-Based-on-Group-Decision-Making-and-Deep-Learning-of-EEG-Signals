%%使用P2的16个数据训练，使用P1的12个数据测试
res = klk_P2;
res2=klk_P1;
% 划分训练集和测试集
temp_train = randperm(18);
temp_test = randperm(18);

% 训练集数据
% P_train = res(temp_train(1:18), 1:16)';
% T_train = res(temp_train(1:18), 17)';
P_train = res(:, 1:16)';
T_train = res(:, 17)';
M = size(P_train, 2);

% 测试集数据
% P_test = res2(temp_test(1:18), 1:16)';
% T_test = res2(temp_test(1:18), 17)';
P_test = res2(:, 1:16)';
T_test = res2(:, 17)';
N = size(P_test, 2);

% 数据归一化
[P_train, ps_input_train] = mapminmax(P_train, 0, 1);
[P_test, ps_input_test] = mapminmax(P_test, 0, 1);
[T_train, ps_output_train] = mapminmax(T_train, 0, 1);
[T_test, ps_output_test] = mapminmax(T_test, 0, 1);

% 数据平铺
P_train = double(reshape(P_train, 16, 1, 1, M));
P_test = double(reshape(P_test, 16, 1, 1, N));
T_train = T_train';
T_test = T_test';

% 数据格式转换
for i = 1 : M
    p_train{i, 1} = P_train(:, :, 1, i);
end
for i = 1 : N
    p_test{i, 1} = P_test(:, :, 1, i);
end

% 创建模型
layers = [
    sequenceInputLayer(16) % 建立输入层
    lstmLayer(6, 'OutputMode', 'last') % LSTM层
    reluLayer % Relu激活层
    fullyConnectedLayer(1) % 全连接层
    regressionLayer]; % 回归层

% 参数设置
options = trainingOptions('adam', ...
    'MiniBatchSize', 30, ...
    'MaxEpochs', 500, ...
    'InitialLearnRate', 1e-2, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.5, ...
    'LearnRateDropPeriod', 800, ...
    'Shuffle', 'every-epoch', ...
    'Plots', 'training-progress', ...
    'Verbose', false);

% 训练模型
net = trainNetwork(p_train, T_train, layers, options);

% 仿真预测
T_sim1 = predict(net, p_train);
T_sim2 = predict(net, p_test);

% 数据反归一化
T_sim1 = mapminmax('reverse', T_sim1, ps_output_train);
T_sim2 = mapminmax('reverse', T_sim2, ps_output_test);

% 均方根误差
error1 = sqrt(sum((T_sim1' - T_train).^2) ./ M);
error2 = sqrt(sum((T_sim2' - T_test).^2) ./ N);
residual1 = T_train - T_sim1;
rmse1=sqrt(mean(residual1.^2));
residual2 = T_test - T_sim2;
rmse2=sqrt(mean(residual2.^2));
% 查看网络结构
analyzeNetwork(net)

% 使用以下代码可视化LSTM模型的结构
figure;
plot(net);


%%  绘图
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'训练集预测结果对比'; ['RMSE=' num2str(rmse1)]};
title(string)
xlim([1, M])
grid
figure
plot(1: N, T_test, 'r-*', 1: N, T_sim2, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'测试集预测结果对比'; ['RMSE=' num2str(rmse2)]};
title(string)
xlim([1, N])
grid
R1 = 1 - norm(T_train - T_sim1')^2 / norm(T_train - mean(T_train))^2;
R2 = 1 - norm(T_test  - T_sim2')^2 / norm(T_test  - mean(T_test ))^2;
disp(['训练集数据的R2为：', num2str(R1)])
disp(['测试集数据的R2为：', num2str(R2)])
mae1 = sum(abs(T_sim1' - T_train)) ./ M ;%mae
mae2 = sum(abs(T_sim2' - T_test )) ./ N ;
disp(['训练集数据的MAE为：', num2str(mae1)])
disp(['测试集数据的MAE为：', num2str(mae2)])
mbe1 = sum(T_sim1' - T_train) ./ M ;%  MBE
mbe2 = sum(T_sim2' - T_test ) ./ N ;
disp(['训练集数据的MBE为：', num2str(mbe1)])
disp(['测试集数据的MBE为：', num2str(mbe2)])