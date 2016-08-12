load ga
iccluster=[5 10 20 30 40 50];
uccluster=[5 10 20 30 40 50];
for i=1:length(iccluster)
    for j=1:length(uccluster)
    [d] = AHPCoClusterItemSim(ga,iccluster(i),uccluster(i),'correlation');
    resultName_i=['SimilitudCoClusterCorrelationItem', int2str(iccluster(i)), int2str(uccluster(j))];
    save(resultName_i, 'd')
    clear d resultName_i
    end
end