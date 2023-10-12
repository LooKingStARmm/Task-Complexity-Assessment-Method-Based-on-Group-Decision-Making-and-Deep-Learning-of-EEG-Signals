%% 计算P2每一步的delta_psd均值
datas1=feature_all_P2_1hao(:,2:end-1);
datas2=feature_all_P2_2hao(:,2:end-1);
datas3=feature_all_P2_3hao(:,2:end-1);
datas4=feature_all_P2_4hao(:,2:end-1);
datas5=feature_all_P2_5hao(:,2:end-1);
% datas6=feature_all_P2_6hao(:,2:end-1);
datas7=feature_all_P2_7hao(:,2:end-1);
% datas9=feature_all_P2_9hao(:,2:end-1);
datas10=feature_all_P2_10hao(:,2:end-1);
datas11=feature_all_P2_11hao(:,2:end-1);
datas12=feature_all_P2_12hao(:,2:end-1);
datas14=feature_all_P2_14hao(:,2:end-1);
datas15=feature_all_P2_15hao(:,2:end-1);
datas16=feature_all_P2_16hao(:,2:end-1);
datas17=feature_all_P2_17hao(:,2:end-1);
datas20=feature_all_P2_20hao(:,2:end-1);
step_delta_P2=zeros(31,1);
for i=1:31
   step_delta_P2 (i)=mean([datas1(i,91),datas2(i,91),datas3(i,91),datas4(i,91),datas5(i,91),datas7(i,91),datas10(i,91),datas11(i,91),datas12(i,91),datas14(i,91),datas15(i,91),datas16(i,91),datas17(i,91),datas20(i,91)]);
end
%% 获取任务复杂度的六个权值
%任务复杂度指标
%AC:准确度    t1：单步时间   DF：难度系数   IC：界面复杂度  NOO：操作数   t2:时间压力 
AC=[79	88	36	94	87	99	99	97	94	88	84	84	41	77	94	43	73	80	97	94	69	74	78	81	80	88	88	88	97	81	72
]';
t1=[38	13	42	20	24	15	20	12	12	42	23	27	50	35	23	33	26	46	22	30	24	36	12	34	15	11	29	21	13	41	54
]';
DF=[4	4	5	4	5	5	5	3	4	6	4	5	7	4	3	4	2	5	2	5	4	6	5	5	5	5	5	2	4	4	5
]';
IC=[3	6	6	4	4	4	4	3	3	4	4	4	6	5	3	5	0	3	0	3	3	5	5	4	4	4	3	0	3	3	4
]';
NOO=[2	2	4	2	4	2	4	2	1	6	2	6	4	2	2	1	0	9	0	7	3	4	2	4	2	2	5	0	4	2	4
]';
t2=[35	20	45	25	25	20	20	15	15	40	25	25	45	30	25	35	30	45	25	35	25	35	15	35	15	15	30	25	25	45	35
]';
data_P2=[AC t1 DF IC NOO t2 step_delta_P2];
% 加载数据
X = data_P2(:, 1:6); % 自变量
y = data_P2(15:end, 7); % 因变量
%{
% 将数据分为训练集和测试集
train_ratio = 0.7;
train_size = floor(size(X, 1) * train_ratio);
X_train = X(1:train_size, :);
y_train = y(1:train_size);
X_test = X(train_size+1:end, :);
y_test = y(train_size+1:end);

% 对数据进行标准化
[X_train_norm, mu, sigma] = zscore(X_train);
X_test_norm = (X_test - mu) ./ sigma;

% 多元线性回归
b = regress(y_train, [ones(size(X_train_norm,1),1) X_train_norm]);

% 预测
y_pred = [ones(size(X_test_norm,1),1) X_test_norm] * b;

% 评估模型
mse = mean((y_test - y_pred).^2); % 均方误差
r2 = 1 - sum((y_test - y_pred).^2) / sum((y_test - mean(y_test)).^2); % 决定系数
% 绘制预测值与实际值对比图
figure
plot(y_test,'bo'); % 绘制实际值
hold on
plot(y_pred,'r*'); % 绘制预测值
xlabel('样本序号')
ylabel('特征值')
legend('实际值','预测值')
title('预测值与实际值对比')
%}
% 生成一个示例向量 delta_psd
% delta_psd = [y;y_P1];
% 对 delta_psd 进行标准化
% delta_psd_standardized = zscore(delta_psd);
% y=delta_psd_standardized(1:31);
% X=[X;X_P1];
% y=[y;y_P1];

%% 模型
%SVM 
mdl = fitrsvm(X(15:end,:), y, 'KernelFunction', 'rbf', 'Standardize', true);
y_pred = predict(mdl, X(15:end,:));
corr_coef = corrcoef([y_pred,y]);
% t = templateSVM('KernelFunction','rbf'); % 创建一个模板用于超参数搜索
% svm_mdl = fitrsvm(X,y,'OptimizeHyperparameters',{'BoxConstraint','KernelScale'},'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus','ShowPlots',true),'CVPartition',cv,'Standardize',true,'KFold',10,'Verbose',0,'Learner',t);

y_pred = predict(svm_mdl, X(15:end,:));
rmse = sqrt(mean((y_pred - y).^2))
MSE = mse(y_pred - y)


scatter(y, y_pred);
hold on;
plot([min(y), max(y)], [min(y), max(y)], '--r'); % 绘制对角线
hold off;
xlabel('真实值');
ylabel('预测值');
title('真实值 vs. 预测值');
%% 第一批数据
datas_P1_2=feature_all_2hao(:,2:end-1);
datas_P1_3=feature_all_3hao(:,2:end-1);
datas_P1_4=feature_all_4hao(:,2:end-1);
datas_P1_5=feature_all_5hao(:,2:end-1);
datas_P1_6=feature_all_6hao(:,2:end-1);
datas_P1_7=feature_all_7hao(:,2:end-1);
datas_P1_8=feature_all_8hao(:,2:end-1);
datas_P1_9=feature_all_9hao(:,2:end-1);
datas_P1_10=feature_all_10hao(:,2:end-1);
datas_P1_13=feature_all_13hao(:,2:end-1);
datas_P1_14=feature_all_14hao(:,2:end-1);
datas_P1_15=feature_all_15hao(:,2:end-1);
step_delta_P1=zeros(18,1);
for i=1:18
   step_delta_P1 (i)=mean([datas_P1_2(i,91),datas_P1_3(i,91),datas_P1_4(i,91),datas_P1_5(i,91),datas_P1_6(i,91),datas_P1_7(i,91),datas_P1_8(i,91),datas_P1_9(i,91),datas_P1_10(i,91),datas_P1_13(i,91),datas_P1_14(i,91),datas_P1_15(i,91)]);
end
%% 获取任务复杂度的六个权值
%任务复杂度指标
%AC:准确度    t1：单步时间   DF：难度系数   IC：界面复杂度  NOO：操作数   t2:时间压力 
AC_P1=[78	61	84	77	82	90	94	100	95	76	82	100	85	81	100	86	80	94
]';
t1_P1=[27	24	32	10	26	45	23	34	15	20	18	12	38	10	11	23	24	13
]';
DF_P1=[4	2	4	3	2	5	2	5	3	2	6	5	5	5	5	5	2	3
]';
IC_P1=[5	0	5	3	0	3	0	3	3	0	5	5	4	4	4	3	0	3
]';
NOO_P1=[2	0	1	2	0	9	0	7	3	0	4	2	4	2	2	5	0	3
]';
t2_P1=[30	25	35	15	30	45	25	35	30	25	35	15	35	15	15	30	25	20
]';

data_P1=[AC_P1 t1_P1 DF_P1 IC_P1 NOO_P1 t2_P1 step_delta_P1];
%% 获取第一批的预测值 
X_P1 = data_P1(:, 1:6); % 前六列是任务复杂度的六个因素
y_P1 = data_P1(:, 7); % 最后一列是每一组因素对应的特征值
% y_P1=delta_psd_standardized(32:end);
y_pred_P1 = predict(mdl, X_P1);
plot(y_pred_P1)
hold on
plot(y_P1)
%% 对y和y_pred进行标准化
y_bizozhun_P1=zscore(y_P1);
y_biaozhun_pred_P1=zscore(y_pred_P1);
corr_coef_biaozhun_P1=corrcoef([y_bizozhun_P1 y_biaozhun_pred_P1])
plot(y_bizozhun_P1)
hold on
plot(y_biaozhun_pred_P1)


rmse = sqrt(mean((y_pred_P1 - y_P1).^2))
MSE = mse(y_pred_P1 - y_P1)

corr_coef = corrcoef([y_pred_P1 y_P1])
scatter(y_P1, y_pred_P1);
hold on;
plot([min(y_P1), max(y_P1)], [min(y_P1), max(y_P1)], '--r'); % 绘制对角线
hold off;
xlabel('真实值');
ylabel('预测值');
title('真实值 vs. 预测值');

%% 分为训练集和验证集
x1=[];
x2=[];
x_test=x2(:,1:6);
y_test=x2(:,7);
x_train=x1(:,1:6);
y_train=x1(:,7);
mdl = fitrsvm(x_train, y_train, 'KernelFunction', 'rbf', 'Standardize', true);
y_pred1 = predict(mdl, x_train);

y_pred2 = predict(mdl, x_test);

corr_coef = corrcoef([y_pred1 y_train])
scatter(y_pred1,y_train);
hold on;
plot([min(y_train), max(y_train)], [min(y_train), max(y_train)], '--r'); % 绘制对角线
hold off;
xlabel('真实值');
ylabel('预测值');
title('真实值 vs. 预测值');

corr_coef = corrcoef([y_pred2 y_test])
scatter(y_pred2,y_test);
hold on;
plot([min(y_train), max(y_train)], [min(y_train), max(y_train)], '--r'); % 绘制对角线
hold off;
xlabel('真实值');
ylabel('预测值');
title('真实值 vs. 预测值');

data_P2=[data_P1;data_P2];
% 加载数据
X = data_P2.X;
y = data_P2.y;

% 划分训练集和验证集
cv = cvpartition(size(X,1),'HoldOut',0.3);
idx_train = training(cv);
idx_test = test(cv);

X_train = X(idx_train,:);
y_train = y(idx_train,:);
X_test = X(idx_test,:);
y_test = y(idx_test,:);

% SVM 模型训练
Mdl = fitrsvm(X_train, y_train, 'KernelFunction', 'gaussian', 'Standardize', true);

% 在验证集上进行预测
y_pred = predict(Mdl, X_test);

% 计算误差
mse = mean((y_pred - y_test).^2);
rmse = sqrt(mse);
mae = mean(abs(y_pred - y_test));
r = corrcoef(y_pred, y_test);

% 输出结果
fprintf('MSE: %.4f\n', mse);
fprintf('RMSE: %.4f\n', rmse);
fprintf('MAE: %.4f\n', mae);
fprintf('R: %.4f\n', r(1,2));


