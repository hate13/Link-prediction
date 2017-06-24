%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%                     ����Ԥ�� --- ���������Ե���·Ԥ���㷨                      %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%               (1)���ھֲ���Ϣ (2)����·�� (3)����������ߵ��㷨                %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%    ��ÿ�����ݼ���     step-1 ����ѵ�����Ͳ��Լ�                                %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%                       step-2 ���ڴ˻������������㷨�ľ��ȣ�AUC��               %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%                       �ظ�ǰ����������numOfExperiment�� ��ȡƽ��ֵ�ͷ���       %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
%% �����趨�� �趨ѵ�����ı��� �� ����ʵ��Ĵ���
ratioTrain = 0.5;                 %ѵ��������
numOfExperiment = 10;             %����ʵ��Ĵ���
%% �õ������ݼ�����
dataname = strvcat('facebook'); 
datapath = 'G:\';                 %���ݼ����ڵ�·��
% ����ĸ�ʽ
% ��һ�У��㷨��
% ������һ�У�ÿ���㷨�ڶ��ʵ���еķ��
% �����ڶ��У�ÿ���㷨�ڶ��ʵ���е�ƽ��ֵ��
% �м����ݣ�ÿ���㷨�ڶ��ʵ���еľ���ֵ��

%% ��·Ԥ�����
for ith_data = 1:1                              
    % ����ÿһ������
    tempcont = strcat('���ڴ���� ', int2str(ith_data), '������...', dataname(ith_data,:));
    disp(tempcont);
    tic;
    thisdatapath = strcat(datapath,dataname(ith_data,:));           % ��ith�����ݵ�·��
    linklist = load(thisdatapath);                                  % �������ݣ��ߵ�list��
    net = FormNet(linklist); clear linklist;                        % ���ݱߵ�list�����ڽӾ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%  ÿ�����ݼ��� numOfExperiment �ζ���ʵ�飬 �������н���浽��ʵ�������Ԥ�����������׵ľ��������Լ����ֵ�ͷ���
    aucOfallPredictor = [];                                         % ���ڴ洢100��ʵ��Ľ������j�б�ʾ��j��ʵ��
    PredictorsName = [];                                            % ��¼Ԥ������˳��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %----- ��ʼ numOfExperiment ��ʵ���ѭ��
    for ith_experiment = 1:numOfExperiment
        if mod(ith_experiment,10) == 0
            tempcont = strcat(int2str(ith_experiment),'%... ');
            disp(tempcont);
        end
        %%% step-1 ����ѵ�����Ͳ��Լ�����֤ѵ��������ͨ��
        [train, test] = DivideNet(net,ratioTrain);                  % ����ѵ�����Ͳ��Լ������������Ǿ���
        train = sparse(train); test = sparse(test);
        train = spones(train + train'); test = spones(test+test');
        ithAUCvector = []; Predictors = [];                         % ���ڴ洢��ǰʵ��������Ԥ�����ľ���
        %%% step-2 ����train set����test set��nonexistent set�����нڵ�Բ���������ڣ����ߵĿ����ԣ����ó�AUC
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% ���ھֲ���Ϣ���㷨
        disp('CN...');
        tempauc = CN(train, test);                       % Common Neighbor
            Predictors = [Predictors '%CN	'];      ithAUCvector = [ithAUCvector tempauc];
        
        disp('Jaccard...');
        tempauc = Jaccard(train, test);                  % Jaccard Index
             Predictors = [Predictors 'Jaccard	'];  ithAUCvector = [ithAUCvector tempauc];  
        
        disp('AA...');
        tempauc = AA(train, test);                       % Adar-Adamic Index
             Predictors = [Predictors 'AA	'];      ithAUCvector = [ithAUCvector tempauc];  
        
        disp('RA...');
        tempauc = RA(train, test);                       % Resourse Allocation
             Predictors = [Predictors 'RA	'];      ithAUCvector = [ithAUCvector tempauc];  

        %%% ƫ�������������㷨
        disp('PA...');
        tempauc = PA(train, test);                       % Preferential Attachment
             Predictors = [Predictors 'PA	'];      ithAUCvector = [ithAUCvector tempauc];          
        

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% ����·�����㷨
        disp('LocalPath...');
        tempauc = LocalPath(train, test, 0.0001);        % Local Path Index
             Predictors = [Predictors 'LocalP	'];   ithAUCvector = [ithAUCvector tempauc];  
        
        disp('Katz 0.01...');
        tempauc = Katz(train, test, 0.01);               % Katz Index ����ȡ0.01
             Predictors = [Predictors 'Katz.01	'];   ithAUCvector = [ithAUCvector tempauc];  

             
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% ����������ߵ��㷨
        disp('ACT...');
        tempauc = ACT(train, test);                      % Average commute time
             Predictors = [Predictors 'ACT	'];       ithAUCvector = [ithAUCvector tempauc];  
        
        disp('RWR 0.85...');
        tempauc = RWR(train, test, 0.85);                % Random walk with restart ����ȡ0.85
             Predictors = [Predictors 'RWR.85	'];   ithAUCvector = [ithAUCvector tempauc];  
        
        
        %disp('SimRank 0.8...');
        %tempauc = SimRank(train, test, 0.8);            % SimRank
        %     Predictors = [Predictors 'SimR	'];   ithAUCvector = [ithAUCvector tempauc];  
        
        
        disp('LRW 5...');
        tempauc = LRW(train, test, 5, 0.85);             % Local random walk ����ȡ��5
             Predictors = [Predictors '~_5	'];       ithAUCvector = [ithAUCvector tempauc];  
        
        disp('SRW 5...');
        tempauc = SRW(train, test, 5, 0.85);             % Superposed random walk ����ȡ��5
             Predictors = [Predictors '~_5	'];       ithAUCvector = [ithAUCvector tempauc];  
             
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% ���˴εõ����㷨���ȣ����������浽����aucOfallPredictor�У�����������ƽ��ֵ�ͷ���
        aucOfallPredictor = [aucOfallPredictor; ithAUCvector]; PredictorsName = Predictors;
    end % numOfExperiment �ζ���ѭ������
    %% write the results for this data (dataname(ith_data,:))
    avg_auc = mean(aucOfallPredictor,1); var_auc = var(aucOfallPredictor,1);
    respath = strcat(datapath,'result\',dataname(ith_data,:),'_res.txt');      %����������·�����ļ���
    dlmwrite(respath,{PredictorsName}, '');
    dlmwrite(respath,[aucOfallPredictor; avg_auc; var_auc], '-append','delimiter', '	','precision', 4);
    toc;
end % �������ݼ������
