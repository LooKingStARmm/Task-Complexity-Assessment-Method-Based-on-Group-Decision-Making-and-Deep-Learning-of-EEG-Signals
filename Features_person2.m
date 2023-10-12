%% 用来获得两条曲线之间的皮尔逊相关性系数，研究不同参试者的同一步骤的特征值与表现的关系
datas1=feature_all_1hao(:,2:end-1);
datas2=feature_all_2hao(:,2:end-1);
datas3=feature_all_3hao(:,2:end-1);
datas4=feature_all_4hao(:,2:end-1);
datas5=feature_all_5hao(:,2:end-1);
datas6=feature_all_6hao(:,2:end-1);
datas7=feature_all_7hao(:,2:end-1);
datas9=feature_all_9hao(:,2:end-1);
datas10=feature_all_10hao(:,2:end-1);
datas11=feature_all_11hao(:,2:end-1);
datas12=feature_all_12hao(:,2:end-1);
datas14=feature_all_14hao(:,2:end-1);
datas15=feature_all_15hao(:,2:end-1);
datas16=feature_all_16hao(:,2:end-1);
datas17=feature_all_17hao(:,2:end-1);
datas20=feature_all_20hao(:,2:end-1);
% data = normalize(data1);%归一化
%% 代码用来获得六种波形共109列特征的名字
Delta={'FC','max_val', 'min_val', 'mean_val', 'std_val', 'rms_val', 'renyi','renyi_entropy','log_energy_entropy','shannon_entropy','tsallis_entropy','log_root_mean_square','teager_energy','kurtosis','skewness','complexity','hjorth_mobility','hjorth_activity';'Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta','Delta'};
Theta={'FC','max_val', 'min_val', 'mean_val', 'std_val', 'rms_val', 'renyi','renyi_entropy','log_energy_entropy','shannon_entropy','tsallis_entropy','log_root_mean_square','teager_energy','kurtosis','skewness','complexity','hjorth_mobility','hjorth_activity';'Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta','Theta'};
Alpha={'FC','max_val', 'min_val', 'mean_val', 'std_val', 'rms_val', 'renyi','renyi_entropy','log_energy_entropy','shannon_entropy','tsallis_entropy','log_root_mean_square','teager_energy','kurtosis','skewness','complexity','hjorth_mobility','hjorth_activity';'Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha','Alpha'};
BETA={'FC','max_val', 'min_val', 'mean_val', 'std_val', 'rms_val', 'renyi','renyi_entropy','log_energy_entropy','shannon_entropy','tsallis_entropy','log_root_mean_square','teager_energy','kurtosis','skewness','complexity','hjorth_mobility','hjorth_activity';'DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA','DETA'};
Gamma={'FC','max_val', 'min_val', 'mean_val', 'std_val', 'rms_val', 'renyi','renyi_entropy','log_energy_entropy','shannon_entropy','tsallis_entropy','log_root_mean_square','teager_energy','kurtosis','skewness','complexity','hjorth_mobility','hjorth_activity';'Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma','Gamma'};
Rawdata={'FC','max_val', 'min_val', 'mean_val', 'std_val', 'rms_val', 'renyi','renyi_entropy','log_energy_entropy','shannon_entropy','tsallis_entropy','log_root_mean_square','teager_energy','kurtosis','skewness','complexity','hjorth_mobility','hjorth_activity','ZB_DE','ZB_TH','ZB_AL','ZB_BE','ZB_GA';'Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','Rawdata','p','p','p','p','p'};
featureName_cell=horzcat(Delta,Theta,Alpha,BETA,Gamma,Rawdata);
%1bu
%
step_time1=[31	40	34	26	41	165	25		38	22	25	33	26	22	37	26];
step_time2=[20	9	18	8	16	10	7		13	15	24	9	11	6	8	12];
step_time3=[39	28	32	23	23	115	13		25	107	28	46	26	24	26	34];
step_time4=[23	12	15	18	13	50	12		46	20	37	13	7	14	12	14];
step_time5=[33	20	29	20	22	31	18		19	42	24	13	18	21	19	27];
step_time6=[20	13	13	16	14	29	13		13	20	12	14	15	14	8	13];
step_time7=[22	19	31	23	19	27	17		16	21	23	18	12	24	22	20];
step_time8=[11	8	16	7	9	26	7		10	14	10	12	11	20	9	8];
step_time9=[17	12	16	7	16	24	7		5	15	15	7	10	10	5	12];
step_time10=[45	23	28	24	32		23		19	45	53	52	33	84	25	30];
step_time11=[21	20	32	10	22	72	9		11	63	15	12	14	23	9	17];
step_time12=[21	24	41	28	21	21	18		22	35	37	21	25	33	22	31];
step_time13=[80	35	54	20	47	46	41		59	78	99	17	52	72	38	21];
step_time14=[34	10	37	79	15	13	30	45	11	39	41	34	47	35	11	35];
step_time15=[15	30	20	10	15	10	58	7	17	26	15	31	30	50	14	10];
step_time16=[11	37	17	7	10	40	6	23	59	56	85	38	19	25	28	32];
step_time17=[24	25	35	36	25	1	23	27	27	45	15	27	28	30	30	17];
step_time18=[52	39	47	44	51	48	39	38	33	72	78	33	48	43	43	36];
step_time19=[14	17	35	15	20	26	20	25	14	23	21	23	23	25	23	20];
step_time20=[31	14	37	33	39	26	23	24	29	29	44	29	35	32	25	31];
step_time21=[21	130	17	13	18	24	11	27	12	11	17	25	20	23	11	12];
step_time22=[52	35	37	40	33	82	11	33	26	29	88	33	20	23	26	25];
step_time23=[18	5	20	7	22	9	6	8	7	7	30	10	8	7	6	20];
step_time24=[27	29	35	73	24	89	30	51	13	31	34	14	17	17	21	45];
step_time25=[14	12	20	30	23	44	8	10	11	7	10	7	9	21	6	13];
step_time26=[10	12	33	8	17	16	5	7	8	9	10	11	8	9	11	5];
step_time27=[37	11	22	16	17	35	18	30	15	31	122	24	20	28	12	32];
step_time28=[17	22	31	29	26	19	5	23	22	23	12	15	21	22	23	24];
step_time29=[11	8	14	7	11	55	26	2	3	6	21	10	7	10	5	9];
step_time30=[45	26	40	54	54	77	36	39	37	37	58	33	26	41	34	60];
step_time31=[87	50	54	26	38	86	22	86	64	41	95	33	46	55	46	46];
%}

%
step_feature1=vertcat(datas1(1,:),datas2(1,:),datas3(1,:),datas4(1,:),datas5(1,:),datas6(1,:),datas7(1,:),datas10(1,:),datas11(1,:),datas12(1,:),datas14(1,:),datas15(1,:),datas16(1,:),datas17(1,:),datas20(1,:));j=2;
step_feature2=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=3;
step_feature3=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=4;
step_feature4=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=5;
step_feature5=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=6;
step_feature6=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=7;
step_feature7=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=8;
step_feature8=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=9;
step_feature9=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=10;
step_feature10=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=11;
step_feature11=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=12;
step_feature12=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=13;
step_feature13=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=14;
step_feature14=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(1,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=15;
step_feature15=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(2,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=16;
step_feature16=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(3,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=17;
step_feature17=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(4,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=18;
step_feature18=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(5,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=19;
step_feature19=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(6,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=20;
step_feature20=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(7,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=21;
step_feature21=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(8,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=22;
step_feature22=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(9,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=23;
step_feature23=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(10,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=24;
step_feature24=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(11,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=25;
step_feature25=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(12,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=26;
step_feature26=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(13,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=27;
step_feature27=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(14,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=28;
step_feature28=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(15,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=29;
step_feature29=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(16,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=30;
step_feature30=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(17,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));j=31;
step_feature31=vertcat(datas1(j,:),datas2(j,:),datas3(j,:),datas4(j,:),datas5(j,:),datas6(j-1,:),datas7(j,:),datas9(18,:),datas10(j,:),datas11(j,:),datas12(j,:),datas14(j,:),datas15(j,:),datas16(j,:),datas17(j,:),datas20(j,:));

step_feature_time1=[step_feature1,step_time1'];
step_feature_time2=[step_feature2,step_time2'];
step_feature_time3=[step_feature3,step_time3'];
step_feature_time4=[step_feature4,step_time4'];
step_feature_time5=[step_feature5,step_time5'];
step_feature_time6=[step_feature6,step_time6'];
step_feature_time7=[step_feature7,step_time7'];
step_feature_time8=[step_feature8,step_time8'];
step_feature_time9=[step_feature9,step_time9'];
step_feature_time10=[step_feature10,step_time10'];
step_feature_time11=[step_feature11,step_time11'];
step_feature_time12=[step_feature12,step_time12'];
step_feature_time13=[step_feature13,step_time13'];
step_feature_time14=[step_feature14,step_time14'];
step_feature_time15=[step_feature15,step_time15'];
step_feature_time16=[step_feature16,step_time16'];
step_feature_time17=[step_feature17,step_time17'];
step_feature_time18=[step_feature18,step_time18'];
step_feature_time19=[step_feature19,step_time19'];
step_feature_time20=[step_feature20,step_time20'];
step_feature_time21=[step_feature21,step_time21'];
step_feature_time22=[step_feature22,step_time22'];
step_feature_time23=[step_feature23,step_time23'];
step_feature_time24=[step_feature24,step_time24'];
step_feature_time25=[step_feature25,step_time25'];
step_feature_time26=[step_feature26,step_time26'];
step_feature_time27=[step_feature27,step_time27'];
step_feature_time28=[step_feature28,step_time28'];
step_feature_time29=[step_feature29,step_time29'];
step_feature_time30=[step_feature30,step_time30'];
step_feature_time31=[step_feature31,step_time31'];

% score= normalize(score1);归一化
% bad_cols = any(isnan(datas) | isinf(datas));
% % any函数用于判断一个矩阵中有没有非零元素，isinf和isnan函数分别返回矩阵A中是否包含inf或nan的逻辑数组
% 
% % 输出要删除的列的序号
% bad_col_indexes = find(bad_cols);
% fprintf('要删除的列的序号为：\n');
% disp(bad_col_indexes);
bad_cols=[7 8 10 25 26  28 43 44   46  61 62  64 79 80    82 97 98  100];
step_feature_time1(:, bad_cols) = [];
step_feature_time2(:, bad_cols) = [];
step_feature_time3(:, bad_cols) = [];
step_feature_time4(:, bad_cols) = [];
step_feature_time5(:, bad_cols) = [];
step_feature_time6(:, bad_cols) = [];
step_feature_time7(:, bad_cols) = [];
step_feature_time8(:, bad_cols) = [];
step_feature_time9(:, bad_cols) = [];
step_feature_time10(:, bad_cols) = [];
step_feature_time11(:, bad_cols) = [];
step_feature_time12(:, bad_cols) = [];
step_feature_time13(:, bad_cols) = [];
step_feature_time14(:, bad_cols) = [];
step_feature_time15(:, bad_cols) = [];
step_feature_time16(:, bad_cols) = [];
step_feature_time17(:, bad_cols) = [];
step_feature_time18(:, bad_cols) = [];
step_feature_time19(:, bad_cols) = [];
step_feature_time20(:, bad_cols) = [];
step_feature_time21(:, bad_cols) = [];
step_feature_time22(:, bad_cols) = [];
step_feature_time23(:, bad_cols) = [];
step_feature_time24(:, bad_cols) = [];
step_feature_time25(:, bad_cols) = [];
step_feature_time26(:, bad_cols) = [];
step_feature_time27(:, bad_cols) = [];
step_feature_time28(:, bad_cols) = [];
step_feature_time29(:, bad_cols) = [];
step_feature_time30(:, bad_cols) = [];
step_feature_time31(:, bad_cols) = [];
featureName_cell(:, bad_cols)=[];%特征名字
featureName2=featureName_cell(:,46:end);
% 计算107条曲线数据与得分曲线之间的皮尔逊相关系数
%% 对不同表现参数的结合

corr_coef = corrcoef(step_feature_time31(:,46:end));%获得的是列与列之间的相关性

selected_corrs = corr_coef(abs(corr_coef) > 0.2);
% 获取最后31行107列数据，即107条曲线数据与得分曲线之间的相关系数
corr_values = corr_coef(end,1:end-1);
corr_values_max=max(corr_values)
% 对第一行进行排序，并保存排序后每个元素的下标
[sorted_row, indices] = sort(corr_values,'descend');
corr_values_Down=[sorted_row; indices]';%保存相关性的值到第一行，对应的特征的列号为第二行,降序排列
%将相关性最高的特征与得分画在一张图
%{
subplot(3,1,1);
plot(data2(:,end));
xlabel('步骤');  % 设置横轴标签为时间
ylabel('值');  % 设置纵轴标签为幅值
title('得分');  % 设置图标题
subplot(3,1,2)
plot(data2(:,indices(1,1)));
xlabel('步骤');  % 设置横轴标签为时间
ylabel('值');  % 设置纵轴标签为幅值
title('步骤对应特征值');  % 设置图标题
subplot(3,1,3)
plot(data2(:,indices(1,2)));
xlabel('步骤');  % 设置横轴标签为时间
ylabel('值');  % 设置纵轴标签为幅值
title('步骤对应特征值');  % 设置图标题
%}


