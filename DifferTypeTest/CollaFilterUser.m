function [PreUserItem]=CollaFilterUser(data,item,user,knear,method)

%INPUT:
%data: matriz of user-item
%item: idx of the item, for example, when it is 15, it means the 15th item
%user: idx of the user, for example, when it takes 5, it means the 5th user
%knear: number of neigbors
%Kcluster: number of clusters
%idx: idx of clusters
%method: similarity metric
%OUTPUT:
%PreUserItem: the predicted rating
%%
%copyright (c) 2013 WUSAM.
%wuxin.software@gmail.com


%load similarity matriz of users
switch lower(method)
    case 'cosine'
        load('SimilitudCosineUser.mat');
    case 'correlation'
        load('SimilitudCorrelationUser.mat');
    case 'adjustedcosine'
        load('SimilitudAdjustedCosineUser.mat');
    case 'coclustercorrelation'
        load('SimilitudCoClusterCorrelationUser.mat');
end

    D_ALLitem=d(user,1:end); %similarity between all the users �������û������ƶ�
    [tempALL,temp1ALL]=sort(D_ALLitem,'descend');   %find the nearest neighbor �ҵ���ǰ�û�������ھ�
    IdxALL_vecino=temp1ALL(1:knear); %idx of neighbors 
    idx_user_rated=find(data(:,item)~=0);%users who have been rated for this item; �ҵ���Ŀ���Ƽ���Ŀitem���������ֵ��û�
    [ItemVecinoUser,IdxALLRate,IdxALLSim]=intersect(idx_user_rated,IdxALL_vecino);%users in these neighbors who have been rated this item �ҵ�����ھ��ж���Ŀ�������۵��û�
    if ~isempty(IdxALLSim) %�������ھ����ж�Ŀ����Ŀ���۹����û�
        SimVecino=D_ALLitem(ItemVecinoUser);
        RateItem=data(ItemVecinoUser,item)';%rating value of this item of those user who are also neighbor of the active user
        PreUserItem=(SimVecino*RateItem')/sum(SimVecino);
    end
    if isempty(IdxALLSim) %�������ھ���û�ж�Ŀ����Ŀ���۹����û�
        %if there is no set intersection of user neighbor set and users
        %who have voted for the active item
        DUserRated=D_ALLitem(idx_user_rated);  %similarity between all the users who voted for the active item and our active user �õ����ж�Ŀ����Ŀ���ֹ����û��뵱ǰ�û������ƶ�
        [UserRated,IdxUserRated]=sort(DUserRated,'descend');  % rearrange the above similarity
        IdxUserRated=idx_user_rated(IdxUserRated); % real idx of the rearranged users
        if length(idx_user_rated)<knear
            knear=length(idx_user_rated);
        end
        SimVecino=UserRated(1:knear);
        RateItem=data(IdxUserRated(1:knear),item)';%ratings about the active ite:m of those users with maximum similarity
        PreUserItem=(SimVecino*RateItem')/sum(SimVecino);
    end


