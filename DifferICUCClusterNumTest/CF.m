function [Mae]=CF(ga,knear,method,randUser,NoUser)
%knear:  number of neigbor 
%Kcluster: number of groups
%method: similarity method, it can be 'cosine', 'correlation','adjustedcosine'
%randUser: idx of randomly choosed  users
%NoUser: number of randomly choosed users


% %obtain the similitud matrix
% [d]=SimilitudItems(ga.train','cosine');
% save SimilitudCosineUser d
% [d]=SimilitudItems(ga.train','correlation');
% save SimilitudCorrelationUser d
% [d]=SimilitudItems(ga.train','AdjustedCosine');
% save SimilitudAdjustedCosineUser d

%copyright (c) 2013 WUSAM.
%wuxin.software@gmail.com

% prediction
[M,N]=size(ga.test);
for i=1:M
    VoteTest{i}=nonzeros(ga.test(i,:));%all the rating values of test set ;test���ݼ������з������ֵ�ֵ�ŵ�M���������У�ÿ���������е���ԭʼ����i���еķ���ֵ
end
for i=1:M
    IdxItem{i}=find(ga.test(i,:)~=0); %all the nonzero items of each user in the test set;ÿ���û��������ֵ��������ŵ�i�������У��ܹ�M��������
    lengthItem(i)=length(IdxItem{i});%ͳ��test���ݼ���ÿ���û��������ֵĸ���������һ��������
end
clear i  N 


PreUserItem=cell(M,1);

%select randomly * users as test set
for i=1:NoUser
    clear temp temp1
    randUser=randUser(1:NoUser);
    Item=IdxItem{randUser(i)};%�õ�ÿ������û������ֵ���Ŀ������
    fprintf('idx-user  %d  user %d\n', [randUser(i),i])
    for j=1:lengthItem(randUser(i))
%         fprintf('Item %d\n',j)
        user=randUser(i);
        item=Item(j);
        [temp(j)]=CollaFilterUser(ga.train,item,user,knear,method);%������û�Ⱥ�е�ÿһ���û���ÿһ�������ֵ���Ŀ����Ԥ������
        [temp1(j)]=CollaFilter(ga.train,item,user,knear,method);       
    end
    Pre.UserBased{i}=temp;
    Pre.ItemBased{i}=temp1;

end
for i=1:NoUser
    Mae.UserBased(i)=nansum(nansum(abs(Pre.UserBased{i}-VoteTest{randUser(i)}'))/length(Pre.UserBased{i}));
    Mae.ItemBased(i)=nansum(nansum(abs(Pre.ItemBased{i}-VoteTest{randUser(i)}'))/length( Pre.ItemBased{i}));
   
end
fprintf('for knear= %d, similarity method= %s; \n', [knear, method] );
Mae.UserBased=nanmean(Mae.UserBased);
Mae.ItemBased=nanmean(Mae.ItemBased);



