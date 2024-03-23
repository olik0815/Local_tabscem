function queue_len=y_diff_2queues(t_T0,t_T1,y_T0,y_T1)
    queue_len=sortrows([t_T0,diff([0;y_T0]);t_T1,-diff([0;y_T1])],[1,2],{'ascend','descend'});   
    queue_len(:,2)=cumsum(queue_len(:,2));
    round(queue_len(:,1),6);
    [TRef_unique,ci,ca]=unique(queue_len(:,1),'last');
    queue_len=queue_len(ci,:);
end