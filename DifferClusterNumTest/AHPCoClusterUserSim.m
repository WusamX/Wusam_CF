function [ACCUserSim] = AHPCoClusterUserSim(ga,kcluster,method)
%计算基于层次分析法的联合聚类的用户之间相似度
%remove those users who have voted less than 20 items
[M,N]=size(ga.train);
for i=1:M
    Vote(i)=length(nonzeros(ga.train(i,:)));
end
IdxMenor=find(Vote<20);
[ga.train,ps]=removerows(ga.train,IdxMenor);%去掉训练集中评分个数少于20的用户
clear i M N ps IdxMenor Vote

%remove the all-zero vector
for i=1:size(ga.train,2)
    num_zero(i)=sum(ga.train(:,i));%计算每个项目列中评分的和
end
idx_zero=find(num_zero==0);%找到没有任何用户评分过的项目，并将其去掉
ga.train=removerows(ga.train',idx_zero);
ga.train=ga.train';%将降低稀疏性的训练集矩阵转置
clear i num_zero idx_zero
[P,Q]=size(ga.train);
%对项目维聚类
item=kmeans(ga.train',kcluster, 'distance',method,'emptyaction','drop');
m=1;
for i=1:kcluster 
    Item_idx_original=find(item==i);
    if ~isempty(Item_idx_original)
        for j=1:length(Item_idx_original)
            temp(:,j)=ga.train(:,Item_idx_original(j));
        end
        ColumnClusters{m}=temp;
        q(m)=nnz(temp)/numel(temp);
        [temp1]=SimilitudItems(temp',method);
        ItemCataUserSims{m}=temp1;
        clear temp temp1
%         p(m)=length(Item_idx_original);
        m=m+1;
    end
end
clear i j temp
%联合聚类
user=kmeans(ga.train,kcluster, 'distance',method,'emptyaction','drop');
n=1;
for i=1:kcluster
    User_idx_original=find(user==i);
    if ~isempty(User_idx_original)
        for j=1:m-1
            for k=1:length(User_idx_original)
                temp(k,:)=ColumnClusters{j}(User_idx_original(k),:);
            end
            UnitedClusters{n,j}=temp;
            ItemCatofeUserCat_w(j)=nnz(temp)/numel(temp); 
            clear temp
        end
        x=AHP(ItemCatofeUserCat_w,m-1);
        x(find(isnan(x)==1))=0;
        disp(x);
        ItemCat_ws(:,n)=x;
        for o=1:length(User_idx_original)
            temp1(o,:)=ga.train(User_idx_original(o),:);
        end
        RowClusters{n}=temp1;
        noec(n)=nnz(temp1)/numel(temp1);
        clear temp1 
        n=n+1;
    end
end
clear i j k 
%对准则层运用层次分析法
UserCat_w=AHP(noec,n-1);
disp(UserCat_w);
ItemCat_w=AHP(q,m-1);
disp(ItemCat_w);
w_sum=ItemCat_ws*UserCat_w;
disp(w_sum);
for i=1:P
    for j=1:P
        UserSimsSum=0;
        for k=1:m-1
            UserSimsSum=UserSimsSum+ItemCataUserSims{k}(i,j)*w_sum(k);
        end
        ACCUserSim(i,j)=UserSimsSum;
    end
end
end

