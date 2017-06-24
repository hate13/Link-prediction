function [  thisauc ] = SimRank( train, test, lambda)
%% ����SimRankָ�겢����AUCֵ
    deg = sum(train,1);     
    % ��ڵ����ȣ�������������������
    lastsim = sparse(size(train,1), size(train,2)); 
    % �洢ǰһ���ĵ����������ʼ��Ϊȫ0����
    sim = sparse(eye(size(train,1))); 
    % �洢��ǰ���ĵ����������ʼ��Ϊ��λ����
    while(sum(sum(abs(sim-lastsim)))>0.0000001)    
    % ��������̬���ж�����
        lastsim = sim;  sim = sparse(size(train,1), size(train,2));                                           
        for nodex = 1:size(train,1)-1      
        %��ÿһ�Խڵ��ֵ���и���
            if deg(nodex) == 0
                continue;
            end
            for nodey = nodex+1:size(train,1)                    
            %-----����x���ھӺ͵�y���ھ�����ɵ����нڵ�Ե�ǰһ������������
                if deg(nodey) == 0
                    continue;
                end
                sim(nodex,nodey) = lambda * sum(sum(lastsim(train(:,nodex)==1,train(:,nodey)==1))) / (deg(nodex)*deg(nodey));
            end
        end
        sim = sim+sim'+ sparse(eye(size(train,1)));
    end
    thisauc = CalcAUC(train,test,sim, 10000);    
    % ���⣬�����ָ���Ӧ��AUC
end
