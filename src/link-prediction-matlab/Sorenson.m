function [ thisauc ] = Sorenson( train, test )
%% ����Sorensonָ�겢����AUCֵ
    sim = train * train;                                            
    % �������
    sim = triu(sim,1);
    deg_col = repmat(sum(train,2), [1 size(train,1)]);              
    % �����ĸ
    deg_col = triu(deg_col' + deg_col);
    sim = 2 * sim ./ deg_col;                             
    % ���ƶȾ���������
    sim(isnan(sim)) = 0; sim(isinf(sim)) = 0;
    thisauc = CalcAUC(train,test,sim, 10000);       
    % ���⣬�����ָ���Ӧ��AUC
end
