function [PreUserItem]=CollaFilter(data,item,user,knear,method)

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


switch lower(method)
    case 'cosine'
        load('SimilitudCosineItem.mat');
    case 'correlation'
        load('SimilitudCorrelationItem.mat');
    case 'adjustedcosine'
        load('SimilitudAdjustedCosineItem.mat');
    case 'coclustercorrelation'
        load('SimilitudCoClusterCorrelationItem.mat');
end

     D_ALLitem=d(item,1:end); %distance between all the items
     [tempALL,temp1ALL]=sort(D_ALLitem,'descend');   %find the nearest neighbor
%      SimVecino=tempALL(1:knear); %similarity between the active item and its neighbors
     IdxALL_vecino=temp1ALL(1:knear); %idx of neighbors
     idx_user_rated=find(data(user,:)~=0);%idx of all the items which have been rated by the user
     [ItemVecinoUser,IdxALLRate,IdxALLSim]=intersect(idx_user_rated,IdxALL_vecino);%the items of the neighbors which has been rated by the user
     if ~isempty(IdxALLSim)
         SimVecino=D_ALLitem(ItemVecinoUser);
         RateItem=data(user,ItemVecinoUser);%ratings of the items in neigbors which have been rated by our active user
         MeanUser=sum(data(user,:))/length(nonzeros(data(user,:))); %mean rating of the active user
         RateItem=RateItem-MeanUser; %remove the mean from the rating value
         PreUserItem=(SimVecino*RateItem')/sum(SimVecino)+MeanUser;
     end
     if isempty(IdxALLSim)
         %if there is no set intersection of rating itms of the
         %active user and the neighbors
         DUserRated=D_ALLitem(idx_user_rated);  %distance of all the rating items of the active user
         [UserRated,IdxUserRated]=sort(DUserRated,'descend');  % rearrange the obave distance
         IdxUserRated=idx_user_rated(IdxUserRated); % idx of rating items of the active user with fewer distance
         if length(idx_user_rated)<knear
             knear=length(idx_user_rated);
         end
         SimVecino=UserRated(1:knear);
         RateItem=data(user,IdxUserRated(1:knear));%ratings of the items in neigbors which have been rated by our active user
         MeanUser=sum(data(user,:))/length(nonzeros(data(user,:))); %mean rating of the active user
         RateItem=RateItem-MeanUser; %remove the mean from the rating value
         PreUserItem=(SimVecino*RateItem')/sum(SimVecino)+MeanUser;
     end

    
 

