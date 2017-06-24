function [ thisauc ] = Jaccard( train, test )
%% ����jaccardָ�겢����AUCֵ
    sim = train * train;               
    % ��ɷ��ӵļ��㣬����ͬ��ͬ�ھ��㷨
    deg_row = repmat(sum(train,1), [size(train,1),1]);
    deg_row = deg_row .* spones(sim);                               
    % ֻ�豣�����Ӳ�Ϊ0��Ӧ��Ԫ��
    deg_row = triu(deg_row) + triu(deg_row');                      
    % ����ڵ��(x,y)�����ڵ�Ķ�֮��
    sim = sim./(deg_row.*spones(sim)-sim); clear deg_row;           
    % �������ƶȾ��� �ڵ�x��y������Ԫ����Ŀ = x��y�Ķ�֮�� - ������Ԫ����Ŀ
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;
    thisauc = CalcAUC(train,test,sim, 10000);      
    % ���⣬�����ָ���Ӧ��AUC
end
