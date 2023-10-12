res = klk_P2;
%%  划分训练集和测试集
temp = randperm(18);
P_train = res(temp(1:14), 1:16)';
T_train = res(temp(1:14), 17)';
M = size(P_train, 2);
% P_test = res(temp(15:end), 1:16)';
P_test = klk_P1(15:end, 1:12)';
% T_test = res(temp(15:end), 17)';
T_test = klk_P1(15:end, 13)';
N = size(P_test, 2);

%%  数据归一化
[P_train, ps_input] = mapminmax(P_train, 0, 1);
P_test = mapminmax('apply', P_test, ps_input);
[T_train, ps_output] = mapminmax(T_train, 0, 1);
T_test = mapminmax('apply', T_test, ps_output);

%%  数据平铺
P_train =  double(reshape(P_train, 16, 1, 1, M));
P_test  =  double(reshape(P_test , 16, 1, 1, N));
T_train = T_train';
T_test  = T_test' ;

%%  数据格式转换
for i = 1 : M
    p_train{i, 1} = P_train(:, :, 1, i);
end
for i = 1 : N
    p_test{i, 1}  = P_test( :, :, 1, i);
end

%%  创建模型
layers = [
    sequenceInputLayer(16)               % 建立输入层
    lstmLayer(6, 'OutputMode', 'last')  % LSTM层
    reluLayer                           % Relu激活层 
    fullyConnectedLayer(1)              % 全连接层
    regressionLayer];                   % 回归层

%%  参数设置
options = trainingOptions('adam', ...      % Adam 梯度下降算法
    'MiniBatchSize', 30, ...               % 批大小
    'MaxEpochs', 500, ...                 % 最大迭代次数
    'InitialLearnRate', 1e-2, ...          % 初始学习率为
    'LearnRateSchedule', 'piecewise', ...  % 学习率下降
    'LearnRateDropFactor', 0.5, ...        % 学习率下降因子
    'LearnRateDropPeriod', 800, ...        % 经过 800 次训练后 学习率为 0.01 * 0.5
    'Shuffle', 'every-epoch', ...          % 每次训练打乱数据集
    'Plots', 'training-progress', ...      % 画出曲线
    'Verbose', false);

%%  训练模型
net = trainNetwork(p_train, T_train, layers, options);

%%  仿真预测
T_sim1 = predict(net, p_train);
T_sim2 = predict(net, p_test);

%%  数据反归一化
T_sim1 = mapminmax('reverse', T_sim1, ps_output);
T_sim2 = mapminmax('reverse', T_sim2, ps_output);

%%  均方根误差
error1 = sqrt(sum((T_sim1' - T_train).^2) ./ M);
error2 = sqrt(sum((T_sim2' - T_test ).^2) ./ N);

%%  查看网络结构
analyzeNetwork(net)
%%  绘图
figure
plot(1: M, T_train, 'r-*', 1: M, T_sim1, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'训练集预测结果对比'; ['RMSE=' num2str(error1)]};
title(string)
xlim([1, M])
grid
figure
plot(1: N, T_test, 'r-*', 1: N, T_sim2, 'b-o', 'LineWidth', 1)
legend('真实值', '预测值')
xlabel('预测样本')
ylabel('预测结果')
string = {'测试集预测结果对比'; ['RMSE=' num2str(error2)]};
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