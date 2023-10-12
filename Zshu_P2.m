%% 对任务步骤进行专家评价后求Z数
K=3;  %专家数
A = mean(P2_task_pingjia, 2);
ft1=sum(P2_task_pingjia, 2);
ft=P2_task_pingjia./ft1;
B=-1/log10(K)*sum(ft.*log10(ft),2);
A2=A.*B+0.3*(1-B);%重构后的A值 
feature_all_P2_1hao(:,end)=A2;
feature_all_P2_2hao(:,end)=A2;
feature_all_P2_3hao(:,end)=A2;
feature_all_P2_4hao(:,end)=A2;
feature_all_P2_5hao(:,end)=A2;
feature_all_P2_6hao(13:end,end)=A2(14:end,:);
feature_all_P2_7hao(:,end)=A2;
feature_all_P2_9hao(:,end)=A2(14:end,:);
feature_all_P2_10hao(:,end)=A2;
feature_all_P2_11hao(:,end)=A2;
feature_all_P2_12hao(:,end)=A2;
feature_all_P2_14hao(:,end)=A2;
feature_all_P2_15hao(:,end)=A2;
feature_all_P2_16hao(:,end)=A2;
feature_all_P2_17hao(:,end)=A2;
feature_all_P2_20hao(:,end)=A2;
%% 
corr_coef = corrcoef(feature_all_P2_9hao(14:end,2:end));%获得的是列与列之间的相关性
selected_corrs = corr_coef(abs(corr_coef) > 0.2);
% 获取最后31行107列数据，即107条曲线数据与得分曲线之间的相关系数
corr_values = corr_coef(end,1:end-1);
corr_values_max=max(corr_values)
% 对第一行进行排序，并保存排序后每个元素的下标
[sorted_row, indices] = sort(corr_values,'descend');
corr_values_Down=[sorted_row; indices]';%保存相关性的值到第一行，对应的特征的列号为第二行,降序排列
% corr_coef = corrcoef(A2)
%%
corr_coef = corrcoef(unnamed);
selected_corrs = corr_coef(abs(corr_coef) > 0.2);
% 获取最后31行107列数据，即107条曲线数据与得分曲线之间的相关系数
corr_values = corr_coef(end,1:end-1);
corr_values_max=max(corr_values)
% 对第一行进行排序，并保存排序后每个元素的下标
[sorted_row, indices] = sort(corr_values,'descend');
corr_values_Down=[sorted_row; indices]';%保存相关性的值到第一行，对应的特征的列号为第二行,降序排列
% corr_coef = corrcoef(A2)