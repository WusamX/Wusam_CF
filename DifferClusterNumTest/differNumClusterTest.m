zz={'results1','results2','results3','results4','results5','results6'};
for z=1:2
load ga
%remove those users who have voted less than 20 items
[M,N]=size(ga.train);
for i=1:M
    Vote(i)=length(nonzeros(ga.train(i,:)));
end
IdxMenor=find(Vote<20);
[ga.train,ps]=removerows(ga.train,IdxMenor);%ȥ��ѵ���������ָ�������20���û�
[ga.test,ps]=removerows(ga.test,IdxMenor);%ȥ�����Լ������ָ�������20���û�
clear i M N ps IdxMenor Vote

%remove the all-zero vector
for i=1:size(ga.train,2)
    num_zero(i)=sum(ga.train(:,i));%����ÿ����Ŀ�������ֵĺ�
end
idx_zero=find(num_zero==0);%�ҵ�û���κ��û����ֹ�����Ŀ��������ȥ��
ga.train=removerows(ga.train',idx_zero);
ga.train=ga.train';%������ϡ���Ե�ѵ��������ת��
clear i num_zero idx_zero

knear=[5 10 20 30 40 50 60 80 100 130 160 200];
kcluster=[5 10 20 30 40 50];
[M,N]=size(ga.test);
NoUser=50;
randUser=randperm(M);%returns a random permutation of the integers ���ز��Լ��������û����������еĵ�����
clear M N 
disp('FOR COCLUSTERCORRELATION SIMILARITY')
for i=1:length(knear)
    for j=1:length(kcluster)
    fprintf('knear = %d, kcluster = %d \n', [knear(i), kcluster(j)])
    differCluster=['coclustercorrelation', int2str(kcluster(j))];
    [Mae_CoClusterCorrela{i,j}]=CF(ga,knear(i),differCluster,randUser,NoUser);
    end
end

clear NoUser i j  knear kcluster differCluster randUser ga ans 
save(zz{z},'Mae_CoClusterCorrela')
fprintf('result = %s \n',zz{z})
end