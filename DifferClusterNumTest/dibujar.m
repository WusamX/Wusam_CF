clear; clc

CoClusterCorrelaUser=[];
CoClusterCorrelaItem=[];

for m=1:2    %�����μ����result�����������н����ͼ
   s=['results', int2str(m)];
   load(s)
for i=1:12 %number of neighbors     %����ÿ��result�еĽ������result��ÿ�����ƶ����Ͷ�Ӧ�Ļ����û��ͻ�����Ŀ��MAEֵ������ȡ����
    for j=1:6%number of groups
       CoClusterCorreltemp(j)=Mae_CoClusterCorrela{i,j}.UserBased;
       CoClusterCorreltemp1(j)=Mae_CoClusterCorrela{i,j}.ItemBased;
    end
    MaeCoClusterCorrelaUser(i,:)=CoClusterCorreltemp;%�������û��Ĳ�ͬ���಻ͬ���ڵ�MAEֵ��ȡ������������һ������
    MaeCoClusterCorrelaItem(i,:)=CoClusterCorreltemp1;    

end
clear CoClusterCorreltemp CoClusterCorreltemp1
clear Mae_CoClusterCorrela i j
 coclustercorrela(m,:)=reshape([MaeCoClusterCorrelaItem MaeCoClusterCorrelaUser],1,[]); %��CoClusterCorrela���͵Ļ����û��ͻ�����Ŀ��MAE����ÿһ��ƴ�ӳ���������ÿ��result����һ��
 
 %combining all the experimente results
 CoClusterCorrelaUser=[CoClusterCorrelaUser; MaeCoClusterCorrelaUser];%��ÿ��result�Ļ����û���CoClusterCorrela���ƾ�������ƴ��
 CoClusterCorrelaItem=[CoClusterCorrelaItem; MaeCoClusterCorrelaItem];
 
end
coclustercorrela=reshape(coclustercorrela,1,[]);%all the experimental results for cosine ������result��CoClusterCorrelaƴ�ӳ�һ��
%% for coclustercorrela

knear=[5 10 20 30 40 50 60 80 100 130 160 200];
kcluster=[5 10 20 30 40 50];
 %for coclustercorrela
 options={'-+y', '-om','-*c','-xr','-sg','-db'};
 color={'y','m','c','r','g','b'};
 for i=1:length(kcluster)
     clear temp temp1
     for j=1:length(knear)
         temp(j,:)=CoClusterCorrelaUser(j:12:12+j,i);%ѡȡÿ��result�е�i j ��Ӧ��MAEֵ����������
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
 
 

 
 


