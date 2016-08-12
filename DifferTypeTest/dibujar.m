clear; clc
CoClusterCorrelaUser=[];
CoClusterCorrelaItem=[];
% CosineUser=[];
% CosineItem=[];
CorrelaUser=[];
CorrelaItem=[];
AdjustUser=[];
AdjustItem=[];

for m=1:2    %将几次计算的result遍历，以所有结果绘图
   s=['results', int2str(m)];
   load(s)
for i=1:12 %number of neighbors     %遍历每个result中的结果，将result中每种相似度类型对应的基于用户和基于项目的MAE值单独提取出来
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
 CoClusterCorrelaUser=[CoClusterCorrelaUser; MaeCoClusterCorrelaUser];%将每个result的基于用户的CoClusterCorrela相似矩阵纵向拼接
 CoClusterCorrelaItem=[CoClusterCorrelaItem; MaeCoClusterCorrelaItem];
%  CosineUser=[CosineUser;MaeCosineUser];%将每个result的基于用户的cosine相似矩阵纵向拼接
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
 
 


