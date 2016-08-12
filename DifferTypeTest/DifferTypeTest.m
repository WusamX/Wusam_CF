clear clc
zz={'results1','results2'};
for z=1:2
load ga
%remove those users who have voted less than 20 items
[M,N]=size(ga.train);
for i=1:M
    Vote(i)=length(nonzeros(ga.train(i,:)));
end
IdxMenor=find(Vote<20);
[ga.train,ps]=removerows(ga.train,IdxMenor);%去掉训练集中评分个数少于20的用户
[ga.test,ps]=removerows(ga.test,IdxMenor);%去掉测试集中评分个数少于20的用户
clear i M N ps IdxMenor Vote

%remove the all-zero vector
for i=1:size(ga.train,2)
    num_zero(i)=sum(ga.train(:,i));%计算每个项目列中评分的和
end
idx_zero=find(num_zero==0);%找到没有任何用户评分过的项目，并将其去掉
ga.train=removerows(ga.train',idx_zero);
ga.train=ga.train';%将降低稀疏性的训练集矩阵转置
clear i num_zero idx_zero

knear=[5 10 20 30 40 50 60 80 100 130 160 200];
[M,N]=size(ga.test);
NoUser=50;
randUser=randperm(M);%returns a random permutation of the integers 返回测试集中所有用户编号随机排列的的向量
clear M N 
disp('FOR COCLUSTERCORRELATION COSINE CORRELATION ADJUSTEDCOSINE SIMILARITY')
for i=1:length(knear)
    fprintf('knear = %d \n', knear(i))
    [Mae_coclustercorrela{i}]=CF(ga,knear(i),'coclustercorrelation',randUser,NoUser);
    %[Mae_cosine{i}]=CF(ga,knear(i),'cosine',randUser,NoUser);
    [Mae_correla{i}]=CF(ga,knear(i),'correlation',randUser,NoUser);
    [Mae_adjusted{i}]=CF(ga,knear(i),'adjustedcosine',randUser,NoUser);
end
clear NoUser i  knear randUser ga ans
save(zz{z}, 'Mae_coclustercorrela', 'Mae_correla', 'Mae_adjusted') 
end