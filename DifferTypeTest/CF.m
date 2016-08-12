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
    VoteTest{i}=nonzeros(ga.test(i,:));%all the rating values of test set ;test数据集中所有非零评分的值放到M个行向量中，每个行向量中的是原始矩阵i行中的非零值
end
for i=1:M
    IdxItem{i}=find(ga.test(i,:)~=0); %all the nonzero items of each user in the test set;每个用户非零评分的列索引放到i行向量中，总共M个行向量
    lengthItem(i)=length(IdxItem{i});%统计test数据集中每个用户非零评分的个数，构成一个列向量
end
clear i  N 


PreUserItem=cell(M,1);

%select randomly * users as test set
for i=1:NoUser
    clear temp temp1
    randUser=randUser(1:NoUser);
    Item=IdxItem{randUser(i)};%得到每个随机用户评过分的项目的索引
    fprintf('idx-user  %d  user %d\n', [randUser(i),i])
    for j=1:lengthItem(randUser(i))
%         fprintf('Item %d\n',j)
        user=randUser(i);
        item=Item(j);
        [temp(j)]=CollaFilterUser(ga.train,item,user,knear,method);%对随机用户群中的每一个用户的每一个评过分的项目做出预测评分
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



