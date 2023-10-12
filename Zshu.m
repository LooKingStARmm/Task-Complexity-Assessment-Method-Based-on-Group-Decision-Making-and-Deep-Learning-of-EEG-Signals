%% 对delta powe的同一步骤求Z数重构
%{
P2_12people_delta=[feature_all_P2_1hao(:,92) feature_all_P2_2hao(:,92) feature_all_P2_3hao(:,92) feature_all_P2_4hao(:,92) feature_all_P2_5hao(:,92) feature_all_P2_10hao(:,92) feature_all_P2_12hao(:,92) feature_all_P2_14hao(:,92) feature_all_P2_15hao(:,92) feature_all_P2_16hao(:,92) feature_all_P2_20hao(:,92) feature_all_P2_11hao(:,92)];
K=12;
A = mean(P12_12people_delta, 2);
ft1=sum(P12_12people_delta, 2);
ft=P12_12people_delta./ft1;
B=-1/log10(K)*sum(ft.*log10(ft),2);
A2=A.*B+0.3*(1-B);
figure(1)
plot(A);
hold on;
plot(A2);
hold on;
corr_values = corrcoef(data_P1);
P1_12people_delta=[feature_all_2hao(:,92) feature_all_3hao(:,92) feature_all_4hao(:,92) feature_all_5hao(:,92) feature_all_6hao(:,92) feature_all_7hao(:,92) feature_all_8hao(:,92) feature_all_9hao(:,92) feature_all_10hao(:,92) feature_all_13hao(:,92) feature_all_14hao(:,92) feature_all_15hao(:,92)];
%}

%% 对任务步骤进行专家评价后求Z数
K=3;  %专家数
A = mean(P1_task_pingjia, 2);
ft1=sum(P1_task_pingjia, 2);
ft=P1_task_pingjia./ft1;
B=-1/log10(K)*sum(ft.*log10(ft),2);
A2=A.*B+0.3*(1-B);%重构后的A值 
feature_all_2hao(:,end)=A2;
feature_all_3hao(:,end)=A2;
feature_all_4hao(:,end)=A2;
feature_all_5hao(:,end)=A2;
feature_all_6hao(:,end)=A2;
feature_all_7hao(:,end)=A2;
feature_all_8hao(:,end)=A2;
feature_all_9hao(:,end)=A2;
feature_all_10hao(:,end)=A2;
feature_all_13hao(:,end)=A2;
feature_all_14hao(:,end)=A2;
feature_all_15hao(:,end)=A2;
corr_coef = corrcoef(feature_all_15hao(:,2:end));%获得的是列与列之间的相关性
selected_corrs = corr_coef(abs(corr_coef) > 0.2);
% 获取最后31行107列数据，即107条曲线数据与得分曲线之间的相关系数
corr_values = corr_coef(end,1:end-1);
corr_values_max=max(corr_values)
% 对第一行进行排序，并保存排序后每个元素的下标
[sorted_row, indices] = sort(corr_values,'descend');
corr_values_Down=[sorted_row; indices]';%保存相关性的值到第一行，对应的特征的列号为第二行,降序排列
% corr_coef = corrcoef(A2)

corr_coef = corrcoef(normalized_A)
normalized_A(:,1)=-normalized_A(:,1)
normalized_A = normc(test1);