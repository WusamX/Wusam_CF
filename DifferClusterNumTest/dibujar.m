clear; clc

CoClusterCorrelaUser=[];
CoClusterCorrelaItem=[];

for m=1:2    %将几次计算的result遍历，以所有结果绘图
   s=['results', int2str(m)];
   load(s)
for i=1:12 %number of neighbors     %遍历每个result中的结果，将result中每种相似度类型对应的基于用户和基于项目的MAE值单独提取出来
    for j=1:6%number of groups
       CoClusterCorreltemp(j)=Mae_CoClusterCorrela{i,j}.UserBased;
       CoClusterCorreltemp1(j)=Mae_CoClusterCorrela{i,j}.ItemBased;
    end
    MaeCoClusterCorrelaUser(i,:)=CoClusterCorreltemp;%将基于用户的不同聚类不同近邻的MAE值提取出来单独构成一个矩阵
    MaeCoClusterCorrelaItem(i,:)=CoClusterCorreltemp1;    

end
clear CoClusterCorreltemp CoClusterCorreltemp1
clear Mae_CoClusterCorrela i j
 coclustercorrela(m,:)=reshape([MaeCoClusterCorrelaItem MaeCoClusterCorrelaUser],1,[]); %将CoClusterCorrela类型的基于用户和基于项目的MAE矩阵每一列拼接成行向量，每个result保存一行
 
 %combining all the experimente results
 CoClusterCorrelaUser=[CoClusterCorrelaUser; MaeCoClusterCorrelaUser];%将每个result的基于用户的CoClusterCorrela相似矩阵纵向拼接
 CoClusterCorrelaItem=[CoClusterCorrelaItem; MaeCoClusterCorrelaItem];
 
end
coclustercorrela=reshape(coclustercorrela,1,[]);%all the experimental results for cosine 将所有result的CoClusterCorrela拼接成一行
%% for coclustercorrela

knear=[5 10 20 30 40 50 60 80 100 130 160 200];
kcluster=[5 10 20 30 40 50];
 %for coclustercorrela
 options={'-+y', '-om','-*c','-xr','-sg','-db'};
 color={'y','m','c','r','g','b'};
 for i=1:length(kcluster)
     clear temp temp1
     for j=1:length(knear)
         temp(j,:)=CoClusterCorrelaUser(j:12:12+j,i);%选取每个result中的i j 对应的MAE值构成行向量
         temp1(j,:)=CoClusterCorrelaItem(j:12:12+j,i);
     end
     figure(1)
     plot(knear,nanmean(temp'),options{i},'markersize',8,'MarkerFaceColor',color{i});
     grid on
     hold on
     h= legend('No.Clusters=5','No.Clusters=10','No.Clusters=20','No.Clusters=30','No.Clusters=40','No.Clusters=50');
    set(h,'fontsize',18,'fontweight','b');
     ylabel('MAE','fontsize',18,'fontweight','b'); xlabel('NO. neighbors','fontsize',18,'fontweight','b');
     title('UserBased & CoClusterCorrelation','fontsize',18,'fontweight','b');
     figure(2)
     plot(knear,nanmean(temp1'),options{i},'markersize',8,'MarkerFaceColor',color{i});
     grid on
     hold on
     h=legend('No.Clusters=5','No.Clusters=10','No.Clusters=20','No.Clusters=30','No.Clusters=40','No.Clusters=50');
     set(h,'fontsize',18,'fontweight','b');
     ylabel('MAE','fontsize',18,'fontweight','b'); xlabel('NO. neighbors','fontsize',18,'fontweight','b');
     title('ItemBased & CoClusterCorrelation','fontsize',18,'fontweight','b');    
 end

 %from figure 1 and figure 2
 clear temp temp1 i j
 for i=1:length(kcluster)
     for j=1:length(knear)
         temp(j,:)=CoClusterCorrelaUser(j:12:12+j,i);
         temp1(j,:)=CoClusterCorrelaItem(j:12:12+j,i);
     end
     UBMaeMean(i,:)=nanmean(temp');
     IBMaeMean(i,:)=nanmean(temp1');
     clear temp temp1
 end
 figure(3)
 plot(knear,nanmean(UBMaeMean),'-dr','markersize',8,'MarkerFaceColor','r');
 hold on
 plot(knear,nanmean(IBMaeMean),'-ob','markersize',8,'MarkerFaceColor','b');
 grid on
 h=legend('UserBased', 'ItemBased');
 set(h,'fontsize',18,'fontweight','b');
 ylabel('MAE','fontsize',18,'fontweight','b'); xlabel('NO. neighbors','fontsize',18,'fontweight','b');
 title('ItemBased VS UserBased (CLUSTERMEAN, COCLUSTERCORRELATION)','fontsize',18,'fontweight','b');
 
 

 
 


