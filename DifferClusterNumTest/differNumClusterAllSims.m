load ga
kcluster=[5 10 20 30 40 50];
for i=1:length(kcluster)
    [d] = AHPCoClusterUserSim(ga,kcluster(i),'correlation');
    resultName_u=['SimilitudCoClusterCorrelationUser', int2str(kcluster(i))];
    save(resultName_u, 'd')
    clear d resultName_u
    [d] = AHPCoClusterItemSim(ga,kcluster(i),'correlation');
    resultName_i=['SimilitudCoClusterCorrelationItem', int2str(kcluster(i))];
    save(resultName_i, 'd')
    clear d resultName_i
end