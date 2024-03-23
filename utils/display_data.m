function display_data(values_delay, values_backlog, values_time, nVals) 
    nVars = 6;
    
    dataSet = categorical([ones(nVars*nVals,1); ...
        ones(nVars*nVals,1)*2; ...
        ones(nVars*nVals,1)*3; ...
        ones(nVars*nVals,1)*4;...
        ones(nVars*nVals,1)*5;...
        ones(nVars*nVals,1)*6;...
        ones(nVars*nVals,1)*7;...
        ones(nVars*nVals,1)*8;...
        ]);
    dataSet = renamecats(dataSet,{'S12','S23','S13','S34','S45','S67','S78','S68'});
    
    clear var
    var(1:nVals,1) = "MCET";
    var(end+1:end+nVals,1) = "BCET";
    var(end+1:end+nVals,1) = "WCET";
    var(end+1:end+nVals,1) = "Alcuri";
    var(end+1:end+nVals,1) = "globalTBASCEM";
    var(end+1:end+nVals,1) = "localTBASCEM";
    Var = categorical([var;var;var;var;var;var;var;var]);
    
    testData = table(values_delay,dataSet,Var);
    testDataB = table(values_backlog,dataSet,Var);
    testDataTime = table(values_time,dataSet,Var);
    testData.values_delay(isinf(testData.values_delay)) = NaN;
    testDataB.values_backlog(isinf(testDataB.values_backlog)) = NaN;

    figure;
    boxchart(testDataTime.dataSet,testDataTime.values_time,"GroupByColor",testDataTime.Var, "MarkerStyle", 'none')
    legend(["Alcuri", "BCET", "MCET", "WCET", "globalTBASCEM", "localTBASCEM"],'Location','northoutside','Orientation','horizontal')
    xlabel("Servers");
    ylabel("Time in s");
    grid on
    ylim([0.1*min(testDataTime.values_time) 2*max(testDataTime.values_time)])
    set(gca, 'YScale', 'log')
    set(gca,'FontSize',24);
    set(gca,'linew',2);
    title('Time per algorithm');
    set(gca, 'FontName', 'Arial');

    figure;
    boxchart(testDataTime.Var,testDataTime.values_time)
    xlabel("Methods");
    ylabel("Time in s");
    grid on
    ylim([0.1*min(testDataTime.values_time) 2*max(testDataTime.values_time)])
    set(gca, 'YScale', 'log')
    set(gca,'FontSize',18);
    set(gca,'linew',2);
    title('Time per algorithm');
    set(gca, 'FontName', 'Arial');

    figure;
    boxchart(testData.dataSet,testData.values_delay,"GroupByColor",testData.Var, "MarkerStyle", 'none')
    legend(["Alcuri", "BCET", "MCET", "WCET", "globalTBASCEM", "localTBASCEM"],'Location','northoutside','Orientation','horizontal')
    xlabel("Servers");
    ylabel("Tightness Factor");
    grid on
    ylim([0.1*min(testData.values_delay) 2*max(testData.values_delay)])
    set(gca, 'YScale', 'log')
    set(gca,'FontSize',24);
    set(gca,'linew',2);
    title('Maximum Delay Tightness');
    set(gca, 'FontName', 'Arial');    
    
    figure;
    boxchart(testDataB.dataSet,testDataB.values_backlog,"GroupByColor",testDataB.Var, "MarkerStyle", 'none')
    legend(["Alcuri", "BCET", "MCET", "WCET", "globalTBASCEM", "localTBASCEM"],'Location','northoutside','Orientation','horizontal')
    xlabel("Servers");
    ylabel("Tightness Factor");
    grid on
    ylim([0.1*min(testDataB.values_backlog) 2*max(testDataB.values_backlog)])
    set(gca, 'YScale', 'log')
    set(gca,'FontSize',18);
    set(gca,'linew',2);
    title('Maximum Backlog Tightness');
    set(gca, 'FontName', 'Arial');
    
    %%% Plot all merged servers over the used method
    figure;
    boxchart(testData.Var,testData.values_delay)
    xlabel("Methods");
    grid on
    ylabel("Tightness Factor");
    ylim([0.1*min(testData.values_delay) 2*max(testData.values_delay)])
    set(gca, 'YScale', 'log')
    set(gca,'FontSize',24);
    set(gca,'linew',2);
    title('Maximum Delay Tightness');
    set(gca, 'FontName', 'Arial');
    
    figure;
    boxchart(testDataB.Var,testDataB.values_backlog)
    xlabel("Methods");
    ylabel("Tightness Factor");
    grid on
    ylim([0.1*min(testDataB.values_backlog) 2*max(testDataB.values_backlog)])
    set(gca, 'YScale', 'log')
    set(gca,'FontSize',18);
    set(gca,'linew',2);
    title('Maximum Backlog Tightness');
    set(gca, 'FontName', 'Arial');
end