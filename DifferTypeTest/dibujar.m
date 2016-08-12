clear; clc
CoClusterCorrelaUser=[];
CoClusterCorrelaItem=[];
% CosineUser=[];
% CosineItem=[];
CorrelaUser=[];
CorrelaItem=[];
AdjustUser=[];
AdjustItem=[];

for m=1:2    %�����μ����result�����������н����ͼ
   s=['results', int2str(m)];
   load(s)
for i=1:12 %number of neighbors     %����ÿ��result�еĽ������result��ÿ�����ƶ����Ͷ�Ӧ�Ļ����û��ͻ�����Ŀ��MAEֵ������ȡ����
       MaeCoClusterCorrelaUser(i)=Mae_coclustercorrela{i}.UserBased;
       MaeCoClusterCorrelaItem(i)=Mae_coclustercorrela{i}.ItemBased;
       
%        MaeCosineUser(i)=Mae_cosine{i}.UserBased;
%        MaeCosineItem(i)=Mae_cosine{i}.ItemBased;
  
       MaeCorrelaUser(i)=Mae_correla{i}.UserBased;
       MaeCorrelaItem(i)=Mae_correla{i}.ItemBased;
       
       MaeAdjustUser(i)=Mae_adjusted{i}.UserBased;
       MaeAdjustItem(i)=Mae_adjusted{i}.ItemBased;       
end

clear Mae_adjusted Mae_correla Mae_coclustercorrela i  %Mae_cosine

 %combining all the experimente results
 CoClusterCorrelaUser=[CoClusterCorrelaUser; MaeCoClusterCorrelaUser];%��ÿ��result�Ļ����û���CoClusterCorrela���ƾ�������ƴ��
 CoClusterCorrelaItem=[CoClusterCorrelaItem; MaeCoClusterCorrelaItem];
%  CosineUser=[CosineUser;MaeCosineUser];%��ÿ��result�Ļ����û���cosine���ƾ�������ƴ��
%  CosineItem=[CosineItem;MaeCosineItem];
 CorrelaUser=[CorrelaUser; MaeCorrelaUser];
 CorrelaItem=[CorrelaItem; MaeCorrelaItem];
 AdjustUser=[AdjustUser; MaeAdjustUser];
 AdjustItem=[AdjustItem; MaeAdjustItem];
 end
clear m
knear=[5 10 20 30 40 50 60 80 100 130 160 200];
 figure(4)
 plot(knear,nanmean(CoClusterCorrelaItem),'-sr','markersize',8,'MarkerFaceColor','r');
 hold on; grid on
 %plot(knear,nanmean(CosineItem),'-ob','markersize',8,'MarkerFaceColor','b');
 plot(knear,nanmean(CorrelaItem),'-dg','markersize',8,'MarkerFaceColor','g');
 plot(knear,nanmean(AdjustItem),'-ob','markersize',8,'MarkerFaceColor','b');
 h=legend('COCLUSTERCORRELATION','CORRELATION','ADJUSTEDCOSINE');
 set(h,'fontsize',18,'fontweight','b');
 ylabel('MAE','fontsize',18,'fontweight','b'); xlabel('NO. neighbors','fontsize',18,'fontweight','b');
 title('COCLUSTERCORRELATION VS CORRELATION VS ADJUSTEDCOSINE (ItemBased)','fontsize',18,'fontweight','b');
 
 figure(5)
 plot(knear,nanmean(CoClusterCorrelaUser),'-sr','markersize',8,'MarkerFaceColor','r');
 hold on; grid on
 %plot(knear,nanmean(CosineUser),'-ob','markersize',8,'MarkerFaceColor','b');
 plot(knear,nanmean(CorrelaUser),'-dg','markersize',8,'MarkerFaceColor','g');
 plot(knear,nanmean(AdjustUser),'-ob','markersize',8,'MarkerFaceColor','b');
 h=legend('COCLUSTERCORRELATION','CORRELATION','ADJUSTEDCOSINE');
 set(h,'fontsize',18,'fontweight','b');
 ylabel('MAE','fontsize',18,'fontweight','b'); xlabel('NO. neighbors','fontsize',18,'fontweight','b');
 title('COCLUSTERCORRELATION VS CORRELATION VS ADJUSTEDCOSINE (UserBased)','fontsize',18,'fontweight','b');

 figure(6)
 plot(knear,nanmean(CoClusterCorrelaUser),'-sr','markersize',8,'MarkerFaceColor','r');
 hold on
 plot(knear,nanmean(CoClusterCorrelaItem),'-ob','markersize',8,'MarkerFaceColor','b');
 grid on
 h=legend('UserBased', 'ItemBased');
 set(h,'fontsize',18,'fontweight','b');
 ylabel('MAE','fontsize',18,'fontweight','b'); xlabel('NO. neighbors','fontsize',18,'fontweight','b');
 title('ItemBased VS UserBased (COCLUSTERCORRELATION)','fontsize',18,'fontweight','b');
 
 


