function [ thisauc ] = AA( train, test )
%% ����AAָ�겢����AUCֵ
    train1 = train ./ repmat(log(sum(train,2)),[1,size(train,1)]); 
    % ����ÿ���ڵ��Ȩ�أ�1/log(k_i),�����ģ����ʱ��Ҫ�ֿ鴦��
    train1(isnan(train1)) = 0; 
    train1(isinf(train1)) = 0;  
    % ������Ϊ0�õ����쳣ֵ��Ϊ0
    sim = train * train1;   clear train1;  
    % ʵ�����ƶȾ���ļ���
    thisauc = CalcAUC(train,test,sim, 10000);  
    % ���⣬�����ָ���Ӧ��AUC
end
