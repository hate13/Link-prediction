function [ train test ] = DivideNet( net, ratioTrain)
%%����ѵ�����Ͳ��Լ�����֤ѵ������ͨ
    num_testlinks = ceil((1-ratioTrain) * nnz(net)/2);      
    % ȷ�����Լ��ı���Ŀ
    [xindex, yindex] = find(tril(net));  linklist = [xindex yindex];    
    % �����磨�ڽӾ��������еı��ҳ���������linklist  
    clear xindex yindex;  
    % Ϊÿ�������ñ�־λ���ж��Ƿ���ɾ��
    test = sparse(size(net,1),size(net,2));                 
    while (nnz(test) < num_testlinks)
        
        %---- ���ѡ��һ����
        index_link = ceil(rand(1) * length(linklist));        
        uid1 = linklist(index_link,1); 
        uid2 = linklist(index_link,2);    
        
        %---- �ж���ѡ�����˽ڵ�uid1��uid2�Ƿ�ɴ���ɴ���ɷ�����Լ�������������ѡһ����
        net(uid1,uid2) = 0;     net(uid2,uid1) = 0;
        % �������ߴ���������ȥ�����ж��ڵ���������Ƿ���ͨ
        tempvector = net(uid1,:);
        % ȡ��uid1һ���ɴ�ĵ㣬������һά����
        sign = 0;  
        % ��Ǵ˱��Ƿ���Ա��Ƴ���sign=0��ʾ���ɣ� sign=1��ʾ����
        uid1TOuid2 = tempvector * net + tempvector;        
        % uid1TOuid2��ʾ�����ڿɴ�ĵ�
        if uid1TOuid2(uid2) > 0
            sign = 1;               
            % �������ɴ�
        else
            while (nnz(spones(uid1TOuid2) - tempvector) ~=0)   
            % ֱ���ɴ�ĵ㵽���ȶ�״̬����Ȼ���ܵ���uid2���˱߾Ͳ��ܱ�ɾ��
                tempvector = spones(uid1TOuid2);
                uid1TOuid2 = tempvector * net + tempvector;    
                % �˲���uid1TOuid2��ʾK���ڿɴ�ĵ�
                if uid1TOuid2(uid2) > 0
                    sign = 1;      
                     % ĳ���ڿɴ�
                    break;
                end
            end
        end 
        % ����-�ж�uid1�Ƿ�ɴ�uid2
        
        %----���˱߿�ɾ������֮������Լ��У������˱ߴ�linklist���Ƴ�
        if sign == 1 %�˱߿���ɾ��
            linklist(index_link,:) = []; 
            test(uid1,uid2) = 1;
        else
            linklist(index_link,:) = [];
            net(uid1,uid2) = 1;   
            net(uid2,uid1) = 1;
        end   
        % ����-�жϴ˱��Ƿ����ɾ��������Ӧ����
    end   
    % ������while��-���Լ��еı�ѡȡ���
    train = net;  test = test + test';
    % ����Ϊѵ�����Ͳ��Լ�
end
